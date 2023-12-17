import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shems/utils/api_endpoints.dart';
import 'package:shems/views/screens/login_screen.dart';

class RegisterationController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController billingAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.register);
      Map body = {
        "c_id": usernameController.text,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "phn": phoneNumberController.text,
        "billing_address": billingAddressController.text,
        "email": emailController.text,
        "pwd": passwordController.text,
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        //await prefs?.setString('token', token);
        firstNameController.clear();
        lastNameController.clear();
        usernameController.clear();
        phoneNumberController.clear();
        billingAddressController.clear();
        emailController.clear();
        passwordController.clear();
        Get.off(LoginScreen());
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
