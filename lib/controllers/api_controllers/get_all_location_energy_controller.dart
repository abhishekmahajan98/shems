import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shems/model/all_location_energy.dart';
import 'package:shems/model/user.dart';
import 'package:shems/utils/api_endpoints.dart';

class AllLocationEnergyController extends GetxController {
  var allLocationEnergy = AllLocationEnergy();

  @override
  void onInit() {
    super.onInit();
    getAllLocationEnergy();
  }

  Future<Map<String, double>> getAllLocationEnergy() async {
    User user = Get.put(User());
    Map<String, double> res = {};
    var headers = {'Content-Type': 'application/json'};
    var url = Uri.parse(ApiEndPoints.baseUrl +
        'v1/customer/' +
        user.c_id.toString() +
        '/location-events/energy-used');
    Map body = {
      "startTime": "2023-12-01 00:00:00",
      "endTime": "2023-12-31 23:59:59"
    };
    http.Response response =
        await http.post(url, body: jsonEncode(body), headers: headers);
    var data = jsonDecode(response.body.toString());
    //print(data['locations']);
    for (Map<String, dynamic> index in data['locations']) {
      res[index['locationid']] = index['totalenergyusage'];
      //print(index['locationid']);
    }
    return res;
  }
}
