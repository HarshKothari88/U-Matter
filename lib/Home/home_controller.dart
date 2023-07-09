import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:pedometer/pedometer.dart';
import 'package:u_matter/Auth/auth_controller.dart';
import 'package:u_matter/Coins/coins_controller.dart';
import 'package:u_matter/Data/firebase_var.dart';
import 'package:u_matter/Model/banner_model.dart';
import 'package:u_matter/Model/cart_model.dart';
import 'package:u_matter/Model/post_model.dart';
import 'package:u_matter/Model/product_model.dart';
import 'package:u_matter/Model/tasks_model.dart';
import 'package:u_matter/Model/user_model.dart';
import 'package:u_matter/Utilities/snackbar.dart';

class HomeController extends GetxController {
  AuthController authController = Get.find();

  double height = 0.0;
  double weight = 0.0;
  int age = 0;
  var gender = ''.obs;

  //TASKS VARIABLES
  final taskFormKey = GlobalKey<FormState>();
  final title = TextEditingController();
  final desc = TextEditingController();
  var taskModelList = <TasksModel>[].obs;
  var showTasks = true.obs;

//PRODUCTS VARAIBLES
  final productsModelList = <ProductModel>[].obs;
  var showCart = true.obs;
  var cartPrice = 0.obs;
  var cartList = <ProductModel>[].obs;
  final firebaseStorage = FirebaseStorage.instance;

  //POST VARIABLES

  final postFormKey = GlobalKey<FormState>();
  final postTitle = TextEditingController();
  var postImg = ''.obs;
  var showPost = 'load'.obs;
  final postModelList = <PostsModel>[].obs;
  var follow = <String>[].obs;

  //HEALTH VARIABLES
  var bmi = 0.0.obs;
  var bmr = 0.0.obs;
  var ibw = 0.0.obs;
  var activityFactor = 1.obs;
  var activity = 'Low Physical Activity'.obs;

  List<String> activityList = [
    "Low Physical Activity",
    "Average Physical Activity",
    "Heavy Physical Activity"
  ];

  final coinController = Get.put<CoinController>(CoinController());
  var bannerModelList = <BannerModel>[].obs;
  final _auth = FirebaseAuth.instance;
  final _bannerCollection =
      FirebaseFirestore.instance.collection(DBPathName.banners);
  final _userCollection =
      FirebaseFirestore.instance.collection(DBPathName.users);
  final _tasksCollection =
      FirebaseFirestore.instance.collection(DBPathName.tasks);
  final _productCollection =
      FirebaseFirestore.instance.collection(DBPathName.products);
  final _cartCollection =
      FirebaseFirestore.instance.collection(DBPathName.cart);
  final postCollection =
      FirebaseFirestore.instance.collection(DBPathName.posts);
  final _followCollection =
      FirebaseFirestore.instance.collection(DBPathName.follows);

  //PEDOMETER
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  var status = 'Stopped'.obs, steps = 0.obs;

  Future<List<BannerModel>> getBanners() async {
    _bannerCollection.get().then((snapshot) {
      Map<String, dynamic>? map;
      if (snapshot.size != 0) {
        for (var doc in snapshot.docs) {
          map = doc.data();
          bannerModelList.add(BannerModel.fromJson(map));
        }
      }
    });
    return bannerModelList;
  }

