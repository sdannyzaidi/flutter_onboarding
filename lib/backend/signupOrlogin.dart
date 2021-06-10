import 'package:flutter/material.dart';
import 'package:flutteronboarding/screens/login.dart';
import 'package:flutteronboarding/screens/signup.dart';

class SignUpOrLogin extends StatefulWidget {
  @override
  _SignUpOrLoginState createState() => _SignUpOrLoginState();
}

class _SignUpOrLoginState extends State<SignUpOrLogin> {
  bool signUp = false;

  void toggleViewNormal() {
    setState(() {
      signUp = !signUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ((signUp
        ? SignUp(switchScreen: toggleViewNormal)
        : Login(switchScreen1: toggleViewNormal)));
  }
}
