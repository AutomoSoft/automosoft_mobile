import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


 
 List<EventDate> techFromJson(String str)=>List<EventDate>.from(json.decode(str).map((x)=>EventDate.fromJson(x)));
 dynamic tecToJson(List<EventDate> data)=>json.encode(List<dynamic>.from(data.map((x)=>x.toJson())));




 class EventDate{
  String date;
   String time;
    EventDate({this.date,this.time});



     factory EventDate.fromJson(Map<String,dynamic> json)=>

     
 
    EventDate(
      date:json['daterequested'],
      time:json['time'],
     );

     Map<String, dynamic> toJson()=>{
      'date':date,
      'time':time,
  };

 }


