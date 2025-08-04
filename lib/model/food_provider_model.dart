// To parse this JSON data, do
//
//     final foodProviderModel = foodProviderModelFromJson(jsonString);

import 'dart:convert';

FoodProviderModel foodProviderModelFromJson(String str) => FoodProviderModel.fromJson(json.decode(str));

String foodProviderModelToJson(FoodProviderModel data) => json.encode(data.toJson());

class FoodProviderModel {
    final ProviderFood providerFood;
    final User user;
    final List<Product> products;

    FoodProviderModel({
        required this.providerFood,
        required this.user,
        required this.products,
    });

    factory FoodProviderModel.fromJson(Map<String, dynamic> json) => FoodProviderModel(
        providerFood: ProviderFood.fromJson(json["provider_food"]),
        user: User.fromJson(json["user"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "provider_food": providerFood.toJson(),
        "user": user.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    final int id;
    final String name;
    final String price;

    Product({
        required this.id,
        required this.name,
        required this.price,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
    };
}

class ProviderFood {
    final int id;
    final String status;
    final dynamic image;
    final dynamic address;
    final dynamic lang;
    final dynamic lat;

    ProviderFood({
        required this.id,
        required this.status,
        required this.image,
        required this.address,
        required this.lang,
        required this.lat,
    });

    factory ProviderFood.fromJson(Map<String, dynamic> json) => ProviderFood(
        id: json["id"],
        status: json["status"],
        image: json["image"],
        address: json["address"],
        lang: json["lang"],
        lat: json["lat"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "image": image,
        "address": address,
        "lang": lang,
        "lat": lat,
    };
}

class User {
    final int id;
    final String name;
    final String email;
    final String nationalId;
    final String imageNationalId;

    User({
        required this.id,
        required this.name,
        required this.email,
        required this.nationalId,
        required this.imageNationalId,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        nationalId: json["national_id"],
        imageNationalId: json["image_national_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "national_id": nationalId,
        "image_national_id": imageNationalId,
    };
}
