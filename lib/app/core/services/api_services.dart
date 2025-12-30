import 'dart:developer';

import 'package:dio/dio.dart' as Di;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/controllers/user_controller.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/resolve_responce.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';

class ApiServices {
  UserController userController = Get.find<UserController>();
  final dio = Di.Dio();

  final baseUrl = AllEndPoints.baseUrl;

  String? token;

  Future<GenericResponse> getRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? bodyParameters,
  }) async {
    try {
      token = userController.userModel?.token ?? '';
      Di.Response response;
      debugPrint(baseUrl + endpoint);
      response = await dio
          .get(
            baseUrl + endpoint,
            queryParameters: queryParameters,
            data: bodyParameters,
            options: Di.Options(
              headers: {
                Di.Headers.contentTypeHeader: 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          )
          .timeout(const Duration(seconds: 30));
      debugPrint(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on Di.DioException catch (e) {
      debugPrint("error-->${e.response?.data}");
      return responseHandler(e.response?.data!, status: e.response?.statusCode);
    } on FormatException catch (formatException) {
      debugPrint("format exception-->$formatException");
      return GenericResponse(
          message: formatException.message, success: false, data: {});
    } catch (timeoutException) {
      return GenericResponse(
          message: "Oops server is taking too much time",
          success: false,
          data: {});
    }
  }

  Future<GenericResponse> postRequest({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Object? bodyParameters,
  }) async {
    try {
      token = userController.userModel?.token ?? '';
      Di.Response response;
      log(baseUrl + endpoint);

      debugPrint("request ---->$bodyParameters");
      response = await dio
          .post(
            baseUrl + endpoint,
            data: bodyParameters,
            queryParameters: queryParameters,
            options: Di.Options(
              headers: {
                Di.Headers.contentTypeHeader: 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          )
          .timeout(const Duration(seconds: 30));
      log(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on Di.DioException catch (e) {
      // if (e.type == DioExceptionType.connectionTimeout) {
      //   // throw Exception("Connection Timeout Exception");
      //  return GenericResponse(
      //       message:"Oops Server taking too much time to responde" , success: false, data: {});
      // }
      debugPrint("main error-->$e");
      debugPrint("error-->${e.response?.data}");
      return responseHandler(e.response?.data!, status: e.response?.statusCode);
    } on FormatException catch (formatException) {
      debugPrint("format exception-->$formatException");
      return GenericResponse(
          message: formatException.message, success: false, data: {});
    } catch (timeoutException) {
      return GenericResponse(
          message: "Oops server is taking too much time",
          success: false,
          data: {});
    }
  }

  Future<GenericResponse> putRequest(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Object? bodyParameters}) async {
    try {
      token = userController.userModel?.token ?? '';
      Di.Response response;
      log(baseUrl + endpoint);
      response = await dio
          .put(
            baseUrl + endpoint,
            data: bodyParameters,
            queryParameters: queryParameters,
            options: Di.Options(
              headers: {
                Di.Headers.contentTypeHeader: 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          )
          .timeout(const Duration(seconds: 30));
      log(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on Di.DioException catch (e) {
      debugPrint("error-->${e.response?.data}");
      return responseHandler(e.response?.data!, status: e.response?.statusCode);
    } on FormatException catch (formatException) {
      debugPrint("format exception-->$formatException");
      return GenericResponse(
          message: formatException.message, success: false, data: {});
    } catch (timeoutException) {
      return GenericResponse(
          message: "Oops server is taking too much time",
          success: false,
          data: {});
    }
  }

  Future<GenericResponse> patchRequest(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Object? bodyParameters}) async {
    try {
      token = userController.userModel?.token ?? '';
      Di.Response response;
      log(baseUrl + endpoint);
      response = await dio
          .patch(
            baseUrl + endpoint,
            data: bodyParameters,
            queryParameters: queryParameters,
            options: Di.Options(
              headers: {
                Di.Headers.contentTypeHeader: 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          )
          .timeout(const Duration(seconds: 30));
      log(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on Di.DioException catch (e) {
      debugPrint("error-->${e.response?.data}");
      return responseHandler(e.response?.data!, status: e.response?.statusCode);
    } on FormatException catch (formatException) {
      debugPrint("format exception-->$formatException");
      return GenericResponse(
          message: formatException.message, success: false, data: {});
    } catch (timeoutException) {
      return GenericResponse(
          message: "Oops server is taking too much time",
          success: false,
          data: {});
    }
  }

  Future<GenericResponse> deleteRequest(
      {required String endpoint,
      Map<String, dynamic>? queryParameters,
      Object? bodyParameters}) async {
    try {
      token = userController.userModel?.token ?? '';
      Di.Response response;
      log(baseUrl + endpoint);
      response = await dio
          .delete(
            baseUrl + endpoint,
            data: bodyParameters,
            queryParameters: queryParameters,
            options: Di.Options(
              headers: {
                Di.Headers.contentTypeHeader: 'application/json',
                'Authorization': 'Bearer $token',
              },
            ),
          )
          .timeout(const Duration(seconds: 30));
      log(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on Di.DioException catch (e) {
      debugPrint("error-->${e.response?.data}");
      return responseHandler(e.response?.data!, status: e.response?.statusCode);
    } on FormatException catch (formatException) {
      debugPrint("format exception-->$formatException");
      return GenericResponse(
          message: formatException.message, success: false, data: {});
    } catch (timeoutException) {
      return GenericResponse(
          message: "Oops server is taking too much time",
          success: false,
          data: {});
    }
  }
}
