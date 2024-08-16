import 'package:flutter/material.dart';
import 'package:transcribe/authetications/login.dart';
import 'package:transcribe/authetications/signup.dart';

class Togglepage extends StatefulWidget {
  const Togglepage({super.key});

  @override
  State<Togglepage> createState() => _TogglepageState();
}

class _TogglepageState extends State<Togglepage> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(showRegister: toggleView);
    } else {
      return Signup(showLogin: toggleView);
    }
  }
}
