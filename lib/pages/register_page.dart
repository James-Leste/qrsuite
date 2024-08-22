import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/components/my_button.dart';

import 'package:flutter_test_project/components/my_inputField.dart';
import 'package:flutter_test_project/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function interfaceSwitch;
  RegisterPage({super.key, required this.interfaceSwitch});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void printMessage() {
    print("other");
  }

  void signUp(context) async {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        });

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        failedMessage("Password is not consistent");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      failedMessage(e.code);
    }
  }

  void failedMessage(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Icon(Icons.error),
          content: Text(message),
          insetAnimationDuration: const Duration(seconds: 1),
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: Colors.grey[300],
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  children: [
                    Icon(
                      Icons.app_registration,
                      size: 100,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      "Get a new account",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyInputField(
                      controller: emailController,
                      hintText: "Username",
                      obscureText: false,
                    ),
                    const SizedBox(height: 15),
                    MyInputField(
                      controller: passwordController,
                      hintText: "Password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 15),
                    MyInputField(
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        obscureText: true),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () => signUp(context),
                      buttonLabel: 'Sign Up',
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                                thickness: 0.3, color: Colors.grey[400])),
                        Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        Expanded(
                            child: Divider(
                                thickness: 0.3, color: Colors.grey[400]))
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: 'lib/images/google.png',
                          onTap: printMessage,
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SquareTile(
                          imagePath: 'lib/images/apple-logo.png',
                          onTap: printMessage,
                        )
                      ],
                    ),
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            widget.interfaceSwitch();
                          },
                          child: Text('Login Now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
