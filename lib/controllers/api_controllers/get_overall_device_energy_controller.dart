import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shems/utils/api_endpoints.dart';

class OverallDeviceEnergyController extends GetxController {
  var headers = {'Content-Type': 'application/json'};

  Future<Map<String, List>> getOverallDeviceAvgEnergy() async {
    var url =
        Uri.parse(ApiEndPoints.baseUrl + '/v1/device-events/energy-used/avg');
    Map body = {
      "startTime": "2023-12-01 00:00:00",
      "endTime": "2023-12-31 23:59:59"
    };
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    var data = jsonDecode(response.body.toString());
    int counter = 0;
    List<String> title = [];
    List<double> avgconsumption = [];
    for (Map<String, dynamic> index in data['deviceTypes']) {
      title.add(index['devicetype']);
      avgconsumption.add(index['avgmonthlyenergyconsumption']);
      counter++;
    }
    print(title.toString());
    print(avgconsumption.toString());
    return {
      "title": title,
      "avg": avgconsumption,
    };
  }
}
