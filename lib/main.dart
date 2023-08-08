import 'package:flutter/material.dart';

import 'Screen/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Ride App',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: WelcomeScreen(),
    );
  }
}