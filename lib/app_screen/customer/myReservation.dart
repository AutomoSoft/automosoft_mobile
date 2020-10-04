

import 'dart:convert';

import 'package:automosoft_mobile/constant.dart';
import 'package:automosoft_mobile/models/myReservation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class MyReservation extends StatefulWidget {
  final String userId;
  
  MyReservation({Key key, this.userId}) : super(key: key);

  @override
  _MyReservationState createState() => _MyReservationState(userId);
}

class _MyReservationState extends State<MyReservation> {
  String userid;
 
 List<MyReservations> myReservationModel=[];
   String jobtype;
  var jobType=["Paint Job","Accident Repair","Vehicle Valuation","Full Service","Other"];
  _MyReservationState(String userId){
       userid=userId;
  }
  Future<List<MyReservations>> myResrvation({value="all"}) async{
    print(value);
     var reservationModels=List<MyReservations>();
     

    await http.get('http://${Ip.ip}:3000/reservations/getReservations/$value')
    .then((res) {
       reservationModels.clear();
      var data=json.decode(res.body);
     var myServisers=data['data'];
      print(myServisers);
     for(var i in myServisers){

       reservationModels.add(MyReservations.fromJson(i));
     }


    }).catchError((onError){
      print(onError);
    });
    return reservationModels;
  }
   @override
  void initState() { 
    super.initState();
    print("ffff");
       myReservationModel.clear();
     myResrvation().then((value){
        setState(() {
          myReservationModel.addAll(value);
        });
     }
      
     );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Reservations'),),

      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
           children:<Widget>[
             Text("Select Job Type"),
            DropdownButton<String>(
                             elevation: 20,
                              isExpanded: true, 
                              items:jobType.map((item){
                                 return DropdownMenuItem<String>(
                                    child:Text(item),
                                    value:item,
                                 );
                              }).toList(),
                               onChanged:(String newValue){
                                  setState(() {
                                      this.jobtype=newValue;
                                      myResrvation(value:newValue);
                                  });
                               },
                               value:jobtype,
                               ),
                               Expanded(
                                 child:Padding(
                                   padding: const EdgeInsets.only(top:20.0),
                                   child: ListView(
                                     children:<Widget>[
                                         SingleChildScrollView(
                                           scrollDirection: Axis.horizontal,
                                                                           child: DataTable(
                                             columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'JOB TYPE',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
       
        
        DataColumn(
          label: Text(
            'REQUESTED DATE',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
        DataColumn(
          label: Text(
            'REQUESTED TIME',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
        DataColumn(
          label: Text(
            'PROBLEM DESCRIPTION',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
         DataColumn(
          label: Text(
            'ACCEPTED ON',
            style:TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
      ],
     
    
      rows:myReservationModel.map((e) => 
         DataRow(
         
           cells: [
             DataCell(
                 
                 Text(e.jobtype==null?"":e.jobtype)
             ),
               DataCell(
                 Text(e.reqDate==null?"":e.reqDate)
             ),
               DataCell(
                 Text(e.reqTime==null?"":e.reqTime)
             ),
               DataCell(
                 Text(e.prob==null?"":e.prob)
             ),
               DataCell(
                 Text(e.accptedOn==null?"":e.accptedOn)
             ),
           ]
           )
      ).toList()
      
                                          
                                              ),
                                         )
                                     ]
                                   ),
                                 )
                                 )
                              
           ],
        ),
      )
    );
  }
}