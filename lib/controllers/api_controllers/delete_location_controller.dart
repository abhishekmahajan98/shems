import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';

class DeleteLocationController extends GetxController {
  Future<void> deleteLocation(String loc_id) async {
    User user = Get.put(User());
    var url = Uri.parse(ApiEndPoints.baseUrl +
        '/v1/customer/' +
        user.c_id.toString() +
        '/service-location/' +
        loc_id);
    try {
      http.Response response = await http.delete(url);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Location Deleted", "Please reload the page to see the changes");
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.dialog(Dialog(
        child: Text(e.toString()),
      ));
    }
  }
}
