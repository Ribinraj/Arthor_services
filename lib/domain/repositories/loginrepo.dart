import 'dart:developer';

import 'package:arthor/core/urls.dart';
import 'package:arthor/domain/token_interceptor.dart';
import 'package:arthor/widgets/shared_prferences.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse({
    this.data,
    required this.message,
    required this.error,
    required this.status,
  });
}

class LoginOtpPayload {
  final String id;
  final String loginType;

  const LoginOtpPayload({required this.id, required this.loginType});
}

class Loginrepo {
  final Dio dio;

  Loginrepo({Dio? dio})
    : dio =
          dio ??
                Dio(
                  BaseOptions(
                    baseUrl: Endpoints.baseUrl,
                    headers: {'Content-Type': 'application/json'},
                  ),
                )
            ..interceptors.add(TokenInterceptor());

  ///----------------------send otp-----------------------------////

  Future<ApiResponse<LoginOtpPayload>> sendOtp({
    required String mobileNumber,
  }) async {
    try {
      Response response = await dio.post(
        Endpoints.sendOtp,
        data: {"executiveMobile": mobileNumber},
      );
      final responseData = response.data;
      log('sendOtp response: $responseData');
      if (!responseData["error"] && responseData["status"] == 200) {
        final loginData = responseData["data"] ?? {};
        final loginType = (loginData["loginType"] ?? '').toString();
        final loginId = loginType == 'LEAD_EXECUTIVE'
            ? (loginData["leadExecutiveId"] ?? '').toString()
            : (loginData["executiveId"] ?? '').toString();

        return ApiResponse(
          data: LoginOtpPayload(id: loginId, loginType: loginType),
          message: responseData["message"] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData["message"],
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        message: 'Network or server error occured',
        error: true,
        status: 500,
      );
    }
  }

  //   //////////------------verifyotp-----------/////////////////
  Future<ApiResponse> verifyotp({
    required String loginId,
    required String loginType,
    required String executiveOtp,
  }) async {
    // log('pushtoken when login ${user.pushToken}');
    try {
      final requestBody = {
        if (loginType == 'LEAD_EXECUTIVE')
          "leadExecutiveId": loginId
        else
          "executiveId": loginId,
        "executiveOTP": executiveOtp,
        "loginType": loginType,
      };

      Response response = await dio.post(
        Endpoints.verifyotp,
        data: requestBody,
      );
      final responseData = response.data;
      log('responsestatus$responseData');
      log('responsestatus${responseData['status']}');

      if (!responseData["error"] && responseData["status"] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('USER_TOKEN', responseData["data"]["token"]);
        preferences.setString('USER_ROLE', loginType);
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);

      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  // //////////---------------resendotp--------------------////////
  Future<ApiResponse> resendotp({
    required String loginId,
    required String loginType,
  }) async {
    try {
      final requestBody = {
        if (loginType == 'LEAD_EXECUTIVE')
          "leadExecutiveId": loginId
        else
          "executiveId": loginId,
        "loginType": loginType,
      };

      Response response = await dio.post(
        Endpoints.resendotp,
        data: requestBody,
      );

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  /////////////-------------update token-----------////////////////////////////
  Future<void> updatetoken({required String token}) async {
    try {
      final userToken = await getUserToken();

      log("--------------------------------------------------");
      log("🔐 USER TOKEN CHECK");
      log(
        "User Token: ${userToken.isNotEmpty ? userToken : "❌ NO TOKEN FOUND"}",
      );
      log("--------------------------------------------------");

      log("📤 Sending FCM Token Update Request...");
      log("Request URL: ${Endpoints.setToken}");
      log("Request Body: {pushToken: $token}");
      log("Request Headers: Authorization: $userToken");

      Response response = await dio.post(
        Endpoints.setToken,
        options: Options(headers: {'Authorization': userToken}),
        data: {"pushToken": token},
      );

      final responseData = response.data;

      log("--------------------------------------------------");
      log("📥 RESPONSE RECEIVED");
      log("Status Code: ${response.statusCode}");
      log("Response Data: $responseData");
      log("--------------------------------------------------");

      if (!responseData["error"] && responseData["status"] == 200) {
        log("✅ FCM token updated successfully");
      } else {
        log("❌ Failed to update FCM token: ${responseData["message"]}");
      }
    } catch (e) {
      log("🔥 ERROR updating FCM token: $e");
    }
  }

  // // //////////-------------------fetchprofile---------------//////////////////
  //   Future<ApiResponse<ProfileModel>> fetchprofile() async {
  //     try {
  //       final token = await getUserToken();
  //       log(token);
  //       Response response = await dio.get(
  //         Endpoints.fetchprofile,
  //         options: Options(headers: {'Authorization': token}),
  //       );
  //       log("Response received: ${response.statusCode}");
  //       final responseData = response.data;
  //       // log("Response data: $responseData");
  //       //    if (responseData["status"] == 200 && responseData['message'] == "Expired token") {
  //       //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //       //   await preferences.remove('USER_TOKEN');

  //       // }
  //       if ( responseData["status"] == 200) {
  //         final user = ProfileModel.fromJson(responseData["data"]);

  //         //SharedPreferences preferences = await SharedPreferences.getInstance();

  //         // preferences.setString(
  //         //     'USER_PUSHTOKEN', responseData["data"]["pushToken"]);

  //         return ApiResponse(
  //           data: user,
  //           message: responseData['message'] ?? 'Success',
  //           error: false,
  //           status: responseData["status"],
  //         );
  //       } else {
  //         return ApiResponse(
  //           data: null,
  //           message: responseData['message'] ?? 'Something went wrong',
  //           error: true,
  //           status: responseData["status"],
  //         );
  //       }
  //     } on DioException catch (e) {
  //       debugPrint(e.message);
  //       log(e.toString());
  //       return ApiResponse(
  //         data: null,
  //         message: 'Network or server error occurred',
  //         error: true,
  //         status: 500,
  //       );
  //     } catch (e) {
  //       // Add a general catch block for other exceptions
  //       log("Unexpected error: $e");
  //       return ApiResponse(
  //         data: null,
  //         message: 'Unexpected error: $e',
  //         error: true,
  //         status: 500,
  //       );
  //     }
  //   }

  // //   /////////////---------------updateprofile----------/////////////
  //   Future<ApiResponse> updateprofile(
  //       {required EditProfileModel profile}) async {
  //     try {
  //       final token = await getUserToken();

  //       Response response = await dio.post(Endpoints.editprofile,
  //           options: Options(headers: {'Authorization': token}), data: profile);

  //       final responseData = response.data;

  //       if (!responseData["error"] && responseData["status"] == 200) {
  //         return ApiResponse(
  //           data: null,
  //           message: responseData['message'] ?? 'Success',
  //           error: false,
  //           status: responseData["status"],
  //         );
  //       } else {
  //         return ApiResponse(
  //           data: null,
  //           message: responseData['message'] ?? 'Something went wrong',
  //           error: true,
  //           status: responseData["status"],
  //         );
  //       }
  //     } on DioException catch (e) {
  //       debugPrint(e.message);
  //       log(e.toString());
  //       return ApiResponse(
  //         data: null,
  //         message: 'Network or server error occurred',
  //         error: true,
  //         status: 500,
  //       );
  //     } catch (e) {
  //       // Add a general catch block for other exceptions
  //       log("Unexpected error: $e");
  //       return ApiResponse(
  //         data: null,
  //         message: 'Unexpected error: $e',
  //         error: true,
  //         status: 500,
  //       );
  //     }
  //   }

  // //   ///////////////update token/////////////////
  // Future<void> updatetoken({required String token}) async {
  //   try {
  //   //  final userToken = await getUserToken();

  //     Response response = await dio.post(
  //       Endpoints.settoken,
  //       //options: Options(headers: {'Authorization': userToken}),
  //       data: {  "pushToken": token}
  //     );

  //     final responseData = response.data;
  //     if (!responseData["error"] && responseData["status"] == 200) {
  //       log("FCM token updated successfully");
  //     } else {
  //       log("Failed to update FCM token: ${responseData["message"]}");
  //     }
  //   } catch (e) {
  //     log("Error updating FCM token: $e");
  //   }
  // }
  //   //   /////////////deleteAccount/////////////
  //   Future<ApiResponse> deleteaccount({required String reason}) async {
  //     try {
  //       final token = await getUserToken();
  //       Response response = await dio.post(
  //         Endpoints.deleteaccount,
  //         options: Options(headers: {'Authorization': token}),
  //         data: {"reason": reason},
  //       );

  //       final responseData = response.data;
  //       if (!responseData["error"] && responseData["status"] == 200) {
  //         return ApiResponse(
  //           data: null,
  //           message: responseData['message'] ?? 'Success',
  //           error: false,
  //           status: responseData["status"],
  //         );
  //       } else {
  //         return ApiResponse(
  //           data: null,
  //           message: responseData['message'] ?? 'Something went wrong',
  //           error: true,
  //           status: responseData["status"],
  //         );
  //       }
  //     } on DioException catch (e) {
  //       debugPrint(e.message);
  //       log(e.toString());
  //       return ApiResponse(
  //         data: null,
  //         message: 'Network or server error occurred',
  //         error: true,
  //         status: 500,
  //       );
  //     }
  //   }
  void dispose() {
    dio.close();
  }
}
