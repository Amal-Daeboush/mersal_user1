/* import 'dart:convert';

class LatestProductModel {
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

    LatestProductModel({
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
    });

    factory LatestProductModel.fromRawJson(String str) => LatestProductModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LatestProductModel.fromJson(Map<String, dynamic> json) => LatestProductModel(
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
    };
}
 */