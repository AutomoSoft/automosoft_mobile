

import 'package:flutter/material.dart';

class MyServices extends StatefulWidget {
  final String userId;
  MyServices({Key key, this.userId}) : super(key: key);

  @override
  _MyServicesState createState() => _MyServicesState(userId);
}

class _MyServicesState extends State<MyServices> {

  String userid;
  _MyServicesState(String userId){
    userid=userId;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Services'),),
    );
  }
}