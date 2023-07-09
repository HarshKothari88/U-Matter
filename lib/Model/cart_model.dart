
class CartModel {
    String? cartId;
    String? productId;

    CartModel({this.cartId, this.productId});

    CartModel.fromJson(Map<String, dynamic> json) {
        cartId = json["cartId"];
        productId = json["productId"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["cartId"] = cartId;
        _data["productId"] = productId;
        return _data;
    }

    CartModel copyWith({
        String? cartId,
        String? productId,
    }) => CartModel(
        cartId: cartId ?? this.cartId,
        productId: productId ?? this.productId,
    );
}