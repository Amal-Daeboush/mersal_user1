import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/constant/const_data.dart';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../../../core/class/crud.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/api_links.dart';
import '../../../data/model/message_model.dart';

class YourChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  TextEditingController messageController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  Crud crud = Crud();
  String id;

  late PusherChannelsFlutter pusher;

  final _chatStreamController =
      StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get chatStream => _chatStreamController.stream;

  YourChatController({required this.id});

  @override
  void onInit() {
    super.onInit();
    getConversation();
    initPusher();
  }

  String getChatChannelName(String user1, String user2) {
    final ids = [user1, user2]..sort(); // ترتيب ثابت
    return 'chat-private-channel-${ids[0]}-${ids[1]}';
  }

  Future<void> getConversation() async {
    var response = await crud.getData(
      '${ApiLinks.getConversation}/$id',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        update();
      },
      (data) {
        if (data == null || (data is Map && data.containsKey("message"))) {
          statusRequest = StatusRequest.failure;
          messages.clear();

          // ⬅️ أضف هذه السطر لإرسال قيمة فارغة لـ Stream
          if (!_chatStreamController.isClosed) {
            _chatStreamController.add([]);
          }
        } else if (data is List) {
          List<MessageModel> newMessages =
              data.map((item) => MessageModel.fromJson(item)).toList();
          messages.assignAll(newMessages);
          if (!_chatStreamController.isClosed) {
            _chatStreamController.add(newMessages);
          }
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          messages.clear();
        }
        update();
      },
    );
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter();

    await pusher.init(
      apiKey: "af4ff5b03e590e827cbe",
      cluster: "eu",
      onConnectionStateChange: (String currentState, String previousState) {
        print("Current: $currentState | Previous: $previousState");
      },
      onError: (String message, int? code, dynamic additionalData) {
        print("Pusher Error Message: $message");
        print("Pusher Error Code: $code");
        print("Pusher Error Additional Data: $additionalData");
      },
    );
    await pusher.subscribe(
      channelName: 'chat-private-channel-${ConstData.userid}',
      onEvent: (event) {
        print("📩 Received Event from Pusher: ${event.data}");

        if (event.data == null || event.data!.isEmpty) {
          print("⚠️ Pusher event data is empty!");
          return;
        }

        final data = json.decode(event.data!);

        print("🛠 Decoded Data: $data");

        if (data.containsKey('message')) {
          final newMessage = MessageModel.fromJson(data['message']);
          messages.add(newMessage);

          if (!_chatStreamController.isClosed) {
            _chatStreamController.add(
              List<MessageModel>.from(messages),
            ); // 🔄 تحديث الـ Stream
          }

          update(); // 🔄 تحديث الواجهة
        } else {
          print("⚠️ No 'message' key in Pusher event data");
        }
      },
    );

    await pusher.connect();
  }

  Future<void> sendMessage() async {
  String messageText = messageController.text.trim();

  if (messageText.isEmpty) {
    Get.snackbar('خطأ', 'لا يمكن ارسال رسالة فارغة');
    return;
  }

  // ✨ أضف الرسالة مؤقتًا مباشرة
  MessageModel tempMessage = MessageModel(
    createdAt: DateTime.now(),
    message: messageText,
    receiverId: id,
    senderId: ConstData.userid,
    isSending: true, // هذا حقل مخصص لتمييزها كـ "قيد الإرسال"
  );

  messages.add(tempMessage);
  messageController.clear();
  _chatStreamController.add(List<MessageModel>.from(messages));
  update();

  // 👇 أرسلها إلى الخادم
  var response = await sendMessageToServer({'message': messageText});

  if (response == StatusRequest.success) {
    // ✅ نجاح الإرسال: عدل حالة الرسالة
    final index = messages.indexOf(tempMessage);
    if (index != -1) {
      messages[index] = MessageModel(
        createdAt: DateTime.now(),
        message: messageText,
        receiverId: id,
        senderId: ConstData.userid,
      );
    }

    statusRequest = StatusRequest.success;
  } else {
    // ❌ فشل: احذف الرسالة المؤقتة وأبلغ المستخدم
    messages.remove(tempMessage);
    Get.snackbar('خطأ', 'فشل إرسال الرسالة');
    statusRequest = StatusRequest.failure;
  }

  _chatStreamController.add(List<MessageModel>.from(messages));
  update();
}


  Future<dynamic> sendMessageToServer(Map<String, dynamic> data) async {
    var response = await crud.postData(
      '${ApiLinks.sendMessage}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  @override
  void onClose() {
    if (!_chatStreamController.isClosed) {
      _chatStreamController.close();
    }

    try {
      pusher.unsubscribe(
        channelName: 'chat-private-channel-${ConstData.userid}',
      );
    } catch (e) {
      print("❌ Error unsubscribing from channel: $e");
    }

    pusher.disconnect();
    super.onClose();
  }
}
 