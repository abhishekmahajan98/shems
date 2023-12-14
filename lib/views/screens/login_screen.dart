import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shems/controllers/login_controller.dart';
import 'package:shems/views/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());

    var isLoggedIn = false.obs;

    return Scaffold(
      backgroundColor: Color(0xff154C79),
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: const Text('SSMS Main Login Page'),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 80),
                child: Obx(
                  () => isLoggedIn.isFalse
                      ? Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Container(
                                height: 200,
                                width: 180,
                                color: Colors.white10,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 60),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Username",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        width: 200,
                                        child: TextField(
                                          controller:
                                              loginController.emailController,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              hintText: "johndoe"),
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Password",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white70),
                                    ),
                                    const SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        width: 200,
                                        child: TextField(
                                          controller: loginController
                                              .passwordController,
                                          obscureText: true,
                                          style: const TextStyle(fontSize: 20),
                                          decoration: const InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              hintText: "*********"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextButton(
                              onPressed: () => loginController.loginWithEmail(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.green,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(const RegisterScreen());
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Container(
                                height: 200,
                                width: 180,
                                color: Colors.white10,
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 60),
                                child: Column(
                                  children: [
                                    Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        width: 200,
                                        child: TextField(
                                          style: TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              hintText: "John Doe"),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        width: 200,
                                        child: TextField(
                                          style: TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              hintText: "johndoe"),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white70),
                                    ),
                                    SizedBox(width: 30),
                                    Expanded(
                                      child: SizedBox(
                                        height: 20,
                                        width: 200,
                                        child: TextField(
                                          obscureText: true,
                                          style: TextStyle(fontSize: 20),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              hintText: "*********"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextButton(
                              onPressed: () {},
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.green,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: const Text(
                                  "Register",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                isLoggedIn = false.obs;
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
