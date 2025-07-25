import 'package:mersal/core/constant/const_data.dart';

class ApiLinks {
  static const String server = "http://192.168.1.12:8000/api";
 // static const String server= "https://highleveltecknology.com/Ms/api";
  // ================================= Images ================================== //
  static const String imagesStatic = "";
  // ================================= Auth ================================== //
  static const String register = "$server/register";
  static const String login = "$server/login";
  static const String google = "$server/auth/google/redirect";
  static const String facebook = "$server/auth/facebook/redirect";
  static const String verify_otp = "$server/verify_otp";

  // ================================= CATEGORY ================================== //
  static const String getCategories = "$server/user/categories/get_all";

  // ================================= provider =====================
  static const String getProductProviders =
      "$server/user/provider/product/get_by_status"
      ;
       static const String getProviderforservice =
      "$server/user/provider/service/show_info";
       static const String getProviderforproduct =
      "$server/user/provider/product/show_info";
  // ================================= product ================================== //
  static const String latestProduct = "$server/user/product/get_all_latest";
  static const String productByCategory =
      "$server/user/product/product_by_category";
        static const String productByProviderProduct =
      "$server/user/product/product_by_product_provider";
  static const String show_product = "$server/user/product/show";
  static const String show_rate_product = "$server/user/product/all_rating";

  // ================================= rating ================================== //
  static const String getRating = "$server/user/product/all_rating";
  static const String rateProduct = "$server/user/rate/store";
  static const String updateRate = "$server/user/rate/update";
  static const String deleteRate = "$server/user/rate/delete";

  // ================================= order =====================
  static const String orderProduct = "$server/user/orders/store";
  static const String canceledProduct = "$server/user/orders/cancelled";
  static const String getOrdersByStatus = "$server/user/orders/ByStatus";
  static const String checkCoupon = "$server/coupons/check-status";
  // ================================= order =====================
  static const String reservation = "$server/user/reservation/store";
  static const String getreservation =
      "$server/user/getUserReservations/ByStatus";
  static const String getordergProduct = "$server/user/orders/get_product";

  // ================================= food ================================== //
 static const String foodTypes = "$server/food-types/index";
  static const String getProvidersByFoodType = "$server/food-types/getProvidersByFoodType";
  // ================================= favorites =====================
  static const String getFavoriteProduct =
      "$server/user/favourites/products/get_all";
  static const String addFavoriteProduct = "$server/user/favourites/add";
  static const String removeFavoriteProduct = "$server/user/favourites/remove";

  // ================================= profiles =====================
  static const String storeProfile = "$server/user/profile/store";
  static const String updateProfile = "$server/user/profile/update";
  static const String getProfile = "$server/user/my_info/get";
  static const String postPass = "$server/user/my_info/update";

  // ================================= chat =====================
  static const String getConversations = "$server/getInteractedUsers";
  static const String getConversation = "$server/getConversation";
  static const String sendMessage = "$server/SendTo";

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {'Accept': 'application/json'};

    return mainHeader;
  }

  Map<String, String> getHeaderWithToken() {
    Map<String, String> mainHeader = {
      'Accept': 'application/json',

      "Authorization": "Bearer ${ConstData.token}",
    };
    return mainHeader;
  }
}
