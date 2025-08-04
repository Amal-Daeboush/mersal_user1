import 'dart:convert';

import 'package:get/get.dart';
import 'package:mersal/core/sevices/key_shsred_perfences.dart';
import 'package:mersal/data/model/cart_model.dart';
import 'package:mersal/data/model/products_model.dart';
import 'package:mersal/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/const_data.dart';

class MyServices extends GetxService {
  static late SharedPreferences shared;

  Future<MyServices> initialize() async {
    shared = await SharedPreferences.getInstance();
    ConstData.cart = await loadCartFromStorage();
    ConstData.token = await getValue(SharedPreferencesKey.tokenkey) ?? '';
    ConstData.otp = await getValue(SharedPreferencesKey.otp) ?? '';

    ConstData.addressUser = await getValue(SharedPreferencesKey.address) ?? '';
    ConstData.nameUser = await getValue(SharedPreferencesKey.userName) ?? '';
    ConstData.phoneUser = await getValue(SharedPreferencesKey.userPhone) ?? '';
    ConstData.image = await getValue(SharedPreferencesKey.image) ?? '';
    ConstData.isBoarding =
        await getValue(SharedPreferencesKey.isBoarding) ?? '';
    UserModel? userInfo = await getUserInfo();

    if (userInfo != null) {
      ConstData.user = userInfo;
      ConstData.userid = userInfo.user.id.toString();
    } else {
      print('User info is null, handle accordingly');
    }

    return this;
  }

  static Future<void> saveValue(String key, String value) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      print("Error saving value: $e");
    }
  }

  static getValue(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      print("Error getting value: $e");
      return null;
    }
  }

  setConstToken() async {
    ConstData.token = await getValue(SharedPreferencesKey.tokenkey) ?? '';
    print('your token is ......');
    print(ConstData.token);
    return ConstData.token;
  }

  setConstAddress() async {
    ConstData.addressUser = await getValue(SharedPreferencesKey.address) ?? '';
    print('your address is ......');
    print(ConstData.addressUser);
    return ConstData.addressUser;
  }

  setConstOtp() async {
    ConstData.otp = await getValue(SharedPreferencesKey.otp) ?? '';
    print('your otp is ......');
    print(ConstData.otp);
    return ConstData.otp;
  }

  setConstPhone() async {
    ConstData.phoneUser = await getValue(SharedPreferencesKey.userPhone) ?? '';
    print('your phonr is ......');
    print(ConstData.phoneUser);
    return ConstData.phoneUser;
  }

  setConstImage() async {
    ConstData.image = await getValue(SharedPreferencesKey.image) ?? '';
    print('your image is ......');
    print(ConstData.image);
    return ConstData.image;
  }

  setConstName() async {
    ConstData.nameUser = await getValue(SharedPreferencesKey.userName) ?? '';
    print('your name is ......');
    print(ConstData.nameUser);
    return ConstData.nameUser;
  }

  setConstuser() async {
    ConstData.user = (await getUserInfo())!;
    print('your user is ......');
    print(ConstData.user);
    return ConstData.user;
  }

  setConstBoarding() async {
    ConstData.isBoarding =
        await getValue(SharedPreferencesKey.isBoarding) ?? '';
    print('your isBoarding is ......');
    print(ConstData.isBoarding);
    return ConstData.isBoarding;
  }

  Future<UserModel?> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(SharedPreferencesKey.user);

    if (userJson != null && userJson.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(userJson));
    }

    return null;
  }

  //save User Information
  Future<void> saveUserInfo(UserModel user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user.toJson());
      String userJsonId = jsonEncode(user.user.id);
      await prefs.setString(SharedPreferencesKey.user, userJson);
      await prefs.setString(SharedPreferencesKey.userId, userJsonId);
      print(' user is ......');
      print(user);
    } catch (e) {
      print("Error saving user info: $e");
    }
  }

  // حفظ الكارت
  Future<void> saveCartToStorage(List<CartModel> cart) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> cartJsonList =
          cart.map((item) => jsonEncode(item.toJson())).toList();
      await prefs.setStringList(SharedPreferencesKey.cart, cartJsonList);
    } catch (e) {
      print("Error saving cart: $e");
    }
  }

  // استرجاع الكارت
  Future<List<CartModel>> loadCartFromStorage() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? cartJsonList = prefs.getStringList(
        SharedPreferencesKey.cart,
      );
      if (cartJsonList != null) {
        return cartJsonList
            .map((item) => CartModel.fromJson(jsonDecode(item)))
            .toList();
      }
    } catch (e) {
      print("Error loading cart: $e");
    }
    return [];
  }

  // إضافة منتج للكارت
  Future<void> addToCart(ProductModel product, int quantity) async {
    List<CartModel> currentCart = await loadCartFromStorage();

    final index = currentCart.indexWhere(
      (e) => e.productModel.id == product.id,
    );
    if (index != -1) {
      // إذا المنتج موجود زود الكمية
      currentCart[index] = CartModel(
        productModel: product,
        quantityInCart: currentCart[index].quantityInCart + quantity,
      );
    } else {
      currentCart.add(
        CartModel(productModel: product, quantityInCart: quantity),
      );
    }

    await saveCartToStorage(currentCart);
    ConstData.cart = currentCart;
  }

  // إزالة منتج من الكارت
  Future<void> removeFromCart(int productId) async {
    List<CartModel> currentCart = await loadCartFromStorage();
    currentCart.removeWhere((item) => item.productModel.id == productId);
    await saveCartToStorage(currentCart);
    ConstData.cart = currentCart;
  }

  // تصفير الكارت
  Future<void> clearCart() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesKey.cart);
    ConstData.cart = [];
  }

  // clear shared
  Future<void> clear() async {
    try {
      await shared.clear();
      ConstData.token = '';
      ConstData.isBoarding = '';
      print("All shared preferences cleared");
    } catch (e) {
      print("Error clearing shared preferences: $e");
    }
  }
}

Future<void> intialService() async {
  await Get.putAsync(() => MyServices().initialize());
}
