import 'dart:convert';

import 'package:get/get.dart';
import 'package:shems/model/device_type.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class GetDeviceTypeController extends GetxController {
  var deviceTypes = RxList<DeviceType>();
  var selectedDevice = 'Fan'.obs;

  Future<RxList<DeviceType>> getDeviceTypes() async {
    deviceTypes.clear();
    var url = Uri.parse(ApiEndPoints.baseUrl + 'v1/device-models/device-types');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> index in data) {
        deviceTypes.add(DeviceType.fromJson(index));
      }
      //print(deviceTypes.toString());
      return deviceTypes;
    } else {
      return deviceTypes;
    }
  }
}
