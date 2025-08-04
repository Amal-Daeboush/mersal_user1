import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/model/messages_model.dart';
import 'package:mersal/view/widgets/snack%20bar/custom_snack_bar.dart';
import '../../../core/class/crud.dart';
import '../../../core/class/status_request.dart';
import 'global_chat_pusher_controller.dart';

class ChatController extends GetxController {
  TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  StatusRequest statusRequest = StatusRequest.loading;
  String message = '';

  // بدل List عادي نستخدم RxList عشان التحديث التلقائي (اختياري)
  RxList<MessagesModel> messages = <MessagesModel>[].obs;
  RxList<MessagesModel> filteredMessages = <MessagesModel>[].obs;

  final GlobalPusherController globalPusherController = Get.find();

  @override
  void onInit() {
    super.onInit();
    getConversions();

    // إذا تبي تحدث الرسائل بشكل مباشر من الـ GlobalPusherController
    ever(globalPusherController.conversationsMessages, (_) {
      // تحديث قائمة الرسائل حسب المحادثات الموجودة
      _syncMessagesFromGlobalPusher();
    });
  }

  void _syncMessagesFromGlobalPusher() {
    // هنا نجمع آخر رسالة من كل محادثة (يمكنك تعديل حسب حاجتك)
    List<MessagesModel> latestMessages = [];

    globalPusherController.conversationsMessages.forEach((userId, msgs) {
      if (msgs.isNotEmpty) {
        // مثلاً آخر رسالة لكل محادثة
        latestMessages.add(
          MessagesModel(
            id: int.tryParse(msgs.last.senderId) ?? 0,
            name: '[اسم غير متوفر]', // يمكنك تعيين الاسم الصحيح من مكان آخر
            lastMessageAt: msgs.last.createdAt,
          ),
        );
        // إذا لديك تحويل
      }
    });

    // تحديث القوائم
    messages.assignAll(latestMessages);
    filteredMessages.assignAll(latestMessages);
    statusRequest = StatusRequest.success;
    update();
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
        print("Response data: $data");

        if (data != null && data is List) {
          messages.value =
              data.map((item) => MessagesModel.fromJson(item)).toList();
          filteredMessages.value = List.from(messages);
          statusRequest = StatusRequest.success;

          // مزامنة الرسائل مع GlobalPusherController
          // افترض أن لديك طريقة لتحويل MessagesModel إلى MessageModel
          // أو بالعكس، حسب ما تفضل
          for (var msg in messages) {
            int userId = msg.id; // أو أي معرف مستخدم مناسب
            globalPusherController.conversationsMessages[userId] = [
              msg.toMessageModel(),
            ];
          }
        } else {
          statusRequest = StatusRequest.failure;
          message = 'حدث خطأ';
          print("Invalid data structure or 'data' key is missing");
          messages.clear();
          filteredMessages.clear();
        }
        update();
      },
    );
  }

  void filterMessages(String query) {
    if (query.isEmpty) {
      filteredMessages.value = List.from(messages);
    } else {
      filteredMessages.value =
          messages
              .where(
                (msg) => msg.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    update();
  }
}
