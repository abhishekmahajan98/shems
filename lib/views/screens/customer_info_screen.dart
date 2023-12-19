import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shems/constants/size_constants.dart';
import 'package:shems/controllers/api_controllers/edit_customer_details.dart';
import 'package:shems/controllers/api_controllers/get_customer_details_controller.dart';
import 'package:shems/utils/defaultTextField.dart';

class CustomerInfoScreen extends StatelessWidget {
  const CustomerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerDetailsController = Get.put(CustomerDetailsController());
    final editCustomerDetailsController =
        Get.put(EditCustomerDetailsController());
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Card(
                elevation: 4.0,
                shadowColor: Colors.black,
                child: Container(
                  height: 500,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Customer Details",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold)),
                              FutureBuilder(
                                future: customerDetailsController
                                    .getCustomerDetails(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text("error loading data");
                                  } else if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  var data = snapshot.data!;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DataTable(
                                        columns: [
                                          DataColumn(
                                              label: Text(
                                            'Attribute',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          )),
                                          DataColumn(
                                              label: Text(
                                            'Value',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey,
                                            ),
                                          )),
                                        ],
                                        rows: [
                                          DataRow(cells: [
                                            DataCell(Text("First Name")),
                                            DataCell(Text(
                                                data.firstName.toString())),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text("Last Name")),
                                            DataCell(
                                                Text(data.lastName.toString())),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text("Billing Address")),
                                            DataCell(Text(data.billingAddress
                                                .toString())),
                                          ]),
                                          DataRow(cells: [
                                            DataCell(Text("Phone Number")),
                                            DataCell(Text(data.phn.toString())),
                                          ]),
                                        ],
                                      ),
                                      ElevatedButton(
                                        child: Text("Update"),
                                        onPressed: () {
                                          Get.dialog(
                                            Dialog(
                                              child: Container(
                                                height: 400,
                                                width: 400,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: defaultPadding,
                                                          left: defaultPadding),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "Update Details for the Customer:"),
                                                      Obx(
                                                        () => DropdownButton(
                                                          value: editCustomerDetailsController
                                                              .selectedAttribute
                                                              .value,
                                                          items: [
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "First Name"),
                                                              value:
                                                                  'first_name',
                                                            ),
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "Last Name"),
                                                              value:
                                                                  'last_name',
                                                            ),
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "Phone Number"),
                                                              value: 'phn',
                                                            ),
                                                            DropdownMenuItem(
                                                              child: Text(
                                                                  "Billing Address"),
                                                              value:
                                                                  'billing_address',
                                                            ),
                                                          ],
                                                          onChanged: (value) {
                                                            editCustomerDetailsController
                                                                    .selectedAttribute
                                                                    .value =
                                                                value
                                                                    .toString();
                                                          },
                                                        ),
                                                      ),
                                                      getTextField(
                                                          'New Value',
                                                          'type value to be updated',
                                                          false,
                                                          editCustomerDetailsController
                                                              .tfController),
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          await editCustomerDetailsController
                                                              .editCustomer();
                                                        },
                                                        child: Text("Submit"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
