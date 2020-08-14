


import 'dart:convert';

import 'package:automosoft_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart'as http;
class MakeReservation extends StatefulWidget {
  final String userId;
  MakeReservation({Key key, this.userId}) : super(key: key);

  @override
  _MakeReservationState createState() => _MakeReservationState(userId);
}

class _MakeReservationState extends State<MakeReservation> {
    final _formKey=GlobalKey<FormState>();
      DateTime  _selectday;
      String  selectday;
      String jobtype="Other";
      TimeOfDay _selectTime;
       TextEditingController problem;
       String userid;
       _MakeReservationState(String userId){
         userid=userId;
       }
       var jobType=["Paint Job","Accident Repair","Vehicle Valuation","Full Service","Other"];
  @override
  void initState() {
     _selectday=DateTime.now();
     _selectTime=TimeOfDay.now();
     problem=TextEditingController();
    super.initState();
  }
      datePicker()async{
        DateTime newDateTime = await showRoundedDatePicker(
                    context: context,
                   
                    initialDate: _selectday,
                     firstDate: DateTime(DateTime.now().year),
                     lastDate: DateTime(DateTime.now().year + 1),
                 theme: ThemeData.dark()
                        );
                        if(newDateTime!=null){
                          setState(() {
                            _selectday=newDateTime;
                            selectday=DateFormat('EEE MMM d '  'yyyy').format(_selectday);
                          });
                        }
     }
     timePicker() async{
       TimeOfDay newDateTime= await showRoundedTimePicker(
         context: context,
          initialTime:TimeOfDay.now());
          if(newDateTime!=null){
                          setState(() {
                            _selectTime=newDateTime;
                           
                          });
                        }
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           
          appBar: AppBar(title:Text(" MAKE  RESERVATION "),
             
          ),
          body: Padding(
               padding: EdgeInsets.all(30),
                      child: Container(
               
              child:ListView(
                children: <Widget>[
                  Form(
                     key: _formKey,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:<Widget>[
                      
                         Container(
                           margin: EdgeInsets.all(0),
                           height: 300.0,
                            decoration: BoxDecoration(
           image: DecorationImage(
             alignment: Alignment.topLeft,
              fit:BoxFit.cover,
             image:AssetImage('assets/images/logo.png') 
             ),
        ),
                         ),
                         
                          SizedBox(height:10),
                        Text("Choose a Date",style: TextStyle(fontSize:20.0,color:Colors.grey),),
                        SizedBox(height:10),
                          ListTile(
                             leading: Icon(Icons.calendar_today),
                             title:Text("Date : ${_selectday.day.toString()}/${_selectday.month.toString()}/${_selectday.year.toString()}"),
                             onTap:()=>datePicker(),
                          ) ,
                          SizedBox(height:30),
                            Text("Choose a Time",style: TextStyle(fontSize:20.0,color:Colors.grey),),
                             SizedBox(height:10),
                          ListTile(
                            
                            leading:Icon(Icons.access_time),
                            title:Text(_selectTime.format(context)),
                            onTap: ()=>timePicker(),
                          ),  
                          SizedBox(height:30),
                           Text("Job Type",style: TextStyle(fontSize:20.0,color:Colors.grey),),
                            SizedBox(height:10),
                          DropdownButton<String>(
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
                                });
                             },
                             value:jobtype,
                             ),
                        

                           SizedBox(height:30),
                           Text("Problem in brief",style: TextStyle(fontSize:20.0,color:Colors.grey),),
                            SizedBox(height:10),
                         TextFormField(
                           controller: problem,
                           validator: (value){
                              if(value.isEmpty ||value.trim()==""){
                                   return  "Problem in brief";
                                 }
                           },
                            minLines: 10,
                           maxLines: 15,
                           decoration: InputDecoration(
                             filled: true,
                             labelText: "Problem in brief",
                              border:OutlineInputBorder(
                                borderRadius:BorderRadius.circular(15.0),
                                borderSide: new BorderSide(), 
                                ),
                           ),
                         ),
                          SizedBox(height:20),
                         Row(
                 mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  RaisedButton(onPressed: (){
                      requestConfirem();
                  },color:Colors.blue,child: Text("Request",style: TextStyle(color:Colors.white),), shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blueAccent)
                       ),),
                       SizedBox(width:40),
                  RaisedButton(onPressed: (){
                    requestCancel();
                  },color:Colors.pink,child: Text("Cancel", style: TextStyle(color:Colors.white),),
                     shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(18.0),
                     side: BorderSide(color: Colors.pinkAccent)
                      ),),
                ],),
                 SizedBox(height:40),
                      ],
                    )
                    ),
                ],
              ),
            ),
          ),
    );
  }
    requestCancel(){
        jobtype='Other';
       _selectday=DateTime.now();
       _selectTime=TimeOfDay.now();
       problem.text='';
      
       
    }
   Future<void> requestConfirem() async{

   if(_formKey.currentState.validate()){
      return showDialog<void>(
       context:context,
       barrierDismissible: false,
       builder: (BuildContext context){
         return AlertDialog(
           title: Text("Are you sure want to Add ?"),
           content: SingleChildScrollView(
            //  child:ListBody(
            //    children:<Widget>[
            //      Text("demo"),
            //      Text("would you like to approve"),
            //    ],
            //  ) ,
             ),
             actions: <Widget>[
               FlatButton(
                 color:Colors.green,
                 onPressed:(){
                    submitReservation();
                     Navigator.of(context).pop();
                     
                    
                 }, child:Text("Yes"),),
                 FlatButton(
                   color:Colors.pink,
                   onPressed: (){
                   requestCancel();
                   Navigator.of(context).pop();
                 }, child:Text('No'))
             ],
         );
       }
       
       
       );
 
   }
     
 

       }
        Future<void>submitReservation() async{

          Map<String,dynamic>data={
             'usertype':'Customer',
             'custID':userid,
             'dateposted':DateFormat('EEE MMM d '  'yyyy ''hh:mm:ss').format(DateTime.now()).toString(),
             'daterequested':selectday.toString(),
             'repairtype':jobtype,
              'time':_selectTime.format(context).toString(),
              'problembrief':problem.text,
              'status':'pending'
          };
          print(userid);
          print(DateFormat('EEE MMM d '  'yyyy ''hh:mm:ss').format(DateTime.now()).toString());
          print(selectday.toString());
          print(jobtype);
          print(_selectTime.format(context).toString());
          print(problem.text);
          print(data);
   await http.post("http://${Ip.ip}:3000/reservations/makeReservation",body:data)
   .then((value){
         var data=json.decode(value.body);

        //  final snackBar=SnackBar(
        //    content:SizedBox(
        //       height: 50,
        //      child:data['state']?Text("${data["msg"]}",style:TextStyle(fontSize:20),)
        //      :Text("${data["msg"]}\n check Job No ",style:TextStyle(fontSize:20,color:Colors.red),),
        //    ) ,
        //     action: SnackBarAction(
        //        textColor:data['state']?Colors.amber:Colors.red,
        //      label: 'ok',
        //    onPressed: () {},
        //     ),
        //    );
        //     Scaffold.of(context).showSnackBar(snackBar);
             
   }
   
   )
   .catchError((onError){

   });
  
        }
}