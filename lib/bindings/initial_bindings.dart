import 'package:get/get.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import '../core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
   //   FavouriteController favouriteController = Get.put(FavouriteController());
  }
}
