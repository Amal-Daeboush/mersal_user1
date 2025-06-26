import 'dart:convert';

class Order {
    int id;
    String userId;
    String totalPrice;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    Order({
        required this.id,
        required this.userId,
        required this.totalPrice,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        totalPrice: json["total_price"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_price": totalPrice,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}