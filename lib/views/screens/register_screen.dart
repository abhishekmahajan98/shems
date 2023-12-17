import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/controllers/registration_controller.dart';
import 'package:shems/views/screens/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterationController registrationController =
        Get.put(RegisterationController());
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  height: 500,
                  width: 500,
                  child: Column(
                    children: [
                      Text("Register Screen"),
                      getTextField('Email', 'Enter email', false,
                          registrationController.emailController),
                      getTextField('Username', 'Enter username', false,
                          registrationController.usernameController),
                      getTextField('first name', 'Enter first name', false,
                          registrationController.firstNameController),
                      getTextField('last name', 'Enter last name', false,
                          registrationController.lastNameController),
                      getTextField(
                          'Billing address',
                          'Enter billing address',
                          false,
                          registrationController.billingAddressController),
                      getTextField('phone number', 'Enter phone number', false,
                          registrationController.phoneNumberController),
                      getTextField('password', 'Enter password', true,
                          registrationController.passwordController),
                      ElevatedButton(
                          onPressed: () =>
                              registrationController.registerWithEmail(),
                          child: Text("Register")),
                      ElevatedButton(
                          onPressed: () => Get.to(LoginScreen()),
                          child: Text("go to Login")),
                    ],
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

TextField getTextField(String label, String hintText, bool obscure,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
    ),
    keyboardType: TextInputType.emailAddress, // for email
    // or
    // keyboardType: TextInputType.text, // for username
    obscureText: obscure, // for login
  );
}
