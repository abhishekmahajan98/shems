import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
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
    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text("location id: " + widget.loc_id.toString()),
                Text("Enrolled Devices:"),
                FutureBuilder(
                  future: getDeviceTypesController.getDeviceTypes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("error loading data");
                    } else if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    var data = snapshot.data!;
                    return Row(
                      children: [
                        Obx(() => DropdownButton(
                            value:
                                getDeviceTypesController.selectedDevice.value,
                            items: data
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.dType),
                                      value: e.dType.toString(),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              getDeviceTypesController.selectedDevice.value =
                                  value!;
                            })),
                        ElevatedButton(
                          onPressed: () async {
                            deviceModelTypeController.selectedModel.value =
                                'other';
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
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      FutureBuilder(
                                        future: deviceModelTypeController
                                            .getDeviceModelTypes(
                                                getDeviceTypesController
                                                    .selectedDevice.value),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text("error loading data");
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
                                                          .selectedModel.value,
                                                  items: data
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            child:
                                                                Text(e.mName!),
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
                    );
                  },
                ),
                //all location devices table
                Card(
                  elevation: 4.0,
                  shadowColor: Colors.black,
                  child: Container(
                    child: FutureBuilder(
                      future:
                          getLocationDevices.getLocationDevices(widget.loc_id),
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
                Card(
                  elevation: 4.0,
                  shadowColor: Colors.black,
                  child: Container(
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
