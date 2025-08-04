import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mersal/core/sevices/key_shsred_perfences.dart';
import 'package:mersal/data/model/user_model.dart';
import '../sevices/sevices.dart';
import 'helper_functions.dart';
import 'status_request.dart';

class Crud {
  Future<Either<StatusRequest, String>> postData(
    String url,
    Map<dynamic, dynamic> data,
    Map<String, String> headers,
    bool saveToken,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        var decodeResponse = json.decode(response.body);
        print('Response: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (saveToken) {
            var token = decodeResponse['access_token'];
            var user = UserModel.fromRawJson(response.body);
            var name = user.user.name;
            var otp = user.user.otp;
            //   var phone = decodeResponse['data']['email'];
            //  var name = user.user.name;

            await MyServices().saveUserInfo(user);
            await MyServices.saveValue(SharedPreferencesKey.userName, name);
            await MyServices.saveValue(SharedPreferencesKey.otp, otp!);
            //   await MyServices.saveValue(SharedPreferencesKey.userPhone, '678');

            await MyServices().setConstName();
            await MyServices().setConstOtp();
            await MyServices.saveValue(SharedPreferencesKey.tokenkey, token);

            await MyServices().setConstToken();
            await MyServices().saveUserInfo(user);
            await MyServices().setConstuser();
          }
          return const Left(StatusRequest.success);
        } else {
          // ✅ التأكد من استخراج `message` أو `errors`
          String errorMessage = 'Unknown error occurred';
          if (decodeResponse.containsKey('message')) {
            errorMessage = decodeResponse['message'];
          } else if (decodeResponse.containsKey('errors')) {
            var errors = decodeResponse['errors'];
            if (errors is Map<String, dynamic>) {
              errorMessage = errors.values.map((e) => e.join(', ')).join('\n');
            }
          }

          return Right(errorMessage);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, dynamic>> postDataList(
    String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        final response = await http.post(
          Uri.parse(url),
          body: jsonEncode(data),
          headers: headers,
        );

        print('Response: ${response.body}');

        try {
          final decoded = json.decode(response.body);

          if (response.statusCode == 200 || response.statusCode == 201) {
            // ✅ إذا success موجود وكانت false (خطأ منطقي من السيرفر)
            if (decoded is Map && decoded['success'] == false) {
              String message = decoded['message'] ?? 'فشل العملية';

              if (decoded.containsKey('errors')) {
                final errors = decoded['errors'] as Map<String, dynamic>;
                final errorMessages = errors.values
                    .map((e) {
                      if (e is List) return e.join(', ');
                      return e.toString();
                    })
                    .join('\n');
                message = '$message\n$errorMessages';
              }

              return Right({'error': true, 'message': message});
            }

            // ✅ نجاح حقيقي
            return Right(decoded);
          } else {
            // ❌ status code خطأ
            String message = 'حدث خطأ في السيرفر';

            if (decoded is Map) {
              if (decoded.containsKey('message')) {
                message = decoded['message'];
              } else if (decoded.containsKey('errors')) {
                final errors = decoded['errors'] as Map<String, dynamic>;
                message = errors.values
                    .map((e) {
                      if (e is List) return e.join(', ');
                      return e.toString();
                    })
                    .join('\n');
              }
            }

            return Right({'error': true, 'message': message});
          }
        } catch (e) {
          // ❌ فشل في قراءة JSON
          return Right({'error': true, 'message': response.body});
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('❌ Exception: $e');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, dynamic>> getData(
    String url,

    Map<String, String>? headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.get(Uri.parse(url), headers: headers);

        print(response);

        if (response.statusCode == 200 || response.statusCode == 201) {
          var responseBody = jsonDecode(response.body);
          print(response.body);
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      // print();
      return const Left(StatusRequest.serverFailure);
    }
  }
  Future<Either<StatusRequest, dynamic>> getData404(
  String url,
  Map<String, String>? headers,
) async {
  try {
    if (await HelperFunctions.checkInternet()) {
      var response = await http.get(Uri.parse(url), headers: headers);

      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseBody = jsonDecode(response.body);
        print(response.body);
        return Right(responseBody);
      } else if (response.statusCode == 404) {
        // لو جت 404، نرجع البيانات مفسرة بدل الخطأ العام
        var responseBody = jsonDecode(response.body);
        print(response.body);
        return Right(responseBody); // نرجعها كـ Right عشان تقدر تتعامل معها في الكود اللي يستقبل البيانات
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  } catch (_) {
    return const Left(StatusRequest.serverFailure);
  }
}


  Future<Either<StatusRequest, dynamic>> post(
    String url,
    Map<String, dynamic> data,
    Map<String, String>? headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        print(response);

        var responseBody = jsonDecode(response.body);
        return Right(responseBody); // سواء كان success: false أو true
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print('❌ Exception during post: $e');
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, String>> postDataUser(
    String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
    bool profile,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.post(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        var decodeResponse = json.decode(response.body);
        print('Response: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (profile) {
            var user = UserModel.fromRawJson(response.body);
            var name = user.user.name;
            var phone = decodeResponse['data']['email'];
            //  var name = user.user.name;

            await MyServices().saveUserInfo(user);
            await MyServices.saveValue(SharedPreferencesKey.userName, 'kk');
            await MyServices.saveValue(SharedPreferencesKey.userPhone, '678');

            await MyServices().setConstName();
            await MyServices().setConstPhone();
          }
          return const Left(StatusRequest.success);
        } else {
          // ✅ التأكد من استخراج `message` أو `errors`
          String errorMessage = 'Unknown error occurred';
          if (decodeResponse.containsKey('message')) {
            errorMessage = decodeResponse['message'];
          } else if (decodeResponse.containsKey('errors')) {
            var errors = decodeResponse['errors'];
            if (errors is Map<String, dynamic>) {
              errorMessage = errors.values.map((e) => e.join(', ')).join('\n');
            }
          }

          return Right(errorMessage);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, String>> postMultipartData(
    String url,
    Map<String, String> fields,
    Map<String, File> files, // ملفات متعددة (الحقل -> الملف)
    Map<String, String> headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        // إنشاء طلب متعدد الأجزاء
        var request = http.MultipartRequest('POST', Uri.parse(url));
        request.headers.addAll(headers);

        // إضافة الحقول
        fields.forEach((key, value) {
          request.fields[key] = value;
        });

        // إضافة الملفات
        for (var entry in files.entries) {
          var fileStream = http.ByteStream(entry.value.openRead());
          var length = await entry.value.length();
          var fileName = entry.value.path.split('/').last;

          request.files.add(
            http.MultipartFile(
              entry.key, // اسم الحقل (مثل 'image' أو 'cv')
              fileStream,
              length,
              filename: fileName,
            ),
          );
        }

        // إرسال الطلب
        var response = await request.send();

        // التعامل مع الاستجابة
        var responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');

        if (response.statusCode == 200 || response.statusCode == 201) {
          return Left(StatusRequest.success);
        } else {
          return Right('Failed with status code: ${response.statusCode}');
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, String>> deleteData(
    String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
  ) async {
    try {
      if (await HelperFunctions.checkInternet()) {
        var response = await http.delete(
          Uri.parse(url),
          body: data,
          headers: headers,
        );

        var decodeResponse = json.decode(response.body);
        print('Response: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          //  var user = UserModel.fromRawJson(response.body);

          return const Left(StatusRequest.success);
        } else {
          // ✅ التأكد من استخراج `message` أو `errors`
          String errorMessage = 'Unknown error occurred';
          if (decodeResponse.containsKey('message')) {
            errorMessage = decodeResponse['message'];
          } else if (decodeResponse.containsKey('errors')) {
            var errors = decodeResponse['errors'];
            if (errors is Map<String, dynamic>) {
              errorMessage = errors.values.map((e) => e.join(', ')).join('\n');
            }
          }

          return Right(errorMessage);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (error) {
      print('Error: $error');
      return const Left(StatusRequest.failure);
    }
  }
}
