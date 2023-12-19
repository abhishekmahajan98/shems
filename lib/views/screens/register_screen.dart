import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/constants/size_constants.dart';
import 'package:shems/controllers/registration_controller.dart';
import 'package:shems/views/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterationController registrationController =
        Get.put(RegisterationController());
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Card(
                    child: Container(
                      height: 800,
                      width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          children: [
                            Text(
                              'Registration Screen',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            getTextField('Email', 'Enter email', false,
                                registrationController.emailController),
                            getTextField('Username', 'Enter username', false,
                                registrationController.usernameController),
                            getTextField(
                                'first name',
                                'Enter first name',
                                false,
                                registrationController.firstNameController),
                            getTextField('last name', 'Enter last name', false,
                                registrationController.lastNameController),
                            getTextField(
                                'Billing address',
                                'Enter billing address',
                                false,
                                registrationController
                                    .billingAddressController),
                            getTextField(
                                'phone number',
                                'Enter phone number',
                                false,
                                registrationController.phoneNumberController),
                            getTextField('password', 'Enter password', true,
                                registrationController.passwordController),
                            Padding(
                              padding: const EdgeInsets.all(defaultPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () => registrationController
                                          .registerWithEmail(),
                                      child: Text("Register")),
                                  ElevatedButton(
                                      onPressed: () => Get.to(LoginScreen()),
                                      child: Text("go to Login")),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
