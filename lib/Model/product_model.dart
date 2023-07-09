
class ProductModel {
    String? id;
    String? title;
    String? img;
    int? price;

    ProductModel({this.id, this.title, this.img, this.price});

    ProductModel.fromJson(Map<String, dynamic> json) {
        id = json["id"];
        title = json["title"];
        img = json["img"];
        price = json["price"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["id"] = id;
        _data["title"] = title;
        _data["img"] = img;
        _data["price"] = price;
        return _data;
    }

    ProductModel copyWith({
        String? id,
        String? title,
        String? img,
        int? price,
    }) => ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        img: img ?? this.img,
        price: price ?? this.price,
    );
}