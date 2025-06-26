// To parse this JSON data, do
//
//     final productProvidersModel = productProvidersModelFromJson(jsonString);

import 'dart:convert';

ProductProvidersModel productProvidersModelFromJson(String str) => ProductProvidersModel.fromJson(json.decode(str));

String productProvidersModelToJson(ProductProvidersModel data) => json.encode(data.toJson());

class ProductProvidersModel {
    final List<ProductProviderModel> data;
    final Pagination pagination;
    final String message;

    ProductProvidersModel({
        required this.data,
        required this.pagination,
        required this.message,
    });

    factory ProductProvidersModel.fromJson(Map<String, dynamic> json) => ProductProvidersModel(
        data: List<ProductProviderModel>.from(json["data"].map((x) => ProductProviderModel.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "message": message,
    };
}

class ProductProviderModel {
    final Vendor vendor;
    final User user;
    final dynamic message;

    ProductProviderModel({
        required this.vendor,
        required this.user,
        required this.message,
    });

    factory ProductProviderModel.fromJson(Map<String, dynamic> json) => ProductProviderModel(
        vendor: Vendor.fromJson(json["vendor"]),
        user: User.fromJson(json["user"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "vendor": vendor.toJson(),
        "user": user.toJson(),
        "message": message,
    };
}

class User {
    final int id;
    final String name;
    final String email;
    final String nationalId;
    final String? imageNationalId;

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

class Vendor {
    final int id;
    final String status;
    final dynamic image;
    final dynamic address;
    final dynamic lang;
    final dynamic lat;

    Vendor({
        required this.id,
        required this.status,
        required this.image,
        required this.address,
        required this.lang,
        required this.lat,
    });

    factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
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

class Pagination {
    final int currentPage;
    final int lastPage;
    final int perPage;
    final int total;

    Pagination({
        required this.currentPage,
        required this.lastPage,
        required this.perPage,
        required this.total,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
    };
}
