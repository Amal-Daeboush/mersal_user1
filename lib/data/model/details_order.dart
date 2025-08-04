// To parse this JSON data, do
//
//     final detailsOrderModel = detailsOrderModelFromJson(jsonString);

import 'dart:convert';

DetailsOrderModel detailsOrderModelFromJson(String str) => DetailsOrderModel.fromJson(json.decode(str));

String detailsOrderModelToJson(DetailsOrderModel data) => json.encode(data.toJson());

class DetailsOrderModel {
    Order? order;

    DetailsOrderModel({
        this.order,
    });

    DetailsOrderModel copyWith({
        Order? order,
    }) => 
        DetailsOrderModel(
            order: order ?? this.order,
        );

    factory DetailsOrderModel.fromJson(Map<String, dynamic> json) => DetailsOrderModel(
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "order": order?.toJson(),
    };
}

class Order {
    int? orderId;
    String? status;
    String? totalPrice;
    String? deliveryFee;
    DateTime? createdAt;
    List<Product>? products;
    List<Driver>? drivers;

    Order({
        this.orderId,
        this.status,
        this.totalPrice,
        this.deliveryFee,
        this.createdAt,
        this.products,
        this.drivers,
    });

    Order copyWith({
        int? orderId,
        String? status,
        String? totalPrice,
        String? deliveryFee,
        DateTime? createdAt,
        List<Product>? products,
        List<Driver>? drivers,
    }) => 
        Order(
            orderId: orderId ?? this.orderId,
            status: status ?? this.status,
            totalPrice: totalPrice ?? this.totalPrice,
            deliveryFee: deliveryFee ?? this.deliveryFee,
            createdAt: createdAt ?? this.createdAt,
            products: products ?? this.products,
            drivers: drivers ?? this.drivers,
        );

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        orderId: json["order_id"],
        status: json["status"],
        totalPrice: json["total_price"],
        deliveryFee: json["delivery_fee"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        drivers: json["drivers"] == null ? [] : List<Driver>.from(json["drivers"]!.map((x) => Driver.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "status": status,
        "total_price": totalPrice,
        "delivery_fee": deliveryFee,
        "created_at": createdAt?.toIso8601String(),
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "drivers": drivers == null ? [] : List<dynamic>.from(drivers!.map((x) => x.toJson())),
    };
}

class Driver {
    String? driverId;
    String? driverName;
    dynamic phone;
    String? status;
    Location? location;

    Driver({
        this.driverId,
        this.driverName,
        this.phone,
        this.status,
        this.location,
    });

    Driver copyWith({
        String? driverId,
        String? driverName,
        dynamic phone,
        String? status,
        Location? location,
    }) => 
        Driver(
            driverId: driverId ?? this.driverId,
            driverName: driverName ?? this.driverName,
            phone: phone ?? this.phone,
            status: status ?? this.status,
            location: location ?? this.location,
        );

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverId: json["driver_id"],
        driverName: json["driver_name"],
        phone: json["phone"],
        status: json["status"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "driver_id": driverId,
        "driver_name": driverName,
        "phone": phone,
        "status": status,
        "location": location?.toJson(),
    };
}

class Location {
    String? lat;
    String? lang;

    Location({
        this.lat,
        this.lang,
    });

    Location copyWith({
        String? lat,
        String? lang,
    }) => 
        Location(
            lat: lat ?? this.lat,
            lang: lang ?? this.lang,
        );

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lang: json["lang"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lang": lang,
    };
}

class Product {
  String? productId;
    String? name;
    String? quantity;
    dynamic price;
    String? status;

    Product({
        this.productId,
        this.name,
        this.quantity,
        this.price,
        this.status,
    });

    Product copyWith({
        String? productId,
        String? name,
        String? quantity,
        dynamic price,
        String? status,
    }) => 
        Product(
            productId: productId ?? this.productId,
            name: name ?? this.name,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
            status: status ?? this.status,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["product_id"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "quantity": quantity,
        "price": price,
        "status": status,
    };
}
