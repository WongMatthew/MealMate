import 'package:flutter/material.dart';

import 'package:foodhealth/home.dart';
import 'package:foodhealth/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DefaultTheme(),
      home: const Home(),
    );
  }
}