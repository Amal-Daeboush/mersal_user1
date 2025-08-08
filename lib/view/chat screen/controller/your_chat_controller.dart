import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/view/chat%20screen/controller/global_chat_pusher_controller.dart';
import '../../../core/class/crud.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/api_links.dart';
import '../../../model/message_model.dart';

class YourChatController extends GetxController {
  var messages = <MessageModel>[].obs;
  TextEditingController messageController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  Crud crud = Crud();
  static RxString currentChatId = ''.obs;
  Worker? _conversationsMessagesWorker;
  Worker? _unreadMessagesWorker;

  String id;

  final _chatStreamController = StreamController<List<MessageModel>>.broadcast();
  Stream<List<MessageModel>> get chatStream => _chatStreamController.stream;

  YourChatController({required this.id});

  @override
  void onInit() {
    super.onInit();
    currentChatId.value = id;
    getConversation();

    if (Get.isRegistered<GlobalPusherController>()) {
      final globalPusher = Get.find<GlobalPusherController>();

      _conversationsMessagesWorker = ever(
        globalPusher.conversationsMessages,
        (_) {
          final updatedMessages = globalPusher.getMessagesForUser(int.parse(id));

          for (var newMsg in updatedMessages) {
            bool alreadyExists = messages.any((m) =>
                m.message == newMsg.message &&
                m.senderId == newMsg.senderId &&
                m.createdAt == newMsg.createdAt);

            if (!alreadyExists) {
              messages.add(newMsg);

              // فور استقبال رسالة جديدة وأنت داخل المحادثة: عيّنها كمقروءة مباشرة
              if (newMsg.receiverId == ConstData.userid.toString() && newMsg.isRead == "0") {
                markMessagesAsReadFromSender(newMsg.senderId);
              }
            }
          }

          messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

          if (!_chatStreamController.isClosed) {
            _chatStreamController.add(List<MessageModel>.from(messages));
          }

          update();
        },
      );

      _unreadMessagesWorker = ever(
        globalPusher.unreadMessages,
        (_) {
          update();
        },
      );
    }
  }

    Future<void> getConversation() async {
    var response = await crud.getData(
      '${ApiLinks.getConversation}/$id',
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        statusRequest = StatusRequest.failure;
        messages.clear();
        if (!_chatStreamController.isClosed) {
          _chatStreamController.add([]);
        }
        update();
      },
      (data) {
        if (data == null || (data is Map && data.containsKey("message"))) {
          statusRequest = StatusRequest.failure;
          messages.clear();
          if (!_chatStreamController.isClosed) {
            _chatStreamController.add([]);
          }
          update();
        } else if (data is Map && data.containsKey("messages")) {
          List<MessageModel> newMessages = (data["messages"] as List)
              .map((item) => MessageModel.fromJson(item))
              .toList();
          messages.assignAll(newMessages);

          // عند تحميل الرسائل الأولى، عينها كمقروءة كلها لأن المستخدم في المحادثة
          markMessagesAsReadFromSender(id);

          if (!_chatStreamController.isClosed) {
            _chatStreamController.add(newMessages);
          }
          statusRequest = StatusRequest.success;
          update();
        } else {
          statusRequest = StatusRequest.failure;
          messages.clear();
          update();
        }
      },
    );
  }
  Future<void> sendMessage() async {
    String messageText = messageController.text.trim();

    if (messageText.isEmpty) return;

    MessageModel tempMessage = MessageModel(
      createdAt: DateTime.now(),
      message: messageText,
      receiverId: id,
      senderId: ConstData.userid,
      isSending: true,
      isRead: "1", // أنت مرسلها فهي مقروءة
    );

    messages.add(tempMessage);
    messageController.clear();
    _chatStreamController.add(List<MessageModel>.from(messages));
    update();

    var response = await sendMessageToServer({'message': messageText});

    if (response == StatusRequest.success) {
      final index = messages.indexOf(tempMessage);
      if (index != -1) {
        messages[index] = MessageModel(
          createdAt: DateTime.now(),
          message: messageText,
          receiverId: id,
          senderId: ConstData.userid,
          isRead: "1",
        );
      }
    } else {
      messages.remove(tempMessage);
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

  // تابع لتمييز كل الرسائل الواردة من هذا المرسل كمقروءة
  Future<void> markMessagesAsReadFromSender(String senderId) async {
    var response = await crud.postData(
      '${ApiLinks.makeMessageRead}/$senderId', // مسار الـ API لتعليم الرسائل كمقروءة
      {},
      ApiLinks().getHeaderWithToken(),
      false,
    );

    response.fold(
      (failure) => print('Failed to mark messages as read: $failure'),
      (success) {
        // تحديث الرسائل محلياً
        messages.assignAll(messages.map((msg) {
  if (msg.senderId == senderId) {
    return MessageModel(
      message: msg.message,
      senderId: msg.senderId,
      receiverId: msg.receiverId,
      isRead: "1",
      createdAt: msg.createdAt,
      isSending: msg.isSending,
    );
  }
  return msg;
}).toList());


        _chatStreamController.add(List<MessageModel>.from(messages));
        update();
      },
    );
  }

  @override
  void onClose() {
    markMessagesAsReadFromSender(id); // تمييز الرسائل كمقروءة عند الإغلاق

    _conversationsMessagesWorker?.dispose();
    _unreadMessagesWorker?.dispose();

    if (!_chatStreamController.isClosed) {
      _chatStreamController.close();
    }
    currentChatId.value = '';
    super.onClose();
  }
}
