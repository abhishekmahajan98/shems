import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/model/customer_details.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class CustomerDetailsController extends GetxController {
  Future<CustomerDetails> getCustomerDetails() async {
    User user = Get.put(User());
    var url = Uri.parse(
        ApiEndPoints.baseUrl + '/v1/customer/' + user.c_id.toString());
    try {
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        CustomerDetails res =
            CustomerDetails.fromJson(jsonDecode(response.body));
        print(response.body);
        return res;
      } else {
        throw jsonDecode(response.body)["message"] ?? "Unknown Error Occured";
      }
    } catch (e) {
      Get.dialog(Dialog(
        child: Text(e.toString()),
      ));
    }
    return CustomerDetails();
  }
}
