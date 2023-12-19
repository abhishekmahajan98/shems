import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shems/model/model_types.dart';
import 'package:shems/utils/api_endpoints.dart';

class DeviceModelTypeController extends GetxController {
  var deviceModelTypes = RxList<DeviceModelType>();
  var selectedModel = 'other'.obs;

  Future<RxList<DeviceModelType>> getDeviceModelTypes(String d_type) async {
    deviceModelTypes.clear();
    deviceModelTypes.add(DeviceModelType(mName: 'other', mNum: 'other'));
    var url = Uri.parse(ApiEndPoints.baseUrl + 'v1/device-models/' + d_type);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      for (Map<String, dynamic> index in data) {
        deviceModelTypes.add(DeviceModelType.fromJson(index));
      }
      //print(deviceTypes.toString());
      return deviceModelTypes;
    } else {
      return deviceModelTypes;
    }
  }
}
