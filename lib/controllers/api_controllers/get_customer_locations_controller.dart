import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shems/model/customer_location.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';

class GetCustomerLocationsController extends GetxController {
  var customerLocations = RxList<CustomerLocation>();

  Future<RxList<CustomerLocation>> getCustomerLocations() async {
    User user = Get.put(User());
    var url = Uri.parse(ApiEndPoints.baseUrl +
        'v1/customer/' +
        user.c_id.toString() +
        '/service-locations');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> index in data) {
        customerLocations.add(CustomerLocation.fromJson(index));
        //print(index.toString());
      }
      return customerLocations;
    } else {
      return customerLocations;
    }
  }
}
