import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shems/constants/color_constants.dart';
import 'package:shems/constants/size_constants.dart';
import 'package:shems/controllers/api_controllers/get_all_location_energy_controller.dart';
import 'package:shems/controllers/api_controllers/get_customer_locations_controller.dart';
import 'package:shems/model/customer_location.dart';
import 'package:shems/model/user.dart';
import 'package:shems/views/screens/customer_location_screen.dart';
import 'package:shems/views/screens/login_screen.dart';
import 'package:side_navigation/side_navigation.dart';

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
        body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(height: 50, child: Text("Dashboard")),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPreferences _prefs =
                          await SharedPreferences.getInstance();
                      _prefs.clear();
                      Get.off(LoginScreen());
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
              Card(
                elevation: 4.0,
                shadowColor: Colors.black,
                child: FutureBuilder(
                  future: getCustomerLocationsController.getCustomerLocations(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("error loading data");
                    } else if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var data = snapshot.data!;
                    return customerServiceLocationsTable(data);
                  },
                ),
              ),
              FutureBuilder(
                future: allLocationEnergyController.getAllLocationEnergy(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("error loading data");
                  } else if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  var data = snapshot.data!;
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
                    ringStrokeWidth: 24,
                    // Set the animation duration of the pie chart
                    animationDuration: const Duration(seconds: 3),
                    // Set the options for the chart values (e.g. show percentages, etc.)
                    chartValuesOptions: const ChartValuesOptions(
                        showChartValues: true,
                        showChartValuesOutside: true,
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
                },
              ),
            ],
          ),
        )
      ],
    ));
  }

  DataTable customerServiceLocationsTable(RxList<CustomerLocation> data) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Address")),
        DataColumn(label: Text("Zipcode")),
        DataColumn(label: Text("Area")),
        DataColumn(label: Text("Beds")),
        DataColumn(label: Text("Details")),
      ],
      rows: data
          .map((item) => DataRow(
                cells: [
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
                  ))
                ],
              ))
          .toList(),
    );
  }
}
