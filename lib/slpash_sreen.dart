import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loginuicolors/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Display the SplashScreen as the home screen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen (e.g., 3 seconds)
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => MyLogin()), // Navigate to the main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/wxf.png"), fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20.0),
            CircularProgressIndicator(), // Add a loading indicator
          ],
        ),
      ),
    );
  }
}
