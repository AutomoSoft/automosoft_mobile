import 'dart:convert';

List<Vehicle> vehiFromJson(String str)=>List<Vehicle>.from(json.decode(str).map((x)=>Vehicle.fromJson(x)));
String vehiToJson(List<Vehicle> data)=>json.encode(List<dynamic>.from(data.map((x)=>x.toJson())));


class Vehicle{
  String vehicleRegNo;
  String chasis;
  String engineNo;
  bool checked;

    Vehicle({this.vehicleRegNo,this.chasis, this.engineNo,this.checked});
     factory Vehicle.fromJson(Map<String,dynamic> json)=>

      Vehicle(
          vehicleRegNo: json['vehicleRegNo'],
          chasis: json['chasis'],
          engineNo: json['EngineNo'],
          checked: false,
      );
      Map<String, dynamic> toJson()=>{
        "vehicleRegNo":vehicleRegNo,
        "chasis":chasis,
        "engineNo":engineNo,
        "checked":checked,

      };
}