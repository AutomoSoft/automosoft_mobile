
import 'dart:convert';

import 'package:automosoft_mobile/models/items.dart';


List<Services>modelServiceFromJson(String str)=>
List<Services>.from(json.decode(str).map((x)=>Services.fromJson(x)));

String modelServicesToJson(List<Services>data)=>
json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Services{
  String jobNo;
  String jobType;
  String custId;
 Vehicles vehicle;
  String  problem;
  String  foremanOb;
  String estCharge;
  Tech techs;
  String subTotal;
  String tax;
  String grandTotal;
  String amountPaid;
  String balance;
  String lastPaidOn;
  String jobStatus;

  Services({
    this.jobNo,
    this.jobType,
    this.vehicle,
    this.problem,
    this.foremanOb,
    this.estCharge,
    this.techs,
    this.subTotal,
    this.tax,
    this.grandTotal,
    this.amountPaid,
    this.balance,
    this.jobStatus,
    this.lastPaidOn,
    this.custId,
  });
  factory Services.fromJson(Map<String,dynamic> json){
   
    return
    Services(
    jobNo: json['jobNo'],
    jobType: json['jobType'],
    jobStatus: json['jobStatus'],
    custId:json['custId'],
    problem: json['probCus'],
    foremanOb: json['foremanObv'],
    estCharge: json['estCharge'].toString(),
    subTotal: json['subTotal'].toString(),
    tax:json['tax'].toString(),
    grandTotal: json['grandTotal'].toString(),
    amountPaid: json['amountPaid'].toString(),
    lastPaidOn: json['lastpaymentdate'].toString(),
    balance: json['balance'].toString(),
 vehicle: Vehicles.fromJson(jsonDecode(json['vehicle'])),



 
  );
  }
  Map<String,dynamic> toJson()=>{
    'jobNo':jobNo,
    'jobType':jobType,
    'vehicle':vehicle.toJson(),
    'problem':problem,
    'foremanOb':foremanOb,
    'estCharge':estCharge,
    'techs':techs.toJson(),
    'subTotal':subTotal,
    'tax':tax,
    'grandTotal':grandTotal,
    'amountPaid':amountPaid,
    'balance':balance,
    'jobStatus':jobStatus,
    'lastPaidOn':lastPaidOn,
    'custId':custId,
  };

}


class Vehicles{
  String  vehicleRegNo,chasis,engineNo;

  Vehicles({
    this.vehicleRegNo,
    this.chasis,
    this.engineNo,
  });
  factory Vehicles.fromJson(Map<String,dynamic> json)=>Vehicles(
    vehicleRegNo:json['vehicleRegNo'],
    chasis:json['chasis'],
    engineNo:json['EngineNo'],
  );
  Map<String,dynamic> toJson()=>{
     'vehicleRegNo':vehicleRegNo,
     'chasis':chasis,
     'engineNo':engineNo,
  };
}

class Tech{
  String techId;
  String addedDate;
  Tech(
    {
      this.techId,
      this.addedDate,
    }
  );
  factory Tech.fromJson(List<dynamic> json)=>Tech(
    techId: json[0],
    addedDate: json[1],
  );
  Map<String,dynamic> toJson()=>{
    'techId':techId,
     'addedDate':addedDate,
  };
}

// class ItemList{
//   final List<Item> items;
 
//   ItemList({
//     this.items
//   });
//   factory ItemList.fromJosn(List<dynamic> parsedJson){
//     List<Item>items=List<Item>();
//     items=parsedJson.map((i)=>Item.fromJson(i)).toList();
//     return ItemList(items: items);
//   }
// }