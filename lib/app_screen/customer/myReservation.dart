

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
  bool _notloading=true;
 List<MyReservations> myReservationModel=[];
   String jobtype;
  var jobType=["Paint Job","Accident Repair","Vehicle Valuation","Full Service","Other","All"];
  _MyReservationState(String userId){
       userid=userId;
  }
  Future<List<MyReservations>> myResrvation({value="all"}) async{
    print(value);
        var reservationModels=List<MyReservations>();
      if(value=="All"){
              await http.get('http://${Ip.ip}:3000/reservations/getReservations/all')
    .then((res) {
       myReservationModel.clear();
      var data=json.decode(res.body);
     var myServisers=data['data'];
     setState(() {
         _notloading=false;
       });
   
     for(var i in myServisers){

      myReservationModel.add(MyReservations.fromJson(i));
     }


    }).catchError((onError){
      print(onError);
    });
    return myReservationModel;
   
      }
 
     else if(value!='all'){
         
          await http.get('http://${Ip.ip}:3000/reservations/getReservations/$value')
    .then((res) {
       myReservationModel.clear();
      var data=json.decode(res.body);
     var myServisers=data['data'];
     setState(() {
         _notloading=false;
       });
   
     for(var i in myServisers){

      myReservationModel.add(MyReservations.fromJson(i));
     }


    }).catchError((onError){
      print(onError);
    });
    return myReservationModel;
   
     }
   
     else{

    await http.get('http://${Ip.ip}:3000/reservations/getReservations/$value')
    .then((res) {
       reservationModels.clear();
      var data=json.decode(res.body);
     var myServisers=data['data'];
       setState(() {
         _notloading=false;
       });
   
     for(var i in myServisers){

       reservationModels.add(MyReservations.fromJson(i));
     }


    }).catchError((onError){
      print(onError);
    });
    return reservationModels;
     }
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

      body:_notloading ? Center(
        child: CircularProgressIndicator(
                              value: null,
                              strokeWidth: 5.0,
                            ),
      )
      :
      
      
      
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
           children:<Widget>[
             Text("Select Job Type",style:TextStyle(fontSize:20,color:Color.fromRGBO(4, 45, 51, 1))),
            Container(
              color:Colors.grey[200],
              child: DropdownButton<String>(
                               elevation: 20,
                                isExpanded: true, 
                                dropdownColor: Colors.grey[200],
                                hint: Text("Select Job Type"),
                                items:jobType.map((item){
                                   return DropdownMenuItem<String>(
                                      child:Text(item),
                                      value:item,
                                   );
                                }).toList(),
                                 onChanged:(String newValue){
                                    setState(() {
                                        this.jobtype=newValue;
                                        setState(() {
                                          _notloading=true;
                                        });
                                        myResrvation(value:newValue);
                                    });
                                 },
                                 value:jobtype,
                                 ),
            ),
                               Expanded(
                                 child:Padding(
                                   padding: const EdgeInsets.only(top:20.0),
                                   child: ListView(
                                     children:<Widget>[
                                         SingleChildScrollView(
                                           scrollDirection: Axis.horizontal,
                                                                           child: Container(
                                                                                color:Colors.grey[200],
                                                                             child: DataTable(
                                             columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'JOB TYPE',
            style: TextStyle(fontStyle: FontStyle.italic,color:Color.fromRGBO(18, 144, 163, 1),fontSize:18),
          ),
        ),
       
        
        DataColumn(
          label: Text(
            'REQUESTED DATE',
            style: TextStyle(fontStyle: FontStyle.italic,color:Color.fromRGBO(18, 144, 163, 1),fontSize:18),
          ),
        ),
        DataColumn(
          label: Text(
            'REQUESTED TIME',
            style: TextStyle(fontStyle: FontStyle.italic,color:Color.fromRGBO(18, 144, 163, 1),fontSize:18),
          ),
        ),
        DataColumn(
          label: Text(
            'PROBLEM DESCRIPTION',
            style: TextStyle(fontStyle: FontStyle.italic,color:Color.fromRGBO(18, 144, 163, 1),fontSize:18),
          ),
        ),
         DataColumn(
          label: Text(
            'ACCEPTED ON',
            style:TextStyle(fontStyle: FontStyle.italic,color:Color.fromRGBO(18, 144, 163, 1),fontSize:18),
          ),
        ),
      ],
      
    
      rows:myReservationModel.map((e) => 
         DataRow(
         
           cells: [
             DataCell(
                 
                 Text(e.jobtype==null?"":e.jobtype, style: TextStyle(color:Color.fromRGBO(11, 24, 74, 1),fontSize:17),)
             ),
               DataCell(
                 Text(e.reqDate==null?"":e.reqDate, style: TextStyle(color:Color.fromRGBO(11, 24, 74, 1),fontSize:15))
             ),
               DataCell(
                 Text(e.reqTime==null?"":e.reqTime, style: TextStyle(color:Color.fromRGBO(11, 24, 74, 1),fontSize:15))
             ),
               DataCell(
                 Text(e.prob==null?"":e.prob, style: TextStyle(color:Color.fromRGBO(11, 24, 74, 1),fontSize:17))
             ),
               DataCell(
                 Text(e.accptedOn==null?"":e.accptedOn, style: TextStyle(color:Color.fromRGBO(11, 24, 74, 1),fontSize:17))
             ),
           ]
           )
      ).toList()
      
                                          
                                              ),
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