import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shems/controllers/api_controllers/get_location_devices_controller.dart';
import 'package:shems/model/location_devices.dart';

class CustomerLocationScreen extends StatelessWidget {
  final String loc_id;
  const CustomerLocationScreen({super.key, required this.loc_id});

  @override
  Widget build(BuildContext context) {
    final getLocationDevices = Get.put(GetLocationDevicesController());

    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text("location id: " + loc_id.toString()),
                Text("Enrolled Devices:"),
                Card(
                  elevation: 4.0,
                  shadowColor: Colors.black,
                  child: Container(
                    child: FutureBuilder(
                      future: getLocationDevices.getLocationDevices(loc_id),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("error loading data");
                        } else if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        var data = snapshot.data!;
                        return locationDevicesTable(data);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

DataTable locationDevicesTable(RxList<LocationDevices> data) {
  return DataTable(
    columns: [
      DataColumn(label: Text("Device id")),
      DataColumn(label: Text("Model Number")),
    ],
    rows: data
        .map((item) => DataRow(
              cells: [
                DataCell(Text(item.dId.toString())),
                DataCell(Text(item.mNum.toString())),
              ],
            ))
        .toList(),
  );
}
