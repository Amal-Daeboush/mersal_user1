import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/view/chat%20screen/view/chat_screen.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/favourite/view/favourite_screen.dart';
import 'package:mersal/view/home/view/home_screen.dart';
import 'package:mersal/view/my%20order/view/my_orders_screen.dart';
import 'package:mersal/view/profile/view/profile_screen.dart';

class BottomNavController extends GetxController {
  int page = 0;
  FavouriteController favouriteController = Get.put(FavouriteController());

  final List<Widget> pages = [
    const HomeScreen(),
 const   ChatScreen(),
    const MyOrdersScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];
  void onTap(int index) {
    if (index != page) {
      page = index;
      update();
    }
  }
}
