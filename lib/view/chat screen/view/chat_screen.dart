import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/styles.dart';
import 'package:mersal/view/chat%20screen/view/your_chat_screen.dart';
import 'package:mersal/view/chat%20screen/widgets/custom_chat.dart';
import 'package:mersal/view/chat%20screen/widgets/custom_chat_shimmer.dart';
import '../../favourite/widget/favourite_app_bar.dart';
import '../controller/global_chat_pusher_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalPusherController controller = Get.put(GlobalPusherController());

    return Scaffold(
      body: GetBuilder<GlobalPusherController>(
        builder: (_) {
          return Column(
            children: [
              FavouriteAppBar(
                isChatScreen: true,
                controller: controller.searchController,
                onChanged: (value) {
                  controller.filterMessages(value);
                },
              ),
              const SizedBox(height: 10),
              if (controller.statusRequest == StatusRequest.loading)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.separated(
                      itemBuilder: (context, index) => CustomChatShimmer(),
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: 5,
                    ),
                  ),
                )
              else if (controller.statusRequest == StatusRequest.failure ||
                  controller.statusRequest == StatusRequest.offlineFailure)
                Center(
                  child: Text(
                    controller.message,
                    style: Styles.style3.copyWith(color: Colors.red),
                  ),
                )
              else if (controller.filteredMessages.isEmpty)
                Center(
                  child: Text(
                    'لا يوجد رسائل بعد',
                    style: Styles.style1.copyWith(color: Colors.red),
                  ),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemCount: controller.filteredMessages.length,
                      itemBuilder: (context, index) {
                        final item = controller.filteredMessages[index];
                        final unreadCount =
                            controller.unreadMessages[item.id] ?? 0;

                        return InkWell(
                          onTap: () async {
                            controller.markAsRead(item.id);

                            await Get.to(
                              () => YourChatScreen(
                                senderName: item.name,
                                id: item.id,
                              ),
                            );

                            controller.getConversions(); // refresh
                          },
                          child: CustomChat(
                            messagesModel: item,
                            unreadCount: unreadCount,
                          ),
                        );
                      },
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
