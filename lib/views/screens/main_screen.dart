import 'dart:math';

import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shems/constants/size_constants.dart';
import 'package:shems/controllers/api_controllers/add_location_controller.dart';
import 'package:shems/controllers/api_controllers/delete_location_controller.dart';
import 'package:shems/controllers/api_controllers/edit_location_controller.dart';
import 'package:shems/controllers/api_controllers/get_all_location_energy_controller.dart';
import 'package:shems/controllers/api_controllers/get_customer_all_devices_energy.dart';
import 'package:shems/controllers/api_controllers/get_customer_locations_controller.dart';
import 'package:shems/controllers/api_controllers/get_overall_device_energy_controller.dart';
import 'package:shems/model/customer_devices_energy_model.dart';
import 'package:shems/model/customer_location.dart';
import 'package:shems/model/user.dart';
import 'package:shems/views/screens/customer_info_screen.dart';
import 'package:shems/views/screens/customer_location_screen.dart';
import 'package:shems/views/screens/login_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // adding Get controllers
  final User user = Get.put(User());
  final GetCustomerLocationsController getCustomerLocationsController =
      Get.put(GetCustomerLocationsController());
  final allLocationEnergyController = Get.put(AllLocationEnergyController());
  final addlocationController = Get.put(AddlocationController());
  final editLocationController = Get.put(EditLocationController());
  final deleteLocationController = Get.put(DeleteLocationController());
  final customerDevicesEnergyConsumedController =
      Get.put(CustomerDevicesEnergyConsumedController());
  final overallDeviceEnergyController =
      Get.put(OverallDeviceEnergyController());

  @override
  Widget build(BuildContext context) {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Container(
                          height: 50, child: Image.asset("assets/logo.jpeg")),
                    ),
                    Text(
                      user.c_id.toString() + ' | Dashboard',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        Get.to(CustomerInfoScreen());
                      },
                      icon: Icon(Icons.settings),
                    ),
                    IconButton(
                      onPressed: () async {
                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.clear();
                        Get.off(LoginScreen());
                      },
                      icon: Icon(Icons.logout),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  elevation: 4.0,
                  shadowColor: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: defaultPadding, left: defaultPadding),
                            child: Text(
                              "Service Locations",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: defaultPadding, left: defaultPadding),
                            child: ElevatedButton(
                              onPressed: () async {
                                Get.dialog(
                                  Dialog(
                                    child: Container(
                                      height: 700,
                                      width: 500,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: defaultPadding,
                                            left: defaultPadding),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Add Location",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            getTextField(
                                                'location address',
                                                'address',
                                                false,
                                                addlocationController.address),
                                            getTextField(
                                                'zipcode',
                                                'zipcode',
                                                false,
                                                addlocationController.zipcode,
                                                isNumeric: true),
                                            getTextField(
                                                'occupants',
                                                'occupants',
                                                false,
                                                addlocationController.occupants,
                                                isNumeric: true),
                                            getTextField('beds', 'beds', false,
                                                addlocationController.beds,
                                                isNumeric: true),
                                            getTextField('area', 'area', false,
                                                addlocationController.area,
                                                isNumeric: true),
                                            ElevatedButton(
                                              onPressed: () {
                                                addlocationController
                                                    .addLocation();
                                              },
                                              child: Text("Add"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text("Add Location"),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: getCustomerLocationsController
                            .getCustomerLocations(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("error loading data");
                          } else if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          }
                          var data = snapshot.data!;
                          return customerServiceLocationsTable(
                              data, editLocationController);
                        },
                      ),
                    ],
                  ),
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
                          future: allLocationEnergyController
                              .getAllLocationEnergy(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Card(
                    elevation: 4.0,
                    shadowColor: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: defaultPadding, left: defaultPadding),
                          child: Text(
                            "Enrolled Devices",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        FutureBuilder(
                          future: customerDevicesEnergyConsumedController
                              .getLocationEnergyTableData(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text("error loading data");
                            } else if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }
                            var data = snapshot.data!;

                            return customerDevicesEnergyTable(
                                data, customerDevicesEnergyConsumedController);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 4.0,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: defaultPadding, left: defaultPadding),
                                child: Text(
                                  "% Energy Usage by devices",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                              Container(
                                width: 400,
                                height: 400,
                                child: FutureBuilder(
                                  future:
                                      customerDevicesEnergyConsumedController
                                          .getLocationEnergyPie(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text("error loading data");
                                    } else if (!snapshot.hasData) {
                                      return CircularProgressIndicator();
                                    }
                                    var data = snapshot.data!;
                                    if (data.length > 0) {
                                      return allLocationsEnergyPieChart(data,
                                          colorList, context, gradientList);
                                    } else {
                                      return Center(
                                          child: Text("Insufficient Data"));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 4.0,
                        shadowColor: Colors.black,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: defaultPadding, left: defaultPadding),
                              child: Text(
                                "Average energy usage by device type in kWh/5 mins",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            Container(
                              height: 600,
                              width: 400,
                              child: FutureBuilder(
                                future: overallDeviceEnergyController
                                    .getOverallDeviceAvgEnergy(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("error loading data");
                                  } else if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  var data = snapshot.data!;
                                  List<double> avg =
                                      data['avg'] as List<double>;

                                  List<String> title =
                                      data['title'] as List<String>;

                                  return fl.BarChart(
                                    fl.BarChartData(
                                      minY: 0,
                                      maxY: avg!.reduce((curr, next) =>
                                              curr > next ? curr : next) *
                                          1.2,
                                      titlesData: fl.FlTitlesData(
                                        bottomTitles: fl.AxisTitles(
                                          sideTitles: _bottomTitles(title),
                                        ),
                                      ),
                                      barGroups: avg!
                                          .map(
                                            (value) => fl.BarChartGroupData(
                                                x: avg.indexOf(value),
                                                barRods: [
                                                  fl.BarChartRodData(
                                                      toY: value,
                                                      color: Colors.white70,
                                                      width: 25),
                                                ]),
                                          )
                                          .toList(),
                                    ),
                                  );
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
            )
          ],
        ),
      ],
    ));
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
          chartValueStyle: TextStyle(color: Colors.white),
          showChartValuesOutside: false,
          showChartValuesInPercentage: true,
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

  DataTable customerServiceLocationsTable(RxList<CustomerLocation> data,
      EditLocationController editLocationController) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Location ID")),
        DataColumn(label: Text("Address")),
        DataColumn(label: Text("Zipcode")),
        DataColumn(label: Text("Area")),
        DataColumn(label: Text("Beds")),
        DataColumn(label: Text("Details")),
        DataColumn(label: Text("Edit")),
        DataColumn(label: Text("Delete"))
      ],
      rows: data
          .map((item) => DataRow(
                cells: [
                  DataCell(Text(item.locId.toString())),
                  DataCell(Text(item.locAddress.toString())),
                  DataCell(Text(item.zipcode.toString())),
                  DataCell(Text(item.areaByFoot.toString())),
                  DataCell(Text(item.beds.toString())),
                  DataCell(ElevatedButton(
                    onPressed: () {
                      Get.to(CustomerLocationScreen(
                          loc_id: item.locId.toString()));
                    },
                    child: Text("Check Details"),
                  )),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Get.dialog(
                          getEditLocationDialog(item, editLocationController),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Get.dialog(Dialog(
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      "Are you sure you want to delete this location?"),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            defaultPadding),
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              deleteLocationController
                                                  .deleteLocation(
                                                item.locId.toString(),
                                              );
                                            },
                                            child: Text("Yes")),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                      },
                    ),
                  )
                ],
              ))
          .toList(),
    );
  }

  DataTable customerDevicesEnergyTable(
      RxList<DevicesEnergy> data,
      CustomerDevicesEnergyConsumedController
          customerDevicesEnergyConsumedController) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Device ID")),
        DataColumn(label: Text("Device Type")),
        DataColumn(label: Text("Avg. Energy Usage per 5min")),
        DataColumn(label: Text("Total Energy Usage")),
      ],
      rows: data
          .map((item) => DataRow(
                cells: [
                  DataCell(Text(item.dId.toString())),
                  DataCell(Text(item.dType.toString())),
                  DataCell(Text(item.averageenergyusage.toString())),
                  DataCell(Text(item.totalenergyusage.toString())),
                ],
              ))
          .toList(),
    );
  }

  Dialog getEditLocationDialog(
      CustomerLocation item, EditLocationController editLocationController) {
    return Dialog(
      child: Container(
        height: 400,
        width: 400,
        child: Padding(
          padding:
              const EdgeInsets.only(top: defaultPadding, left: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Update Details for the location:" + item.locId.toString()),
              Obx(
                () => DropdownButton(
                  value: editLocationController.selectedAttribute.value,
                  items: [
                    DropdownMenuItem(
                      child: Text("Location Address"),
                      value: 'loc_address',
                    ),
                    DropdownMenuItem(
                      child: Text("Occupants"),
                      value: 'occupants',
                    ),
                    DropdownMenuItem(
                      child: Text("area"),
                      value: 'area_by_foot',
                    ),
                    DropdownMenuItem(
                      child: Text("beds"),
                      value: 'beds',
                    ),
                  ],
                  onChanged: (value) {
                    editLocationController.selectedAttribute.value =
                        value.toString();
                  },
                ),
              ),
              getTextField('New Value', 'type value to be updated', false,
                  editLocationController.tfController),
              ElevatedButton(
                onPressed: () async {
                  await editLocationController
                      .editLocation(item.locId.toString());
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

fl.SideTitles _bottomTitles(List<String> l) {
  return fl.SideTitles(
    reservedSize: 100,
    showTitles: true,
    getTitlesWidget: (value, meta) {
      return Container(
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(" " + l[value.toInt()]),
        ),
      );
    },
  );
}
