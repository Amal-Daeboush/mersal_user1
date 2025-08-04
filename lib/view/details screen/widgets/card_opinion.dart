import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mersal/core/constant/app_colors.dart';
import 'package:mersal/core/constant/const_data.dart';
import 'package:mersal/model/rating_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mersal/view/details screen/controller/details_controller.dart';
import 'package:mersal/view/details%20screen/widgets/add%20rate%20doilog/delet_edit_dialog.dart';


import '../../../core/constant/app_image_asset.dart';
import '../../../core/constant/styles.dart';

class CardOpinion extends StatelessWidget {
  final RatingsModel ratingModel;
  const CardOpinion({super.key, required this.ratingModel});

  @override
  Widget build(BuildContext context) {
    DetailsController detailsController = Get.find();

    String formatSmartDate(DateTime dateTime) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
      final difference = today.difference(aDate).inDays;

      if (difference == 0) {
        return 'اليوم ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (difference == 1) {
        return 'أمس ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else {
        return '${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress:
            ratingModel.user.id == ConstData.user!.user.id
                ? () => showDeleteDialogDialog(
                  context,
                  ratingModel,
                  detailsController,
                )
                : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 15.r,
                backgroundImage:
                    ratingModel.user.image.toString().isEmpty
                        ? const AssetImage(AppImageAsset.user)
                        : NetworkImage(ratingModel.user.image.toString())
                            as ImageProvider,
              ),
              title: Text(
                ' ${ratingModel.user.name} ',
                style: Styles.style4.copyWith(color: AppColors.charcoalGrey),
              ),
              subtitle: Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < int.parse(ratingModel.num)
                        ? Icons.star
                        : Icons.star_border,
                    size: 15,
                    color:
                        index < int.parse(ratingModel.num)
                            ? Colors.yellow
                            : Colors.grey,
                  ),
                ),
              ),
              trailing: Text(
                formatSmartDate(ratingModel.createdAt),
                style: Styles.style4.copyWith(color: AppColors.greyColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ratingModel.comment,
                    textAlign: TextAlign.start,
                    style: Styles.style1.copyWith(color: AppColors.greyColor),
                  ),
                  const SizedBox(height: 5),
                  ratingModel.answers.isNotEmpty
                      ? Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                              ratingModel.answers.map((replay) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor:
                                                AppColors.greyColor2,
                                            child: const Icon(
                                              Icons.person,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          const Text(
                                            'مزود المنتج:',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 20,
                                          top: 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                replay.comment,
                                                style: Styles.style5.copyWith(
                                                  color: AppColors.greyColor,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              formatSmartDate(replay.createdAt),
                                              style: Styles.style5.copyWith(
                                                color: Colors.grey,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
