import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shems/model/location_device_energy_consumer.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class LocationDeviceEnergyConsumedController extends GetxController {
  //var LocationEnergyPieData = LocationDeviceEnergyConsumedModel();
  var locationEnergyTableData = RxList<Devices>();

  Future<http.Response> getResponseData(String c_id, String loc_id) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl +
        'v1/customer/' +
        c_id.toString() +
        '/service-location/' +
        loc_id +
        '/events/energy-used');
    // TODO: MAKE IT LAST 30 DAYS
    Map body = {
      "startTime": "2023-12-01 00:00:00",
      "endTime": "2023-12-31 23:59:59"
    };

    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    //print(response.body);
    return response;
  }

  Future<Map<String, double>> getLocationEnergyPie(String loc_id) async {
    User user = Get.put(User());
    Map<String, double> res = {};
    http.Response response =
        await getResponseData(user.c_id.toString(), loc_id);
    var data = jsonDecode(response.body.toString());
    print(data['devices']);
    for (Map<String, dynamic> index in data['devices']) {
      res[index['deviceid']] = index['totalenergyusage'];
    }
    return res;
  }

  Future<RxList<Devices>> getLocationEnergyTableData(String loc_id) async {
    locationEnergyTableData.clear();
    User user = Get.put(User());
    http.Response response =
        await getResponseData(user.c_id.toString(), loc_id);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> index in data['devices']) {
        locationEnergyTableData.add(Devices.fromJson(index));
        //print(index.toString());
      }
      return locationEnergyTableData;
    } else {
      return locationEnergyTableData;
    }
  }
}
