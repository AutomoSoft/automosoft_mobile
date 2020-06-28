
import 'package:flutter/material.dart';

class CustomerHome extends StatefulWidget {
  String userName;
  CustomerHome({Key key,this.userName}) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState(userName);
}

class _CustomerHomeState extends State<CustomerHome> {
  String username;
  _CustomerHomeState(String userName){
    username=userName;

  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
       child:Text(username),
    );
  }
}