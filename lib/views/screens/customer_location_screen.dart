import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shems/constants/size_constants.dart';
import 'package:shems/controllers/api_controllers/add_device_controller.dart';
import 'package:shems/controllers/api_controllers/get_device_model_type_controller.dart';
import 'package:shems/controllers/api_controllers/get_device_type_controller.dart';
import 'package:shems/controllers/api_controllers/get_location_device_energy_consumed.dart';
import 'package:shems/controllers/api_controllers/get_location_devices_controller.dart';
import 'package:shems/model/location_device_energy_consumer.dart';
import 'package:shems/model/location_devices.dart';
import 'package:shems/utils/defaultTextField.dart';

class CustomerLocationScreen extends StatefulWidget {
  final String loc_id;
  const CustomerLocationScreen({super.key, required this.loc_id});

  @override
  State<CustomerLocationScreen> createState() => _CustomerLocationScreenState();
}

class _CustomerLocationScreenState extends State<CustomerLocationScreen> {
  @override
  Widget build(BuildContext context) {
    final getLocationDevices = Get.put(GetLocationDevicesController());
    final getDeviceTypesController = Get.put(GetDeviceTypeController());
    final locationDeviceEnergyConsumedController =
        Get.put(LocationDeviceEnergyConsumedController());
    final deviceModelTypeController = Get.put(DeviceModelTypeController());
    final addDeviceController = Get.put(AddDeviceontroller());
    List<Color> colorList = [
      const Color(0xffD95AF3),
      const Color(0xff3EE094),
      const Color(0xff3398F6),
      const Color(0xffFA4A42),
      const Color(0xffFE9539)
    ];

    // List of gradients for the
    // background of the pie chart
    final gradientList = <List<Color>>[
      [
        Color.fromRGBO(223, 250, 92, 1),
        Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        Color.fromRGBO(129, 182, 205, 1),
        Color.fromRGBO(91, 253, 199, 1),
      ],
      [
        Color.fromRGBO(175, 63, 62, 1.0),
        Color.fromRGBO(254, 154, 92, 1),
      ]
    ];
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Text(
                        widget.loc_id.toString() + ' | Devices Page',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    FutureBuilder(
                      future: getDeviceTypesController.getDeviceTypes(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("error loading data");
                        } else if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        var data = snapshot.data!;
                        return Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Row(
                            children: [
                              Obx(() => DropdownButton(
                                  value: getDeviceTypesController
                                      .selectedDevice.value,
                                  items: data
                                      .map((e) => DropdownMenuItem(
                                            child: Text(e.dType),
                                            value: e.dType.toString(),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    getDeviceTypesController
                                        .selectedDevice.value = value!;
                                  })),
                              ElevatedButton(
                                onPressed: () async {
                                  deviceModelTypeController
                                      .selectedModel.value = 'other';
                                  Get.dialog(Dialog(
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: defaultPadding,
                                            left: defaultPadding),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Select Device Model for " +
                                                  getDeviceTypesController
                                                      .selectedDevice
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            FutureBuilder(
                                              future: deviceModelTypeController
                                                  .getDeviceModelTypes(
                                                      getDeviceTypesController
                                                          .selectedDevice
                                                          .value),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasError) {
                                                  return Text(
                                                      "error loading data");
                                                } else if (!snapshot.hasData) {
                                                  return CircularProgressIndicator();
                                                }
                                                var data = snapshot.data!;
                                                return Column(
                                                  children: [
                                                    Text("Model List"),
                                                    Obx(
                                                      () => DropdownButton(
                                                        value:
                                                            deviceModelTypeController
                                                                .selectedModel
                                                                .value,
                                                        items: data
                                                            .map((e) =>
                                                                DropdownMenuItem(
                                                                  child: Text(
                                                                      e.mName!),
                                                                  value: e.mNum,
                                                                ))
                                                            .toList(),
                                                        onChanged: (value) {
                                                          deviceModelTypeController
                                                              .selectedModel
                                                              .value = value!;
                                                        },
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          addDeviceController.addDevice(
                                                              widget.loc_id,
                                                              deviceModelTypeController
                                                                  .selectedModel
                                                                  .value);
                                                        },
                                                        child: Text("Add")),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                                },
                                child: Text("Add Device"),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    //devices energy table
                    Card(
                      elevation: 4.0,
                      shadowColor: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Text(
                              'Enrolled Devices Energy Use for the location',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Container(
                            child: FutureBuilder(
                              future: locationDeviceEnergyConsumedController
                                  .getLocationEnergyTableData(widget.loc_id),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text("error loading data");
                                } else if (!snapshot.hasData) {
                                  return CircularProgressIndicator();
                                }
                                var data = snapshot.data!;
                                return locationActiveDevicesTable(data);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //all location devices table
                    Card(
                      elevation: 4.0,
                      shadowColor: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Text(
                              'All Enrolled Devices for the location',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Container(
                            child: FutureBuilder(
                              future: getLocationDevices
                                  .getLocationDevices(widget.loc_id),
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
                        ],
                      ),
                    ),
                  ],
                ),
                Card(
                  elevation: 4,
                  shadowColor: Colors.black,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: defaultPadding),
                        child: Text(
                          "% Energy Use by the Location",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 400,
                        child: FutureBuilder(
                          future: locationDeviceEnergyConsumedController
                              .getLocationEnergyPie(widget.loc_id.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("error loading data");
                            } else if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            var data = snapshot.data!;
                            if (data.length > 0) {
                              return allLocationsEnergyPieChart(
                                  data, colorList, context, gradientList);
                            } else {
                              return Center(child: Text("Insufficient Data"));
                            }
                          },
                        ),
                      ),
                    ],
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

PieChart allLocationsEnergyPieChart(
    Map<String, double> data,
    List<Color> colorList,
    BuildContext context,
    List<List<Color>> gradientList) {
  return PieChart(
    dataMap: data,
    // Set the colors for the
    // pie chart segments
    colorList: colorList,
    // Set the radius of the pie chart
    chartRadius: MediaQuery.of(context).size.width / 2,
    // Set the center text of the pie chart
    centerText: "Energy Usage ",
    // Set the width of the
    // ring around the pie chart
    ringStrokeWidth: 20,

    // Set the animation duration of the pie chart
    animationDuration: const Duration(seconds: 3),
    // Set the options for the chart values (e.g. show percentages, etc.)
    chartValuesOptions: const ChartValuesOptions(
        showChartValues: true,
        showChartValuesOutside: false,
        showChartValuesInPercentage: true,
        chartValueStyle: TextStyle(color: Colors.white),
        showChartValueBackground: false),
    // Set the options for the legend of the pie chart
    legendOptions: const LegendOptions(
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(fontSize: 15),
        legendPosition: LegendPosition.left,
        showLegendsInRow: false),
    // Set the list of gradients for
    // the background of the pie chart
    gradientList: gradientList,
  );
}

DataTable locationDevicesTable(RxList<LocationDevices> data) {
  return DataTable(
    columns: [
      DataColumn(label: Text("Device id")),
      DataColumn(label: Text("Device Type")),
      DataColumn(label: Text("Model Number")),
      DataColumn(label: Text("Model Name")),
      DataColumn(label: Text("Model Properties")),
    ],
    rows: data
        .map((item) => DataRow(
              cells: [
                DataCell(Text(item.dId.toString())),
                DataCell(Text(item.dType.toString())),
                DataCell(Text(item.mNum.toString())),
                DataCell(Text(item.mName.toString())),
                DataCell(Text(item.mProps.toString())),
              ],
            ))
        .toList(),
  );
}

DataTable locationActiveDevicesTable(RxList<Devices> data) {
  return DataTable(
    columns: [
      DataColumn(label: Text("Device id")),
      DataColumn(label: Text("Model Number")),
      DataColumn(label: Text("Model Name")),
      DataColumn(label: Text("Total Energy Usage")),
      DataColumn(label: Text("Total Energy Cost")),
    ],
    rows: data
        .map((item) => DataRow(
              cells: [
                DataCell(Text(item.deviceid.toString())),
                DataCell(Text(item.mNum.toString())),
                DataCell(Text(item.mName.toString())),
                DataCell(Text(item.totalenergyusage.toString())),
                DataCell(Text(item.totalenergycost.toString())),
              ],
            ))
        .toList(),
  );
}
