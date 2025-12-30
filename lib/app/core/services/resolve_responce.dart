import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/models/generic_response_model.dart';
import 'package:gold/app/core/status_code.dart';
import 'package:gold/app/routes/app_pages.dart';

GenericResponse responseHandler(Map<String, dynamic> response, {int? status}) {
  // log("under response");
  debugPrint("response success----->${response['success']}");
  debugPrint("response message----->${response['message']}");
  debugPrint("response data----->${response['data']}");

  if (status == HttpStatusCodes.OK) {
    return GenericResponse(
        success: true, message: response['message'], data: response);
  } else if (status == HttpStatusCodes.CREATED) {
    return GenericResponse(
        success: true, message: response['message'], data: response);
  } else if (status == HttpStatusCodes.ACCEPTED) {
    return GenericResponse(
        success: true, message: response['message'], data: response);
  } else if (status == HttpStatusCodes.UNAUTHORIZED) {
    Get.toNamed(Routes.LOGIN);
    return GenericResponse(
        success: false, message: response['message'], data: {});
  } else {
    return GenericResponse(
        success: false, message: response['message'], data: {});
  }
}
