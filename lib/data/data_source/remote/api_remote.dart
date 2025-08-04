import 'package:mersal/core/class/crud.dart';
import 'package:mersal/core/class/status_request.dart';
import 'package:mersal/core/constant/api_links.dart';
import 'package:mersal/core/constant/const_data.dart';

class ApiRemote {
  Crud crud = Crud();
  Future<dynamic> verificationModel(
    Map<String, dynamic> data,
    String url,
    bool token,
  ) async {
    var response = await Crud().postData(
      url,
      data,
      token ? ApiLinks().getHeaderWithToken() : ApiLinks().getHeader(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> signUpModel(Map<String, dynamic> data) async {
    var response = await Crud().postData(
      '${ApiLinks.register}',
      data,
      ApiLinks().getHeader(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> loginModel(Map<String, dynamic> data) async {
    var response = await Crud().postData(
      '${ApiLinks.login}',
      data,
      ApiLinks().getHeader(),
      true,
    );

    return response.fold(
      (l) => l, // StatusRequest.success أو StatusRequest.failure
      (r) => r, // response كـ Map<String, dynamic> عند الفشل
    );
  }

  Future<dynamic> updateProfile(Map<String, dynamic> data) async {
    var response = await crud.post(
      '${ApiLinks.updateProfile}',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold(
      (l) => l, // StatusRequest.success أو StatusRequest.failure
      (r) => r, // response كـ Map<String, dynamic> عند الفشل
    );
  }
  Future<dynamic> detilsOrser(Map<String, dynamic> data,String id) async {
    var response = await crud.post(
      '${ApiLinks.track_order}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold(
      (l) => l, // StatusRequest.success أو StatusRequest.failure
      (r) => r, // response كـ Map<String, dynamic> عند الفشل
    );
  }

  Future<dynamic> updateInfo(Map<String, dynamic> data) async {
    var response = await crud.post(
      '${ApiLinks.postPass}',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold(
      (l) => l, // StatusRequest.success أو StatusRequest.failure
      (r) => r, // response كـ Map<String, dynamic> عند الفشل
    );
  }

  Future<dynamic> AddrateModel(Map<String, dynamic> data, String id) async {
    var response = await Crud().postData(
      '${ApiLinks.rateProduct}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> CancelOrderModel(Map<String, dynamic> data, String id) async {
    var response = await Crud().postData(
      '${ApiLinks.canceledProduct}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> AddFavouriteModel(
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().postData(
      '${ApiLinks.addFavoriteProduct}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deleteFavouriteModel(
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().deleteData(
      '${ApiLinks.removeFavoriteProduct}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> UpdateInfoModel(Map<String, dynamic> data) async {
    var response = await Crud().postData(
      '${ApiLinks.updateProfile}',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> deleteReplay(Map<String, dynamic> data, String id) async {
    Crud crud = Crud();
    var response = await crud.deleteData(
      '${ApiLinks.deleteRate}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
    );
    return response.fold((l) => l, (r) => StatusRequest.success);
  }

  Future<dynamic> editReplay(String id, Map<String, dynamic> data) async {
    Crud crud = Crud();
    var response = await crud.postData(
      '${ApiLinks.updateRate}/$id',
      data,
      ApiLinks().getHeaderWithToken(),
      false,
    );
    return response.fold((l) => l, (r) => StatusRequest.success);
  }

  Future<dynamic> orderProductModel(
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().postDataList(
      '${ApiLinks.orderProduct}',
      data, // ترسل Map مباشرة
      {
        'Content-Type': 'application/json',

        "Authorization": "Bearer ${ConstData.token}",
      },
    );

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> orderServiceModel(
    Map<String, dynamic> data,
    String id,
  ) async {
    var response = await Crud().post(
      '${ApiLinks.reservation}',
      data,
      ApiLinks().getHeaderWithToken(),
    );

    return response.fold((l) => l, (r) => r);
  }
}
