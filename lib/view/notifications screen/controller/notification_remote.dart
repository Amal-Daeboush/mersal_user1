import 'package:dartz/dartz.dart';
import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/data/model/notification_model.dart';

class NotificationRemote {
  // 1. Get unread notifications (pending)
  Future<Either<StatusRequest, List<NotificationModel>>> getPending() async {
    var response = await Crud().getData(
      ApiLinks.getNotification,
      ApiLinks().getHeaderWithToken(),
    );
    return response.fold(
      (failure) => Left(failure),
      (data) => Right(
        (data as List).map((e) => NotificationModel.fromJson(e)).toList(),
      ),
    );
  }

  // 2. Get read notifications
  Future<Either<StatusRequest, List<NotificationModel>>> getRead() async {
    var response = await Crud().getData(
      ApiLinks.readable_massege,
      ApiLinks().getHeaderWithToken(),
    );
    return response.fold(
      (failure) => Left(failure),
      (data) => Right(
        (data as List).map((e) => NotificationModel.fromJson(e)).toList(),
      ),
    );
  }

  // 3. Mark all as read
    Future<dynamic> markAllAsRead() async {
    var response = await Crud().postData(
      '${ApiLinks.read_notificatio}',
      {},
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }
 /*  Future<Either<StatusRequest, dynamic>> markAllAsRead() async {
    var response = await Crud().postData(
      ApiLinks.read_notificatio,
      {},
      ApiLinks().getHeaderWithToken(),
      false
    );
    return response;
  } */
}
