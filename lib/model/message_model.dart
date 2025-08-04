import 'dart:convert';

class MessageModel {
    String message;
    String senderId;
    String receiverId;
    DateTime createdAt;  final bool isSending;

    MessageModel( {this.isSending=false,
        required this.message,
        required this.senderId,
        required this.receiverId,
        required this.createdAt,
    });

    factory MessageModel.fromRawJson(String str) => MessageModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
     createdAt: DateTime.parse(json['created_at']).toLocal(),

    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt.toIso8601String(),
    };
}
