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

  Future<void> sendMessage() async {
    String messageText = messageController.text.trim();

    if (messageText.isEmpty) return;

    MessageModel tempMessage = MessageModel(
      createdAt: DateTime.now(),
      message: messageText,
      receiverId: id,
      senderId: ConstData.userid,
      isSending: true,
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

  @override
  void onClose() {
    _conversationsMessagesWorker?.dispose();
    _unreadMessagesWorker?.dispose();

    if (!_chatStreamController.isClosed) {
      _chatStreamController.close();
    }
     currentChatId.value = '';
    super.onClose();
  }
}
