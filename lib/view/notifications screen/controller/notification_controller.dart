import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/model/notification_model.dart';
import 'package:mersal/view/notifications%20screen/controller/notification_remote.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class NotificationController extends GetxController {
  List<NotificationModel> unread = [];
  List<NotificationModel> read = [];
  int get unreadCount => unread.length;

  StatusRequest statusRequest = StatusRequest.none;

  final remote = NotificationRemote();

  Future<void> loadNotifications({bool loadUnreadAlso = true}) async {
    statusRequest = StatusRequest.loading;
    update();

    // تحميل غير المقروءة
    if (loadUnreadAlso) {
      final pendingRes = await remote.getPending();
      pendingRes.fold((fail) => unread = [], (data) => unread = data);
    }

    // تحميل المقروءة
    final readRes = await remote.getRead();
    readRes.fold((fail) => read = [], (data) => read = data);

    statusRequest = StatusRequest.success;
    update();
  }

  markAllAsRead() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await remote.markAllAsRead();

    print("Response: $response");

    if (response == StatusRequest.success) {
      print('succefu');
      statusRequest = StatusRequest.success;
      read.addAll(unread); // نقل غير المقروءة إلى المقروءة
      unread.clear(); // تصفير القائمة

      update();
      //   Get.off(const LoginScreen());
      //  Get.off(LoginScreen());
    } else if (response is String) {
      read.addAll(unread); // نقل غير المقروءة إلى المقروءة
      unread.clear(); // تصفير القائمة

      update();
      // ✅ عرض رسالة الخطأ بشكل مناسب
      Get.snackbar('', response);

      statusRequest = StatusRequest.success;
    } else {
      Get.snackbar('خطأ', 'حدث خطأ');
      //  isLoading = false;
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  /* Future<void> markAllAsRead() async {
  var result = await remote.markAllAsRead();
  result.fold(
    (failure) {
      print("Failed to mark all as read");
    },
    (data) {
  read.addAll(unread); // نقل غير المقروءة إلى المقروءة
      unread.clear();       // تصفير القائمة
  
      update();
      print("Marked all as read successfully");
    },
  );
} */

  late PusherChannelsFlutter pusher;

  @override
  void onInit() {
    super.onInit();
    _initPusher();
  }

  Future<void> _initPusher() async {
    pusher = PusherChannelsFlutter.getInstance();

    await pusher.init(
      apiKey: "af4ff5b03e590e827cbe",
      cluster: "eu",
      onEvent: (PusherEvent event) {
        print("Event received: ${event.eventName} - ${event.data}");

        if (event.eventName == 'PrivateNotification') {
          final data = jsonDecode(event.data ?? '{}');

          // تحقق من وجود "message"
          if (data.containsKey('message')) {
            final newNotification = NotificationModel(
              userId: data['user_id'],
              notification: data['message'],
              status: "pending",
              createdAt: DateTime.now(),
            );

            unread.insert(0, newNotification);
            update();

            // ✅ إظهار SnackBar
            Get.snackbar(
              "إشعار جديد",
              data['message'],
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.black.withOpacity(0.7),
              colorText: Colors.white,
              margin: EdgeInsets.all(10),
              duration: Duration(seconds: 3),
            );
          }
        }
      },
    );

    await pusher.subscribe(
      channelName: 'notification-private-channel-${ConstData.user!.user.id}',
    );

    await pusher.connect();
  }

  @override
  void onClose() async {
    await markAllAsRead();
    super.onClose();
  }
}
