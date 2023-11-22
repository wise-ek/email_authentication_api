import 'package:flutter/material.dart';
import 'package:learn/screens/signupScreen.dart';

import 'loginScreen.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key,});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
    );
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Hai,  Welcome",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
