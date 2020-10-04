

import 'dart:convert';

List<MyReservations>modelServiceFromJson(String str)=>
  List<MyReservations>.from(json.decode(str).map((x)=>MyReservations.fromJson(x)));

String modelServicesToJson(List<MyReservations>data)=>
json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyReservations{
  
  String jobtype;
  String reqDate;
  String  reqTime;
  String  prob;
  String accptedOn;

   MyReservations({
   this.jobtype,
   this.reqDate,
   this.reqTime,
   this.prob,
   this.accptedOn
   });

   factory MyReservations.fromJson(Map<String,dynamic> json){

     return
     MyReservations(
       jobtype: json['repairtype'],
       reqDate: json['daterequested'],
       reqTime: json['time'],
       prob: json['problembrief'],
       accptedOn: json['status']

     );
   }
   Map<String ,dynamic> toJson()=>{
     
     "jobType":jobtype,
     "reqDate":reqDate,
     "reqTime":reqTime,
     "prob":prob,
     "acceptedOn":accptedOn
   };

}