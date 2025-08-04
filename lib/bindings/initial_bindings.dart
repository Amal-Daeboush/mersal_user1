import 'package:get/get.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import '../core/class/crud.dart';
import '../core/sevices/key_shsred_perfences.dart';
import '../core/sevices/sevices.dart';
import '../view/chat screen/controller/global_chat_pusher_controller.dart'
    show GlobalPusherController;
import '../view/notifications screen/controller/notification_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    Get.put(Crud());
    final userId = await MyServices.getValue(
      SharedPreferencesKey.tokenkey,
    ); // أو أي طريقة تحفظ بها اليوزر

    if (userId != null) {
       Get.put(FavouriteController());
      var controller = Get.put(NotificationController());
      Get.put(GlobalPusherController());
      controller.loadNotifications(loadUnreadAlso: true);
    }
    //   FavouriteController favouriteController = Get.put(FavouriteController());
  }
}
