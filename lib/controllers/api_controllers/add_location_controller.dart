import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class AddlocationController extends GetxController {
  TextEditingController address = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController beds = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController occupants = TextEditingController();
  Future<void> addLocation() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      User user = Get.put(User());
      var url = Uri.parse(ApiEndPoints.baseUrl +
          'v1/customer/' +
          user.c_id.toString() +
          '/service-location');
      Map body = {
        "loc_address": address.text,
        "area_by_foot": area.text,
        "beds": beds.text,
        "occupants": occupants.text,
        "zipcode": zipcode.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        //await prefs?.setString('token', token);
        address.clear();
        occupants.clear();
        zipcode.clear();
        beds.clear();
        area.clear();
        occupants.clear();
        Get.snackbar(
            "Location Added", "Please reload the page to see the changes");
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
