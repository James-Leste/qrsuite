import 'package:flutter/material.dart';
import 'package:flutter_test_project/pages/login_page.dart';
import 'package:flutter_test_project/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  LoginOrRegisterPage({super.key});
  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool interfaceSwitch = false;

  void changeInterface() {
    setState(() {
      interfaceSwitch = !interfaceSwitch;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (interfaceSwitch) {
      return LoginPage(interfaceSwitch: changeInterface);
    } else {
      return RegisterPage(interfaceSwitch: changeInterface);
    }
  }
}
