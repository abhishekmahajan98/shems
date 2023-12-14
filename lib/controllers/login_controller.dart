import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shems/model/login/login.dart';
import 'package:shems/utils/api_endpoints.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> loginWithEmail() async {
    try {
      var headers = {"Content-Type": "application/json"};
      var body = {
        "email": emailController.text.trim(),
        "password": passwordController.text
      };

      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginUrl);

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      Login loggedInDetails = Login.fromJson(response.body);

      if (response.statusCode == 200) {
        if (loggedInDetails.code == 0) {
          var token = loggedInDetails.data?.token;

          final SharedPreferences? prefs = await _prefs;

          await prefs?.setString("token", token!);

          emailController.clear();
          passwordController.clear();

          //Goto Home
          Get.to("");
        } else {
          showDialog(
              context: Get.context!,
              builder: (context) {
                return SimpleDialog(
                  title: const Text("Error"),
                  contentPadding: const EdgeInsets.all(20),
                  children: [
                    Text(loggedInDetails.message ?? "Unknown error occured")
                  ],
                );
              });
        }
      } else {
        showDialog(
            context: Get.context!,
            builder: (context) {
              return SimpleDialog(
                title: const Text("Error"),
                contentPadding: const EdgeInsets.all(20),
                children: [
                  Text(loggedInDetails.message ?? "Unknown error occured")
                ],
              );
            });
      }
    } on Exception catch (e) {
      showDialog(
          context: Get.context!,
          builder: (context) {
            return SimpleDialog(
              title: const Text("Error"),
              contentPadding: const EdgeInsets.all(20),
              children: [Text(e.toString())],
            );
          });
    }
  }
}
