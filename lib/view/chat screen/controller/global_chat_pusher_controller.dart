import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/model/message_model.dart';
import 'package:mersal/model/messages_model.dart';
import 'package:mersal/view/chat screen/controller/your_chat_controller.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../core/constant/api_links.dart';
import '../../../model/other_user_model.dart';
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

    ever(conversationsMessages, (_) async {
      filteredMessages.value = await getLatestConversations();
      update();
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

        // أضف الرسالة إلى قائمة المستخدم
        conversationsMessages.update(senderId, (existingList) {
          existingList.add(newMessage);
          return existingList;
        }, ifAbsent: () => [newMessage]);

        // إذا المستخدم خارج المحادثة الحالية، اعتبرها غير مقروءة فقط إذا is_read != "1"
        if (YourChatController.currentChatId.value != senderId.toString()) {
          if (newMessage.isRead != '1') {
            unreadMessages[senderId] = (unreadMessages[senderId] ?? 0) + 1;
            Get.snackbar("رسالة جديدة", newMessage.message);
          }
        } else {
          unreadMessages.remove(senderId);
        }

        getLatestConversations().then((list) {
          filteredMessages.value = list;
          update();
        });
      },
    );

    await pusher.connect();
  }

  Future<void> getConversions() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await Crud().getData(
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
      (data) async {
        if (data != null && data is List) {
          conversationsMessages.clear();
          unreadMessages.clear();
          userNames.clear();

          for (var item in data) {
            final msg = MessagesModel.fromJson(item);
            userNames[msg.id] = msg.name;
            conversationsMessages[msg.id] = [msg.toMessageModel()];

            if (msg.unreadCount != null && msg.unreadCount! > 0) {
              unreadMessages[msg.id] = msg.unreadCount!;
            }
          }

          filteredMessages.value = await getLatestConversations();
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

  Future<List<MessagesModel>> getLatestConversations() async {
    List<MessagesModel> latestMessages = [];

    for (var entry in conversationsMessages.entries) {
      int userId = entry.key;
      List<MessageModel> msgs = entry.value;

      if (msgs.isNotEmpty) {
        // تحميل اسم المستخدم إذا غير موجود
        if (!userNames.containsKey(userId)) {
          await loadUserName(userId);
        }

        final lastMsg = msgs.last;
        latestMessages.add(
          MessagesModel(
            id: userId,
            name: userNames[userId] ?? '[اسم غير متوفر]',
            lastMessageAt: lastMsg.createdAt,
            unreadCount: unreadMessages[userId] ?? 0,
          ),
        );
      }
    }

    latestMessages.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return latestMessages;
  }

  Future<void> loadUserName(int userId) async {
    final userInfo = await fetchOtherUser(userId.toString());
if (userInfo != null) {
  print('اسم المستخدم: ${userInfo.user.name}');
  userNames[userId] = userInfo.user.name;
} else {
  userNames[userId] = '[اسم غير متوفر]';
}

  }

  void filterMessages(String query) {
    final all = filteredMessages;
    if (query.isEmpty) {
      filteredMessages.value = all;
    } else {
      filteredMessages.value =
          all
              .where(
                (msg) =>
                    msg.name.toLowerCase().contains(query.toLowerCase().trim()),
              )
              .toList();
    }
    update();
  }

  Future<void> markAllAsRead(String id) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await Crud().postData(
      '${ApiLinks.makeMessageRead}/$id',
      {},
      ApiLinks().getHeaderWithToken(),
      false,
    );

    response.fold(
      (failure) {
        Get.snackbar('خطأ', 'فشل في تحديث الرسائل');
        statusRequest = StatusRequest.failure;
      },
      (data) {
        unreadMessages.remove(int.parse(id));
        statusRequest = StatusRequest.success;
      },
    );

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
 Future<OtherUserInfo?> fetchOtherUser(String userId) async {
  final url = '${ApiLinks.getUser}/$userId';

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: ApiLinks().getHeaderWithToken(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonData = json.decode(response.body);

      final userInfoData = jsonData['user_info'];

      if (userInfoData != null) {
        return OtherUserInfo.fromJson(userInfoData);
      } else {
        print('user_info not found in response');
        return null;
      }
    } else {
      print('Failed to load user: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

}
