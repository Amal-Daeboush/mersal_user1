// To parse this JSON data, do
//
//     final serviceReservationModel = serviceReservationModelFromJson(jsonString);

import 'dart:convert';

ServiceReservationModel serviceReservationModelFromJson(String str) => ServiceReservationModel.fromJson(json.decode(str));

String serviceReservationModelToJson(ServiceReservationModel data) => json.encode(data.toJson());


class ServiceReservationModel {
    final int id;
    final int userId; 
    final int productId;
    final String status;
    final String totalPrice;
    final String originalPrice;
    final String productDiscountApplied;
    final String productDiscountValue;
    final String? productDiscountType;
    final String couponApplied;
    final String couponDiscount;
    final String? couponCode;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Product product;

    ServiceReservationModel({
        required this.id,
        required this.userId,
        required this.productId,
        required this.status,
        required this.totalPrice,
        required this.originalPrice,
        required this.productDiscountApplied,
        required this.productDiscountValue,
        required this.productDiscountType,
        required this.couponApplied,
        required this.couponDiscount,
        required this.couponCode,
        required this.createdAt,
        required this.updatedAt,
        required this.product,
    });

    factory ServiceReservationModel.fromJson(Map<String, dynamic> json) => ServiceReservationModel(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        status: json["status"],
        totalPrice: json["total_price"],
        originalPrice: json["original_price"],
        productDiscountApplied: json["product_discount_applied"],
        productDiscountValue: json["product_discount_value"],
        productDiscountType: json["product_discount_type"],
        couponApplied: json["coupon_applied"],
        couponDiscount: json["coupon_discount"],
        couponCode: json["coupon_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "status": status,
        "total_price": totalPrice,
        "original_price": originalPrice,
        "product_discount_applied": productDiscountApplied,
        "product_discount_value": productDiscountValue,
        "product_discount_type": productDiscountType,
        "coupon_applied": couponApplied,
        "coupon_discount": couponDiscount,
        "coupon_code": couponCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "product": product.toJson(),
    };
}

class Product {
    final int id;
    final String name;
    final int categoryId;
    final String description;
    final String price;
    final String providerableType;
    final int providerableId;
    final dynamic quantity;
    final String timeOfService;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;
    final List<Image> images;

    Product({
        required this.id,
        required this.name,
        required this.categoryId,
        required this.description,
        required this.price,
        required this.providerableType,
        required this.providerableId,
        required this.quantity,
        required this.timeOfService,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.images,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        description: json["description"],
        price: json["price"],
        providerableType: json["providerable_type"],
        providerableId: json["providerable_id"],
        quantity: json["quantity"],
        timeOfService: json["time_of_service"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "description": description,
        "price": price,
        "providerable_type": providerableType,
        "providerable_id": providerableId,
        "quantity": quantity,
        "time_of_service": timeOfService,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    final int id;
    final int productId;
    final String imag;
    final DateTime createdAt;
    final DateTime updatedAt;

    Image({
        required this.id,
        required this.productId,
        required this.imag,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        imag: json["imag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "imag": imag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}