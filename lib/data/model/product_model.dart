/* import 'dart:convert';

class ProductModel {
    int id;
    String name;
    int categoryId;
    String description;
    String price;
    String providerableType;
    int providerableId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;
    List<Image> images;
    Category category;

    ProductModel({
        required this.id,
        required this.name,
        required this.categoryId,
        required this.description,
        required this.price,
        required this.providerableType,
        required this.providerableId,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.images,
        required this.category,
    });

    factory ProductModel.fromRawJson(String str) => ProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        description: json["description"],
        price: json["price"],
        providerableType: json["providerable_type"],
        providerableId: json["providerable_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        category: Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "description": description,
        "price": price,
        "providerable_type": providerableType,
        "providerable_id": providerableId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "category": category.toJson(),
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
 */