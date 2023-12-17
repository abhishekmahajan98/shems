import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:shems/views/screens/main_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.login);
      Map body = {
        'email': emailController.text.trim(),
        'pwd': passwordController.text
      };
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var token = json['c_id'];
        print(token);
        final SharedPreferences? prefs = await _prefs;
        await prefs?.setString('c_id', token);
        final User user = Get.put(User());
        user.updatecid(token);
        emailController.clear();
        passwordController.clear();
        Get.off(MainScreen());
        /*String? cookies = response.headers['PDS-AUTH'];
        print(response);
        print(cookies);
        if (cookies != null) {
          var token = cookies;
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('t', token);

          emailController.clear();
          passwordController.clear();
          Get.off(MainScreen());
        } else {
          throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
        }*/
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: Text('Error'),
              contentPadding: EdgeInsets.all(20),
              children: [Text(error.toString())],
            );
          });
    }
  }
}
