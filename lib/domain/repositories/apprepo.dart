import 'dart:developer';

import 'package:arthor/core/urls.dart';
import 'package:arthor/data/cases_model.dart';
import 'package:arthor/data/dashboard_model.dart';
import 'package:arthor/domain/token_interceptor.dart';

import 'package:arthor/widgets/shared_prferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


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

class Apprepo {
  final Dio dio;

  Apprepo({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.baseUrl,
              headers: {'Content-Type': 'application/json'},
            ),
          )..interceptors.add(TokenInterceptor());
          //////////////----------fetchdashboard----------///////////////
  Future<ApiResponse<DashboardModel>> fetchdashboard() async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.get(
        Endpoints.dashboard,
        options: Options(headers: {'Authorization': token}),
      );
      log("Response received: ${response.statusCode}");
      final responseData = response.data;
      // log("Response data: $responseData");
      //    if (responseData["status"] == 200 && responseData['message'] == "Expired token") {
      //   SharedPreferences preferences = await SharedPreferences.getInstance();
      //   await preferences.remove('USER_TOKEN');
   
      // }
      if ( responseData["status"] == 200) {
        final dashboard = DashboardModel.fromJson(responseData["data"]);

        //SharedPreferences preferences = await SharedPreferences.getInstance();

        // preferences.setString(
        //     'USER_PUSHTOKEN', responseData["data"]["pushToken"]);

        return ApiResponse(
          data:dashboard,
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
    } catch (e) {
      // Add a general catch block for other exceptions
      log("Unexpected error: $e");
      return ApiResponse(
        data: null,
        message: 'Unexpected error: $e',
        error: true,
        status: 500,
      );
    }
  }
  ///////-------------fetchnewCases-----------/////////////
  Future<ApiResponse<List<CaseDataModel>>>fetchnewcases() async {
    // log('pushtoken when login ${user.pushToken}');
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.newcases, options: Options(headers: {'Authorization': token}));
      final responseData = response.data;


      if (responseData["status"] == 200) {
        final List<dynamic> newcases = responseData['data'];
        List<CaseDataModel> fetchednewcases = newcases
            .map((cases) => CaseDataModel.fromJson(cases))
            .toList();
        return ApiResponse(
          data: fetchednewcases,
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
    ///////-------------fetchAssignedcases-----------/////////////
  Future<ApiResponse<List<CaseDataModel>>>fetchasignnedcases() async {
    // log('pushtoken when login ${user.pushToken}');
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.newcases, options: Options(headers: {'Authorization': token}));
      final responseData = response.data;


      if (responseData["status"] == 200) {
        final List<dynamic> newcases = responseData['data'];
        List<CaseDataModel> fetchednewcases = newcases
            .map((cases) => CaseDataModel.fromJson(cases))
            .toList();
        return ApiResponse(
          data: fetchednewcases,
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
        //   //////////------------Accept Request-----------/////////////////
  Future<ApiResponse>acceptrequest({required String caseId}) async {
  
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.acceptcase, data: {
     "caseId": caseId
},options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   
log("Response data statusssssss: $responseData");
 
      if (!responseData["error"] && responseData["status"] == 200) {

        return ApiResponse(
          data:null,
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
          //   //////////------------Accept Request-----------/////////////////
  Future<ApiResponse>declinerequest({required String caseId}) async {
  
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.declinecase, data: {
     "caseId": caseId
},options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   
log("Response data statusssssss: $responseData");
 
      if (!responseData["error"] && responseData["status"] == 200) {

        return ApiResponse(
          data:null,
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
  void dispose() {
    dio.close();
  }
}
