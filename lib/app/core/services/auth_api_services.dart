import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/services/resolve_responce.dart';
import 'package:gold/app/core/services/urls_and_endpoints.dart';

class AuthApiServices {
  final dio = Dio();

  final baseUrl = AllEndPoints.baseUrl;
  // AuthApiServices() {
  //   dio.options.contentType = Headers.jsonContentType;
  // }

  Future<GenericResponse> signupRequest(
      {required String endpoint, Object? bodyParameters}) async {
    Response response;
    log(baseUrl + endpoint);
    log(bodyParameters.toString());
    try {
      response = await dio
          .post(
            baseUrl + endpoint,
            data: bodyParameters,
            options: Options(
              headers: {Headers.contentTypeHeader: 'application/json'},
            ),
          )
          .timeout(const Duration(seconds: 30));

      log(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on DioException catch (e) {
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

  Future<GenericResponse> loginRequest(
      {required String endpoint, Object? bodyParameters}) async {
    Response response;

    log(baseUrl + endpoint);
    debugPrint(bodyParameters.toString());
    try {
      response = await dio
          .post(
            baseUrl + endpoint,
            data: bodyParameters,
            options: Options(
              headers: {Headers.contentTypeHeader: 'application/json'},
            ),
          )
          .timeout(const Duration(seconds: 30));
      log(response.toString());
      return responseHandler(response.data, status: response.statusCode);
    } on DioException catch (e) {
      log("under dio exception");

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
