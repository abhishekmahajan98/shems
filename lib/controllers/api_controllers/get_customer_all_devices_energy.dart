import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shems/model/customer_devices_energy_model.dart';
import 'package:shems/utils/api_endpoints.dart';

import '../../model/user.dart';

class CustomerDevicesEnergyConsumedController extends GetxController {
  //var LocationEnergyPieData = LocationDeviceEnergyConsumedModel();
  var customerDeviceEnergyTableData = RxList<DevicesEnergy>();

  Future<http.Response> getResponseData(String c_id) async {
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl +
        'v1/customer/' +
        c_id.toString() +
        '/device-events/energy-used');
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

  Future<Map<String, double>> getLocationEnergyPie() async {
    User user = Get.put(User());
    Map<String, double> res = {};
    http.Response response = await getResponseData(user.c_id.toString());
    var data = jsonDecode(response.body.toString());
    for (Map<String, dynamic> index in data['devices']) {
      res[index['d_id']] = index['totalenergyusage'];
    }
    return res;
  }

  Future<RxList<DevicesEnergy>> getLocationEnergyTableData() async {
    customerDeviceEnergyTableData.clear();
    User user = Get.put(User());
    http.Response response = await getResponseData(user.c_id.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      //print(data['devices']);
      for (Map<String, dynamic> index in data['devices']) {
        customerDeviceEnergyTableData.add(DevicesEnergy.fromJson(index));
      }
      return customerDeviceEnergyTableData;
    } else {
      return customerDeviceEnergyTableData;
    }
  }
}
