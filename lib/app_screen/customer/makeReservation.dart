


import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
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
      String jobtype;
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
                            selectday=DateFormat('EEE MMM  d '  'yyyy  ').format(_selectday);
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
           
          appBar: AppBar(title:Text(" MAKE  RESERVATION ")),
          body: Padding(
               padding: EdgeInsets.all(30),
                      child: Container(
               
              child:ListView(
                children: <Widget>[
                  Form(

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
                           Text("Problem brief",style: TextStyle(fontSize:20.0,color:Colors.grey),),
                            SizedBox(height:10),
                         TextFormField(
                           controller: problem,
                           validator: (value){
                              if(value.isEmpty ||value.trim()==""){
                                   return  "";
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

                  RaisedButton(onPressed: (){},color:Colors.blue,child: Text("Request",style: TextStyle(color:Colors.white),), shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.blueAccent)
                       ),),
                       SizedBox(width:40),
                  RaisedButton(onPressed: (){},color:Colors.pink,child: Text("Cancel", style: TextStyle(color:Colors.white),),
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
}