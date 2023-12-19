import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shems/controllers/login_controller.dart';
import 'package:shems/views/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
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
                      Text("Login Screen"),
                      getTextField('Email', 'Enter email', false,
                          loginController.emailController),
                      getTextField('password', 'Enter password', true,
                          loginController.passwordController),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () => loginController.loginWithEmail(),
                          child: Text("Login")),
                      ElevatedButton(
                          onPressed: () => Get.to(RegisterScreen()),
                          child: Text("Register")),
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
    TextEditingController controller,
    {bool isNumeric = false}) {
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
    inputFormatters: isNumeric
        ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
        : null,
  );
}
