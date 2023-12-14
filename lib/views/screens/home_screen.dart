import 'package:flutter/material.dart';
import 'package:shems/views/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const LoginScreen();
  }
}

// Obx(() => globalController.checkLoading().isTrue
//             ? const Center(child: CircularProgressIndicator())
//             : HeaderWidget()))
