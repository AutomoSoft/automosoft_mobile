import 'package:automosoft_mobile/app_auth/loginPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primaryColorDark:  Color.fromRGBO(194, 132, 0, 0.9),
        primarySwatch: Colors.amber
      ),
      home: LoginPage()
    );
  }
}

