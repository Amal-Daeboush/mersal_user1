import 'dart:convert';

class NotificationModel {
  String image;
  String text;
  DateTime date;
  String redirection;
  bool isRead;

  NotificationModel(
      {required this.image,
      required this.text,
      required this.date,
      required this.redirection,
      required this.isRead});

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          image: json["image"],
          text: json["text"],
          date: DateTime.parse(json["data"]), // Convert string to DateTime
          redirection: json["redirection"],
          isRead: json['isRead']);

  Map<String, dynamic> toJson() => {
        "image": image,
        "text": text,
        "data": date,
        "redirection": redirection,
        'isread': isRead
      };
}