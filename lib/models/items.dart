
import 'dart:convert';

List<Item>modelServiceFromJson(String str)=>
List<Item>.from(json.decode(str).map((x)=>Item.fromJson(x)));

String modelServicesToJson(List<Item>data)=>
json.encode(List<dynamic>.from(data.map((x) => x.toJson())));




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

  factory Item.fromJson(Map<String,dynamic> json){
    //print(json);
    return
    Item(
    itemId:json['itemId'],
    itemName: json['itemname'],
    itemType: json['itemtype'],
    unitPrice: json['unitprice'],
    qut:json['qty'],
    charge: json['charge'].toString(),
  );
  }
  Map<String,dynamic> toJson()=>{
    'itemId':itemId,
    'itemName':itemName,
    'itemType':itemType,
    'unitPrice':unitPrice,
     'qut':qut,
     'charge':charge,
  };
}