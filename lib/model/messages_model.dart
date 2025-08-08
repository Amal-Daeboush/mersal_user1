import 'dart:convert';

import 'package:mersal/model/message_model.dart';

class MessagesModel {
  int id;
  String name;
  DateTime lastMessageAt;
  int? unreadCount;

  MessagesModel({
    required this.id,
    required this.name,
    this.unreadCount,
    required this.lastMessageAt,
  });

  factory MessagesModel.fromRawJson(String str) =>
      MessagesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
    id: json["id"],
    name: json["name"],
    lastMessageAt: DateTime.parse(json["last_message_at"]),
    unreadCount: json["unread_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "last_message_at": lastMessageAt.toIso8601String(),
    "unread_count": unreadCount,
  };
  MessageModel toMessageModel() {
    return MessageModel(
      message: "[رسالة غير متاحة]",
      senderId: id.toString(),
      receiverId: '',
      createdAt: lastMessageAt,
    );
  }
}
