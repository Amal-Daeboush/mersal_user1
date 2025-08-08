// To parse this JSON data, do
//
//     final orderProductModel = orderProductModelFromJson(jsonString);

import 'dart:convert';

OrderProductModel orderProductModelFromJson(String str) =>
    OrderProductModel.fromJson(json.decode(str));

String orderProductModelToJson(OrderProductModel data) =>
    json.encode(data.toJson());
    class OrderProductModel {
    int? orderId;
    String? note;
    String? deliveryFee;
    String? status;
    DateTime? createdAt;
    List<Product>? products;
    List<Coupon>? coupons;

    OrderProductModel({
        this.orderId,
        this.note,
        this.deliveryFee,
        this.status,
        this.createdAt,
        this.products,
        this.coupons,
    });

    OrderProductModel copyWith({
        int? orderId,
        String? note,
        String? deliveryFee,
        String? status,
        DateTime? createdAt,
        List<Product>? products,
        List<Coupon>? coupons,
    }) => 
        OrderProductModel(
            orderId: orderId ?? this.orderId,
            note: note ?? this.note,
            deliveryFee: deliveryFee ?? this.deliveryFee,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            products: products ?? this.products,
            coupons: coupons ?? this.coupons,
        );

    factory OrderProductModel.fromJson(Map<String, dynamic> json) => OrderProductModel(
        orderId: json["order_id"],
        note: json["note"],
        deliveryFee: json["delivery_fee"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        coupons: json["coupons"] == null ? [] : List<Coupon>.from(json["coupons"]!.map((x) => Coupon.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "note": note,
        "delivery_fee": deliveryFee,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x.toJson())),
    };
}

class Coupon {
    int? id;
    String? code;
    String? userId;
    String? discountPercent;
    String? status;
    DateTime? expiresAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    Pivot? pivot;

    Coupon({
        this.id,
        this.code,
        this.userId,
        this.discountPercent,
        this.status,
        this.expiresAt,
        this.createdAt,
        this.updatedAt,
        this.pivot,
    });

    Coupon copyWith({
        int? id,
        String? code,
        String? userId,
        String? discountPercent,
        String? status,
        DateTime? expiresAt,
        DateTime? createdAt,
        DateTime? updatedAt,
        Pivot? pivot,
    }) => 
        Coupon(
            id: id ?? this.id,
            code: code ?? this.code,
            userId: userId ?? this.userId,
            discountPercent: discountPercent ?? this.discountPercent,
            status: status ?? this.status,
            expiresAt: expiresAt ?? this.expiresAt,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            pivot: pivot ?? this.pivot,
        );

    factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        id: json["id"],
        code: json["code"],
        userId: json["user_id"],
        discountPercent: json["discount_percent"],
        status: json["status"],
        expiresAt: json["expires_at"] == null ? null : DateTime.parse(json["expires_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "user_id": userId,
        "discount_percent": discountPercent,
        "status": status,
        "expires_at": expiresAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
    };
}

class Pivot {
    String? orderId;
    String? couponId;
    String? discountAmount;
    DateTime? createdAt;
    DateTime? updatedAt;

    Pivot({
        this.orderId,
        this.couponId,
        this.discountAmount,
        this.createdAt,
        this.updatedAt,
    });

    Pivot copyWith({
        String? orderId,
        String? couponId,
        String? discountAmount,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Pivot(
            orderId: orderId ?? this.orderId,
            couponId: couponId ?? this.couponId,
            discountAmount: discountAmount ?? this.discountAmount,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        orderId: json["order_id"],
        couponId: json["coupon_id"],
        discountAmount: json["discount_amount"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "coupon_id": couponId,
        "discount_amount": discountAmount,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class Product {
    int? orderProductId;
    String? productId;
    String? productName;
    String? totalPrice;
    String? quantity;
    String? status;
    List<ProductImage>? productImages;
    Discount? discount;

    Product({
        this.orderProductId,
        this.productId,
        this.productName,
        this.totalPrice,
        this.quantity,
        this.status,
        this.productImages,
        this.discount,
    });

    Product copyWith({
        int? orderProductId,
        String? productId,
        String? productName,
        String? totalPrice,
        String? quantity,
        String? status,
        List<ProductImage>? productImages,
        Discount? discount,
    }) => 
        Product(
            orderProductId: orderProductId ?? this.orderProductId,
            productId: productId ?? this.productId,
            productName: productName ?? this.productName,
            totalPrice: totalPrice ?? this.totalPrice,
            quantity: quantity ?? this.quantity,
            status: status ?? this.status,
            productImages: productImages ?? this.productImages,
            discount: discount ?? this.discount,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        orderProductId: json["order_product_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        totalPrice: json["total_price"],
        quantity: json["quantity"],
        status: json["status"],
        productImages: json["product_images"] == null ? [] : List<ProductImage>.from(json["product_images"]!.map((x) => ProductImage.fromJson(x))),
        discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    );

    Map<String, dynamic> toJson() => {
        "order_product_id": orderProductId,
        "product_id": productId,
        "product_name": productName,
        "total_price": totalPrice,
        "quantity": quantity,
        "status": status,
        "product_images": productImages == null ? [] : List<dynamic>.from(productImages!.map((x) => x.toJson())),
        "discount": discount?.toJson(),
    };
}

class Discount {
    int? id;
    String? status;
    String? productId;
    String? value;
    DateTime? fromtime;
    DateTime? totime;
    String? providerable1Type;
    String? providerable1Id;
    DateTime? createdAt;
    DateTime? updatedAt;

    Discount({
        this.id,
        this.status,
        this.productId,
        this.value,
        this.fromtime,
        this.totime,
        this.providerable1Type,
        this.providerable1Id,
        this.createdAt,
        this.updatedAt,
    });

    Discount copyWith({
        int? id,
        String? status,
        String? productId,
        String? value,
        DateTime? fromtime,
        DateTime? totime,
        String? providerable1Type,
        String? providerable1Id,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Discount(
            id: id ?? this.id,
            status: status ?? this.status,
            productId: productId ?? this.productId,
            value: value ?? this.value,
            fromtime: fromtime ?? this.fromtime,
            totime: totime ?? this.totime,
            providerable1Type: providerable1Type ?? this.providerable1Type,
            providerable1Id: providerable1Id ?? this.providerable1Id,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        status: json["status"],
        productId: json["product_id"],
        value: json["value"],
        fromtime: json["fromtime"] == null ? null : DateTime.parse(json["fromtime"]),
        totime: json["totime"] == null ? null : DateTime.parse(json["totime"]),
        providerable1Type: json["providerable1_type"],
        providerable1Id: json["providerable1_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "product_id": productId,
        "value": value,
        "fromtime": fromtime?.toIso8601String(),
        "totime": totime?.toIso8601String(),
        "providerable1_type": providerable1Type,
        "providerable1_id": providerable1Id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}

class ProductImage {
    int? imageId;
    String? imageUrl;

    ProductImage({
        this.imageId,
        this.imageUrl,
    });

    ProductImage copyWith({
        int? imageId,
        String? imageUrl,
    }) => 
        ProductImage(
            imageId: imageId ?? this.imageId,
            imageUrl: imageUrl ?? this.imageUrl,
        );

    factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        imageId: json["image_id"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "image_id": imageId,
        "image_url": imageUrl,
    };
}
