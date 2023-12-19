import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AddDeviceontroller extends GetxController {
  Future<void> addDevice(String loc_id, String m_num) async {
    User user = Get.put(User());
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          'v1/customer/' +
          user.c_id.toString() +
          '/service-location/' +
          loc_id +
          '/device');
      Map body = {"m_num": m_num};
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        Get.snackbar(
            "Location Added", "Please reload the page to see the changes");
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
