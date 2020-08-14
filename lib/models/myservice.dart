
import 'dart:convert';


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
  Item items;
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
    this.items,
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
  factory Services.fromJson(Map<String,dynamic> json)=>Services(
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
   //techs: Tech.fromJson(json['technicians']),
  // items: Item.fromJson(json['itemsUsed']),

 
  );
  Map<String,dynamic> toJson()=>{
    'jobNo':jobNo,
    'jobType':jobType,
    'vehicle':vehicle.toJson(),
    'problem':problem,
    'foremanOb':foremanOb,
    'estCharge':estCharge,
    'items':items.toJson(),
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
  factory Tech.fromJson(Map<String,dynamic> json)=>Tech(
    techId: json[0],
    addedDate: json[1],
  );
  Map<String,dynamic> toJson()=>{
    'techId':techId,
     'addedDate':addedDate,
  };
}
class Item{
  String itemId;
  String itemName;
  String itemType;
  String qut;
  String unitPrice;
  String charge;
  Item({
    this.itemId,
    this.itemName,
    this.itemType,
    this.qut,
    this.unitPrice,
    this.charge,
  });

  factory Item.fromJson(Map<List<String>,dynamic> json)=>Item(
    itemId:json['itemId'],
    itemName: json['itemname'],
    itemType: json['itemtype'],
    unitPrice: json['unitprice'],
    qut:json['qty'],
    charge: json['charge'],
  );

  Map<String,dynamic> toJson()=>{
    'itemId':itemId,
    'itemName':itemName,
    'itemType':itemType,
    'unitPrice':unitPrice,
     'qut':qut,
     'charge':charge,
  };
}