import 'dart:convert';
 
 List<Technician> techFromJson(String str)=>List<Technician>.from(json.decode(str).map((x)=>Technician.fromJson(x)));
 String tecToJson(List<Technician> data)=>json.encode(List<dynamic>.from(data.map((x)=>x.toJson())));

class Technician{
  String userid;
  int cap;
  int curr;
  bool checked;
  Technician({this.userid, this.cap, this.curr, this. checked});
  
  // ignore: missing_return
  factory Technician.fromJson(Map<String,dynamic> json)=>
   
    
    Technician(
    
    userid: json['userid'],
    cap:json['capacity'] ,
    curr:json['currentjobCap']  ,
    checked:false,
  );
  
  Map<String, dynamic> toJson()=>{
   "userid":userid,
   "cap":cap,
   "curr":curr,
   'checked':checked,
  };


}