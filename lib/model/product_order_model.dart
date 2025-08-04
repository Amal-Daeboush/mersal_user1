// To parse this JSON data, do
//
//     final orderProductModel = orderProductModelFromJson(jsonString);

import 'dart:convert';

OrderProductModel orderProductModelFromJson(String str) => OrderProductModel.fromJson(json.decode(str));

String orderProductModelToJson(OrderProductModel data) => json.encode(data.toJson());

class OrderProductModel {
    final int id;
    final String userId;
    final int originalTotalPrice;
    final String totalPrice;
    final bool couponApplied;
    final int couponDiscount;
    final String? couponCode;
    final String? couponDiscountPercent;
    final String status;
    final DateTime createdAt;
    final List<Product> products;

    OrderProductModel({
        required this.id,
        required this.userId,
        required this.originalTotalPrice,
        required this.totalPrice,
        required this.couponApplied,
        required this.couponDiscount,
        required this.couponCode,
        required this.couponDiscountPercent,
        required this.status,
        required this.createdAt,
        required this.products,
    });

    factory OrderProductModel.fromJson(Map<String, dynamic> json) => OrderProductModel(
        id: json["id"],
        userId: json["user_id"],
        originalTotalPrice: json["original_total_price"],
        totalPrice: json["total_price"],
        couponApplied: json["coupon_applied"],
        couponDiscount: json["coupon_discount"],
        couponCode: json["coupon_code"],
        couponDiscountPercent: json["coupon_discount_percent"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "original_total_price": originalTotalPrice,
        "total_price": totalPrice,
        "coupon_applied": couponApplied,
        "coupon_discount": couponDiscount,
        "coupon_code": couponCode,
        "coupon_discount_percent": couponDiscountPercent,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    final int id;
    final int productId;
    final String productName;
    final String quantity;
    final String originalUnitPrice;
    final dynamic finalUnitPrice;
    final bool discountApplied;
    final dynamic discountValue;
    final dynamic totalPrice;
    final String status;

    Product({
        required this.id,
        required this.productId,
        required this.productName,
        required this.quantity,
        required this.originalUnitPrice,
        required this.finalUnitPrice,
        required this.discountApplied,
        required this.discountValue,
        required this.totalPrice,
        required this.status,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        originalUnitPrice: json["original_unit_price"],
        finalUnitPrice: json["final_unit_price"],
        discountApplied: json["discount_applied"],
        discountValue: json["discount_value"],
        totalPrice: json["total_price"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "original_unit_price": originalUnitPrice,
        "final_unit_price": finalUnitPrice,
        "discount_applied": discountApplied,
        "discount_value": discountValue,
        "total_price": totalPrice,
        "status": status,
    };
}
