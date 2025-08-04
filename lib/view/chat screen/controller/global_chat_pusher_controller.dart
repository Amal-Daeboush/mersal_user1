import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/model/message_model.dart';
import 'package:mersal/view/chat%20screen/controller/your_chat_controller.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:mersal/model/messages_model.dart';

import '../../../core/class/crud.dart';
import '../../../core/constant/api_links.dart';
import '../../widgets/snack bar/custom_snack_bar.dart';

class GlobalPusherController extends GetxController {
  late PusherChannelsFlutter pusher;
  TextEditingController searchController = TextEditingController();
  RxMap<int, List<MessageModel>> conversationsMessages =
      <int, List<MessageModel>>{}.obs;
  RxMap<int, int> unreadMessages = <int, int>{}.obs;
  RxMap<int, String> userNames = <int, String>{}.obs;

  RxList<MessagesModel> filteredMessages = <MessagesModel>[].obs;
  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';

  @override
  void onInit() {
    super.onInit();
    initPusher();
    getConversions();

    ever(conversationsMessages, (_) {
      filteredMessages.value = getLatestConversations();
    });
  }

  Future<void> initPusher() async {
    pusher = PusherChannelsFlutter();
    await pusher.init(apiKey: "af4ff5b03e590e827cbe", cluster: "eu");

    await pusher.subscribe(
      channelName: 'chat-private-channel-${ConstData.userid}',
      onEvent: (event) {
        if (event.data == null) return;

        final data = json.decode(event.data!);
        if (!data.containsKey("message")) return;

        final msg = data["message"];

        final senderId = int.parse(msg["sender_id"].toString());
        final newMessage = MessageModel.fromJson(msg);

        conversationsMessages.update(senderId, (existingList) {
          existingList.add(newMessage);
          return existingList;
        }, ifAbsent: () => [newMessage]);

        String currentRoute = Get.currentRoute;
       

        if (YourChatController.currentChatId.value != senderId.toString()) {
          unreadMessages[senderId] = (unreadMessages[senderId] ?? 0) + 1;

          // فقط أظهر Snackbar إذا المستخدم ليس داخل المحادثة مع المرسل
          Get.snackbar("رسالة جديدة", msg["message"]);
        } else {
          unreadMessages.remove(senderId);
        }
 filteredMessages.value = getLatestConversations(); 
        update();
      },
    );

    await pusher.connect();
  }
 
  Future<void> getConversions() async {
    statusRequest = StatusRequest.loading;
    update();

    Crud crud = Crud();
    var response = await crud.getData(
      ApiLinks.getConversations,
      ApiLinks().getHeaderWithToken(),
    );

    response.fold(
      (failure) {
        if (failure == StatusRequest.offlineFailure) {
          statusRequest = StatusRequest.offlineFailure;
          message = 'تحقق من الاتصال بالانترنت';
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
        }
        CustomSnackBar(message, true);
        update();
      },
      (data) {
        if (data != null && data is List) {
          for (var item in data) {
            final msg = MessagesModel.fromJson(item);
            userNames[msg.id] = msg.name;
            conversationsMessages[msg.id] = [msg.toMessageModel()];
          }
          filteredMessages.value = getLatestConversations();
          statusRequest = StatusRequest.success;
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          conversationsMessages.clear();
          filteredMessages.clear();
        }
        update();
      },
    );
  }

  List<MessagesModel> getLatestConversations() {
    List<MessagesModel> latestMessages = [];

    conversationsMessages.forEach((userId, msgs) {
      if (msgs.isNotEmpty) {
        final lastMsg = msgs.last;
        latestMessages.add(
          MessagesModel(
            id: userId,
            name: userNames[userId] ?? '[اسم غير متوفر]',
            lastMessageAt: lastMsg.createdAt,
          ),
        );
      }
    });
  latestMessages.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return latestMessages;
  }

  void filterMessages(String query) {
    final all = getLatestConversations();
    if (query.isEmpty) {
      filteredMessages.value = all;
    } else {
      filteredMessages.value =
          all
              .where(
                (msg) => msg.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }

  void markAsRead(int userId) {
    unreadMessages.remove(userId);
    update();
  }

  List<MessageModel> getMessagesForUser(int userId) {
    return conversationsMessages[userId] ?? [];
  }

  @override
  void onClose() {
    pusher.disconnect();
    super.onClose();
  }
}
