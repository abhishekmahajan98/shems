import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';

class EditCustomerDetailsController extends GetxController {
  TextEditingController tfController = TextEditingController();
  var selectedAttribute = 'first_name'.obs;

  Future<void> editCustomer() async {
    print("edit customer activated");
    User user = Get.put(User());
    var headers = {'Content-Type': 'application/json'};
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + 'v1/customer/' + user.c_id.toString());
      Map body = {
        "column": selectedAttribute.value.toString(),
        "newValue": tfController.text,
      };
      print(body.toString());
      http.Response response =
          await http.put(url, body: jsonEncode(body), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        tfController.clear();
        Get.snackbar("Customer Details updated",
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
