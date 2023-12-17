import 'dart:convert';

import 'package:get/get.dart';
import 'package:shems/model/location_devices.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetLocationDevicesController extends GetxController {
  var locationDevices = RxList<LocationDevices>();
  Future<RxList<LocationDevices>> getLocationDevices(String loc_id) async {
    User user = Get.put(User());
    var url = Uri.parse(ApiEndPoints.baseUrl +
        'v1/customer/' +
        user.c_id.toString() +
        '/service-location/' +
        loc_id +
        '/devices');
    final response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> index in data) {
        locationDevices.add(LocationDevices.fromJson(index));
        //print(index.toString());
      }
      return locationDevices;
    } else {
      return locationDevices;
    }
  }
}
