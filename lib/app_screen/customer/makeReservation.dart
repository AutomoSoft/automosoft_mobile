


import 'package:flutter/material.dart';

class MakeReservation extends StatefulWidget {
  MakeReservation({Key key}) : super(key: key);

  @override
  _MakeReservationState createState() => _MakeReservationState();
}

class _MakeReservationState extends State<MakeReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           
          appBar: AppBar(title:Text("Make Resrvation")),
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
                        Text("Choose a Date"),
                        SizedBox(height:10),
                          ListTile(
                             leading: Icon(Icons.calendar_today),
                             title:Text("date"),
                             onTap: (){},
                          ) ,
                          SizedBox(height:30),
                            Text("Choose a Time"),
                             SizedBox(height:10),
                          ListTile(
                            
                            leading:Icon(Icons.access_time),
                            title:Text("Time"),
                            onTap: (){},
                          ),  
                          SizedBox(height:30),
                           Text("Job Type"),
                            SizedBox(height:10),
                          DropdownButton(isExpanded: true, items: null, onChanged: null),
                        

                           SizedBox(height:30),
                           Text("Problem brief"),
                            SizedBox(height:10),
                         TextFormField(
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