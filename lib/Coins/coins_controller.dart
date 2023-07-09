import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:u_matter/Home/home_controller.dart';

class CoinController extends GetxController {
  var coins = 0.obs;
  final appData = GetStorage();
  var available = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    coins.value = appData.read('coins') ?? 2;
  }

  Future updateCoins(int count) async {
    coins.value += count;
    await appData.write('coins', coins.value);
    coins.refresh();
  }

  Future decrementCoins(int count) async {
    coins.value -= count;
    await appData.write('coins', coins.value);
    coins.refresh();
  }

  Future updateAvailableCoins(int steps) async {
    available.value = double.parse((steps * 0.001).toStringAsFixed(1));
  }
}
