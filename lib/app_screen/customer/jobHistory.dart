

import 'package:flutter/material.dart';

class JobHistory extends StatefulWidget {
  final String userId;
  JobHistory({Key key, this.userId}) : super(key: key);

  @override
  _JobHistoryState createState() => _JobHistoryState(userId);
}

class _JobHistoryState extends State<JobHistory> {
 String userid;
  _JobHistoryState(String userId){
       userid=userId;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Job History'),),
    );
  }
}