  //PEDOMETER FUNCTIONS
  void onStepCount(StepCount event) {
    debugPrint(event.steps.toString());
    steps.value = event.steps;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    status.value = event.status;
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    status.value = 'Pedestrian Status not available';
    print(status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    status.value = 'Step Count not available';
  }

  Future<void> getUserHealthData() async {
    _userCollection.doc(_auth.currentUser!.uid).get().then((doc) {
      UserModel user = UserModel(
          gender: doc.data()!["gender"],
          age: doc.data()!['age'],
          height: doc.data()!["height"],
          weight: doc.data()!["weight"]);
      age = user.age!;
      height = user.height!.toDouble();
      weight = user.weight!.toDouble();
      gender.value = user.gender!;
      debugPrint("HEALTH $age.value $height.value");
      bmi.value =
          double.parse(calculateBMI(weight, height / 100).toStringAsFixed(1));
      calcCalorie(
          weight, height / 100, age, activityFactor.value, gender.value);
      ibw.value = double.parse(
          idealBodyWeight(gender.value, height).toStringAsFixed(0));
    });
  }

  void initPedometer() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!isClosed) return;
  }

  //HEALTH DATA CALC
  double cmToMeter(double cm) {
    return cm / 100;
  }

  double calculateBMI(double weight, double height) {
    return weight / (height * height);
  }

  double calculateBMR(
      double weight, double height, int age, int activityLevel, String gender) {
    double bmr;
    if (gender == 'Male') {
      bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
    } else {
      bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
    }
    double activityFactor;

    switch (activityLevel) {
      case 1:
        activityFactor = 1.2;
        break;
      case 2:
        activityFactor = 1.3;
        break;
      case 3:
        activityFactor = 1.4;
        break;
      default:
        activityFactor = 1.2;
    }

    return bmr * activityFactor;
  }

  double idealBodyWeight(String gender, double height) {
    if (gender == "Male") {
      return 50 + (0.91 * (height - 152.4));
    } else if (gender == "Female") {
      return 45.5 + (0.91 * (height - 152.4));
    } else {
      return 0.0;
    }
  }

  void calcCalorie(
      double weight, double height, int age, int activityLevel, String gender) {
    bmr.value = double.parse(
        calculateBMR(weight, height, age, activityLevel, gender)
            .toStringAsFixed(0));
  }

  Future calculateBmi() async {
    double h = height * height;
    bmi.value = weight / h;
    debugPrint("BMI : ${cmToMeter(height)} ");
  }

  //TASKS FUNCTION

  Future<void> addTasks() async {
    TasksModel task =
        TasksModel(completed: false, title: title.text, desc: desc.text);
    _tasksCollection
        .doc(_auth.currentUser!.uid)
        .collection("task")
        .add(task.toJson())
        .then((value) => {title.text = "", desc.text = "", toggleTaskViewer()});
  }

  Future<void> taskCompleted(String id) async {
    await _tasksCollection
        .doc(_auth.currentUser!.uid)
        .collection("task")
        .doc(id)
        .set({"completed": true}, SetOptions(merge: true)).then((value) => {
              coinController.updateCoins(5),
              setSnackBar(
                  'Woohoo!!', 'You earned 5 Coins for completing the tasks',
                  icon: Icon(Icons.celebration_rounded),
                  position: SnackPosition.BOTTOM),
              toggleTaskViewer()
            });
  }

  Future<void> deleteTask(String id) async {
    await _tasksCollection
        .doc(_auth.currentUser!.uid)
        .collection("task")
        .doc(id)
        .delete()
        .then((value) => toggleTaskViewer());
  }

  void toggleTaskViewer() {
    showTasks.toggle();
    showTasks.toggle();
  }

  Future<List<TasksModel>> getTasks() async {
    Map<String, dynamic> map;
    List<TasksModel> task = [];
    await _tasksCollection
        .doc(_auth.currentUser!.uid)
        .collection("task")
        .get()
        .then((snapshot) {
      if (snapshot.size != 0) {
        for (var doc in snapshot.docs) {
          map = doc.data();
          task.add(TasksModel.fromJson(map).copyWith(id: doc.reference.id));
        }
      }
    });
    taskModelList.assignAll(task);
    return taskModelList;
  }

  //SHOP SECTION FUNCTION

  Future<List<ProductModel>> getProducts() async {
    Map<String, dynamic> map;
    productsModelList.clear();
    await _productCollection.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        map = doc.data();
        productsModelList
            .add(ProductModel.fromJson(map).copyWith(id: doc.reference.id));
      }
    });
    return productsModelList;
  }

  Future<void> addToCart(
      {required String title, required String img, required int price}) async {
    ProductModel cartItem = ProductModel(title: title, price: price, img: img);
    _cartCollection
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .add(cartItem.toJson())
        .then((value) => {
              setSnackBar(
                  "Item added to your cart", "Checkout your cart for purchase",
                  icon: const Icon(Icons.check_circle_outline_rounded))
            });
  }

  // Future<void> cartOrder(
  //     {required String title, required String img, required int price}) async {
  //   ProductModel orderItem = ProductModel(title: title, price: price, img: img);
  //   _corderCollection
  //       .doc(_auth.currentUser!.uid)
  //       .collection("orders")
  //       .add(orderItem.toJson())
  //       .then((value) => {
  //             setSnackBar(
  //                 "Item added to your cart", "Checkout your cart for purchase",
  //                 icon: const Icon(Icons.check_circle_outline_rounded))
  //           });
  // }

  Future<void> deleteCart(String id) async {
    _cartCollection
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .doc(id)
        .delete()
        .then((value) => {
              setSnackBar("Item deleted from your cart", "Successfully removed",
                  icon: const Icon(Icons.delete)),
            });
    toggleCartViewer();
  }

  Future<void> purchaseCart(int coins) async {
    if (coinController.coins.value > coins) {
      _cartCollection
          .doc(_auth.currentUser!.uid)
          .collection("cart")
          .get()
          .then((docs) {
        for (var doc in docs.docs) {
          doc.reference.delete();
        }
        coinController.decrementCoins(coins);
        setSnackBar("Your Purchase is successful", "Cart has been cleared",
            icon: const Icon(Icons.local_mall), dismissible: false);
      });
    } else {
      setSnackBar(
          'No enough coins available', 'Earn them by completing the goals',
          icon: Icon(Icons.adjust));
    }
    toggleCartViewer();
  }

  // Future<ProductModel> getCartProduct(String id) async {
  //   ProductModel product = ProductModel();
  //   await _productCollection.doc(id).get().then((data) {
  //     product = ProductModel(
  //         id: id,
  //         title: data.data()!['title'],
  //         price: data.data()!['price'],
  //         img: data.data()!['img']);
  //   });
  //   return product;
  // }

  Future<List<ProductModel>> getCartList() async {
    cartList.clear();
    Map<String, dynamic> map;
    await _cartCollection
        .doc(_auth.currentUser!.uid)
        .collection("cart")
        .get()
        .then((docs) {
      if (docs.size != 0) {
        for (var doc in docs.docs) {
          map = doc.data();
          debugPrint("CART ITEM ${doc.data()}");
          cartList
              .add(ProductModel.fromJson(map).copyWith(id: doc.reference.id));
        }
      } else
        debugPrint("NO CART");
    });
    return cartList;
  }

  void toggleCartViewer() {
    showCart.value = !showCart.value;
    showCart.value = !showCart.value;
  }

  //POST FUNCTIONS
  void togglePostViewer() {
    showPost.value = 'p';
    showPost.value = 'load';
  }

  Future<void> uploadPost() async {
    PostsModel post = PostsModel(
      uid: _auth.currentUser!.uid,
      name: _auth.currentUser!.displayName,
      profileImg: _auth.currentUser!.photoURL,
      caption: postTitle.text,
      img: postImg.value,
      likes: 0,
      time: DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now()),
    );
    postCollection.add(post.toJson()).then((value) => {
          Get.back(),
          setSnackBar("Yoohooo!!", "Your new post has been uploaded",
              icon: const Icon(Icons.celebration_rounded)),
        });
  }

  Future<void> updateLikes(String id, int likes) async {
    postCollection.doc(id).set({
      "likes": likes,
    }, SetOptions(merge: true));
  }

  Future<void> followUser(String id) async {
    _followCollection
        .doc(_auth.currentUser!.uid)
        .collection('my_follows')
        .add({"id": id}).then((value) => getFollowList());
  }

  Future<List<String>> getFollowList() async {
    follow.clear();
    _followCollection
        .doc(_auth.currentUser!.uid)
        .collection('my_follows')
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        follow.add(doc.data()['id']);
      }
    });
    return follow;
  }

  File? photo;
  final ImagePicker picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
  }

  Future imgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
    }
  }

  Future uploadFile() async {
    if (photo == null) return;
    final fileName = basename(photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref(destination).child('file/');
      await ref.putFile(photo!).then((p0) async {
        postImg.value = await ref.getDownloadURL();
      });
    } catch (e) {
      print('error occured');
    }
  }

  @override
  void onInit() {
    initPedometer();
    steps.listen((v) {
      debugPrint("available coin is updated");
      coinController.updateAvailableCoins(v);
    });
    getUserHealthData();

    super.onInit();
  }
}
