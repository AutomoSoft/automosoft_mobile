

import 'package:automosoft_mobile/app_screen/customer/listtile.dart';
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
      body: Container(
        padding: EdgeInsets.all(20),
        child:ListView(
            children: <Widget>[
              Card(
                shadowColor: Colors.amber,
                elevation: 10.0,
                child: ListTile(
              
                 title:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                   children:<Widget>[
                     ListTileCard(type:"JOB NUMBER",value:"JOB002",),
                       ListTileCard(type:"JOB TYPE",value:"FULL SERVICE",),
                     ListTileCard(type:"VEHICLE",value:"DDD-9898",),

                   ],
                 ),
                subtitle: Column(
                  children: <Widget>[
                    RaisedButton(
                      splashColor: Colors.green,
                      shape: 
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:BorderSide(color:Colors.blue)
                        ),
                    
                      elevation: 10.0,
                      onPressed: (){print(userid);}, 
                      child:Text("View",style:TextStyle(color:Colors.white)),
                      color:Colors.blue
                      ),
                  ],
                ),
              )
              ),
             
            ],
        ),
      ),
    );
  }
}