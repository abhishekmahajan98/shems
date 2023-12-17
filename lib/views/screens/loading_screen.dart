import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shems/model/user.dart';
import 'package:shems/views/screens/login_screen.dart';
import 'package:shems/views/screens/main_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;
  final User user = Get.put(User());

  @override
  void initState() {
    super.initState();
    // Call the function to check if the user is logged in
    checkIfLoggedIn().then((isLoggedIn) {
      // Update the state to stop loading
      setState(() {
        isLoading = false;
      });

      // Navigate to the appropriate screen based on whether the user is logged in
      if (isLoggedIn) {
        // User is logged in, navigate to the home screen
        Get.off(MainScreen());
      } else {
        // User is not logged in, navigate to the login screen
        Get.off(LoginScreen());
      }
    });
  }

  Future<bool> checkIfLoggedIn() async {
    // Implement your logic to check if the user is logged in
    // You may perform an API request or check a local token, etc.
    // Return true if logged in, false otherwise
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Use the getString method to retrieve the value associated with the key
    String? value = await prefs.getString('c_id');
    await Future.delayed(
        Duration(seconds: 1)); // Simulating a delay, replace with actual logic
    if (value != null) {
      user.updatecid(value);
      return true;
    }
    return false; // Replace with your authentication logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Screen'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Text('Loading complete. Redirecting...'),
      ),
    );
  }
}
