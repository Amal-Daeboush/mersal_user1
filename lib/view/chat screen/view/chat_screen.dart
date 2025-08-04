import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/chat%20screen/view/your_chat_screen.dart';
import 'package:mersal/view/chat%20screen/widgets/custom_chat.dart';
import 'package:mersal/view/favourite/controller/favourite_controller.dart';
import 'package:mersal/view/favourite/widget/card_favorite.dart';
import 'package:mersal/view/widgets/custom_loading.dart';
import 'package:mersal/view/widgets/shimmer/product_shimmer.dart';
import '../../favourite/widget/favourite_app_bar.dart';
import '../controller/chat_controller.dart' show ChatController;


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final FavouriteController controller = Get.find();

    // استدعاء التحديث مباشرة عند بناء الصفحة
    controller.getFavorites();
    return Scaffold(
      body: GetBuilder<ChatController>(
          init: ChatController(),
        builder: (controller) {
          return Column(
            children: [
              FavouriteAppBar(
                isChatScreen: true,
                controller: controller.searchController,

               onChanged: (value) {
                        controller.filterMessages(value);
                      },
              ),
              SizedBox(height: 10.h),
              controller.statusRequest == StatusRequest.loading
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120,vertical: 20),
                    child: customLoadingIndictor(),
                  )
                  : controller.statusRequest == StatusRequest.failure
                  ? Center(
                    child: Text(
                      controller.message,
                      style: Styles.style3.copyWith(color: Colors.red),
                    ),
                  )
                  : controller.statusRequest == StatusRequest.offlineFailure
                  ? Center(
                    child: Text(
                      controller.message,
                      style: Styles.style3.copyWith(color: Colors.red),
                    ),
                  )
                  : controller.filteredMessages.isEmpty
                  ? Center(
                    child: Text(
                      'لا يوجد رسائل بعد',
                      style: Styles.style1.copyWith(color: Colors.red),
                    ),
                  )
                  : Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder:
                            (context, index) => SizedBox(height: 2.h),
                        itemCount:
                            controller
                                .filteredMessages
                                .length, // ✅ استخدام القائمة المفلترة
                        itemBuilder: (context, index) {
                          return InkWell(
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () async {
                              await Get.to(
                                YourChatScreen(
                                  senderName:
                                      controller.filteredMessages[index].name,
                                  id: controller.filteredMessages[index].id,
                                ),
                              );
                              controller
                                  .getConversions(); // ✅  البي
                            },

                            child: CustomChat(
                              messagesModel: controller.filteredMessages[index],
                            ),
                          );
                        },
                      ),
                      ),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
