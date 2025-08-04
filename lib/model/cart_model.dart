
import 'package:mersal/model/products_model.dart';

class CartModel {
  final ProductModel productModel;
  final int quantityInCart;

  CartModel({
    required this.productModel,
    required this.quantityInCart,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productModel: ProductModel.fromJson(json['product']),
        quantityInCart: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
        'product': productModel.toJson(),
        'quantity': quantityInCart,
      };
}
