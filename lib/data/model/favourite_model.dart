import 'dart:convert';

class FavouriteModel {
    int id;
    String name;
    String description;
    String price;
    Category category;
    List<Image> images;
    DateTime createdAt;
    DateTime updatedAt;
    bool isFavourite;

    FavouriteModel({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.category,
        required this.images,
        required this.createdAt,
        required this.updatedAt,
        required this.isFavourite,
    });

    factory FavouriteModel.fromRawJson(String str) => FavouriteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        category: Category.fromJson(json["category"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isFavourite: json["is_favourite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category": category.toJson(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "is_favourite": isFavourite,
    };
}

class Category {
    int id;
    String name;
    String type;
    String price;
    dynamic imag;
    DateTime createdAt;
    DateTime updatedAt;

    Category({
        required this.id,
        required this.name,
        required this.type,
        required this.price,
        required this.imag,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        price: json["price"],
        imag: json["imag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "price": price,
        "imag": imag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Image {
    int id;
    int productId;
    String imag;
    DateTime createdAt;
    DateTime updatedAt;

    Image({
        required this.id,
        required this.productId,
        required this.imag,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

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
