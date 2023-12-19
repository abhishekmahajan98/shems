import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';

class EditLocationController extends GetxController {
  TextEditingController tfController = TextEditingController();
  var selectedAttribute = 'loc_address'.obs;

  Future<void> editLocation(String loc_id) async {
    print("editlocation activated");
    User user = Get.put(User());
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(ApiEndPoints.baseUrl +
          'v1/customer/' +
          user.c_id.toString() +
          '/service-location/' +
          loc_id);
      print(url);
      print(selectedAttribute.value.toString() + " " + tfController.text);
      Map body = {
        "column": selectedAttribute.value.toString(),
        "newValue": tfController.text
      };
      http.Response response =
          await http.put(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        tfController.clear();
        Get.snackbar("Location data updated",
            "Please reload the page to see the changes");
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
