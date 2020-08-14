

import 'dart:convert';

import 'package:automosoft_mobile/app_screen/customer/listtile.dart';
import 'package:automosoft_mobile/constant.dart';
import 'package:automosoft_mobile/models/items.dart';
import 'package:automosoft_mobile/models/myservice.dart';
import 'package:automosoft_mobile/models/vehicaleDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:http/http.dart'as http;
class MyServices extends StatefulWidget {
  final String userId;
  
  MyServices({Key key, this.userId}) : super(key: key);

  @override
  _MyServicesState createState() => _MyServicesState(userId);
}

class _MyServicesState extends State<MyServices> {

  bool _notloading=true;
   List<Services>serviceModel=[];
   List<Item>itemsModel=[];
   List<Vehicle>vehicleModel=[];
  Future<List<Services>> myServices() async{
    var serviceModels=List<Services>();
    await http.get('http://${Ip.ip}:3000/jobs/viewServices/$userid')
    .then((res){
        var data=json.decode(res.body);
       // print(jsonDecode(data));
        setState(() {
          _notloading=false;
        });
        serviceModels.clear();
   // print('data[data]${(data['data']).runtimeType}');
          var jsons=json.encode((data['data'][1]['itemsUsed']));
         // print(jsons);
        //  print(json.decode(jsons));
        for(Map i in data['data']){
        //  print(i);
      // print(i['itemsUsed'].runtimeType);
         
          serviceModels.add(Services.fromJson(i));
        }
      //  print(serviceModel.length);
        for(var i=0; i<(data['data']).length; i++){
            for(Map j in (data['data'][i]['itemsUsed'])){
            
            }
          
         
        }
       
      

    }
    )
    .catchError((onError){
    print(onError);
    setState(() {
          _notloading=true;
        });
    });
    return serviceModels;
  }

  String userid;
  _MyServicesState(String userId){
    userid=userId;
  }
  @override
  void initState() {
   
    super.initState();
    myServices().then((value){
    setState(() {
      serviceModel.addAll(value);
    });
    })
    .catchError((onError){

    });
    //serviceModel=List<Services>;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Services'),),
      body:_notloading ? Center(
        child: CircularProgressIndicator(
                              value: null,
                              strokeWidth: 7.0,
                            ),
      )
      :Container(
        padding: EdgeInsets.all(20),
        child:ListView.builder(
           itemCount: serviceModel.length,
           itemBuilder: (context,i){
             final details=serviceModel[i];
             return
            
              Card(
                shadowColor: Colors.grey,
                elevation: 15.0,
                margin:EdgeInsets.all(20),
                child: ListTile(
              
                 title:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                   children:<Widget>[
                     ListTileCard(type:"JOB NUMBER",value:"${details.jobNo}",),
                       ListTileCard(type:"JOB TYPE",value:"${details.jobType}",),
                     ListTileCard(type:"VEHICLE",value:"${details.vehicle.vehicleRegNo}",),

                   ],
                 ),
                subtitle: Column(
                  children: <Widget>[
                    RaisedButton(
                      splashColor: Colors.green,
                      shape: 
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side:BorderSide(color:Colors.blue)
                        ),
                    
                      elevation: 10.0,
                      onPressed: ()=>otherDetails(details), 
                      child:Text("View",style:TextStyle(color:Colors.white)),
                      color:Colors.blue
                      ),
                  ],
                ),
              )
              );
             
            

           },
                    ),
      ),
    );
  }
 Future<void> otherDetails(details) async{
    String jobid=details.jobNo;
    List items=[];
    var techin;
    List<Tech>techModel=[];
    Map map;
    print(jobid);
  await http.get('http://${Ip.ip}:3000/jobs/viewJob/$jobid')
  .then((res){
       
       var data=json.decode(res.body);
      // map.clear();
       items=data['data']['itemsUsed'];
        techin=data['data']['technicians'];
     //  print(techin);
      //  for(var i in techin){
      //    print(i.length);
      //    print(i[0]);
      //    map.putIfAbsent('techId', () =>i[0]);
      //    map.putIfAbsent('addedOn', () => i[1]);
      //  }
      for(var i in data['data']['technicians']){
        // print(techin[i]);
        // print(techin.length);
            techModel.add(Tech.fromJson(i));
            
      }
      print(techModel.length);
     //  print(map);
      itemsModel.clear();
    
    for(Map j in data['data']['itemsUsed']){
      itemsModel.add(Item.fromJson(j));
      
    
    }
   
  }
   )
   .catchError((onError){
     print(onError);
   });
   
        return showMaterialResponsiveDialog(
          cancelText: '',
          headerColor: Color.fromRGBO(250, 250, 250, 1),
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
       title:'',
       
    context: context,
    child: SingleChildScrollView(
          child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Text('ITEM DETAILS',style:TextStyle(fontSize: 25,fontWeight: FontWeight.w900,),),
                 ),
                 ListTileCard(type:"JOB ID",value:details.jobNo),
                 ListTileCard(type:"JOB TYPE",value:details.jobType),
                 ListTileCard(type:"CUSTOMER ID",value:details.custId),
                 ListTileCard(type:"VEHICLE REG NO",value:details.vehicle.vehicleRegNo),
                 ListTileCard(type:"CHASIS",value:details.vehicle.chasis),
                 ListTileCard(type:"ENGINE NO",value:details.vehicle.engineNo),
                 ListTileCard(type:"PROBLEM",value:details.problem),
                 ListTileCard(type:"FORMAN OBSERVATION",value:details.foremanOb),
                 ListTileCard(type:"ESTIMATED CHARGE",value:details.estCharge),
                
                Padding(padding: EdgeInsets.all(20.0),
                  child:Text("ITEM USED",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w900,))

                ),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
       child:DataTable(
          horizontalMargin: 10.0,
         columnSpacing: 20.0,
      columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'ItemId',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
       
        
        DataColumn(
          label: Text(
            'ItemType',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
        DataColumn(
          label: Text(
            'ItemName',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
        DataColumn(
          label: Text(
            'UnitPrice',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
         DataColumn(
          label: Text(
            'Qut',
            style:TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
         DataColumn(
          label: Text(
            'Charge',
            style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),
          ),
        ),
      ],
     
      
      rows:items.length==0 ? const <DataRow>[
         DataRow(
          cells: <DataCell>[
            DataCell(Text('')),
            DataCell(Text('')),
              DataCell(Text('  ')),
            DataCell(Text('')),
               DataCell(Text('')),
                  DataCell(Text('')),
            
          ],
        ),
        
      
        
      ]:itemsModel
       .map((e) => 
          DataRow(
            cells: [
              DataCell(
                 Text(e.itemId==null?"":e.itemId)
              ),
              DataCell(
                Text(e.itemType==null?"":e.itemType),
              ),
              DataCell(
                Text(e.itemName==null?"":e.itemName),
              ),
              DataCell(
                Text(e.unitPrice==null?"":e.unitPrice),
              ),
              DataCell(
                Text(e.qut==null?"":e.qut),
              ),
             DataCell(
               Text(e.charge==null?"":e.charge)
             ),
            ],
            
            ),
       ).toList()
    )
                 ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("TECHNICIANS",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w900,)),
                  ),
                  DataTable(
                   columns: <DataColumn>[
                     DataColumn(label: Text("TECH ID",
                      style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),)),
                     DataColumn(label: Text("ADDED DATE", 
                     style: TextStyle(fontStyle: FontStyle.italic,color:Colors.black,fontSize:15),))
                   ],
                   rows:techModel.map(
                     (e) => 
                      
                     DataRow(cells:[
                       DataCell(Text(e.techId==null?"":e.techId)),
                        DataCell(Text(e.addedDate==null?"":e.addedDate))
                     ] )
                   
                     ).toList()
                   
                  
                   ),
                   SizedBox(height:30),
                  ListTileCard(type:"SUB TOTAL",value:details.subTotal==null?"__":details.subTotal),
                  ListTileCard(type:"TAX",value:details.tax==null?"__":details.tax), 
                  ListTileCard(type:"GRAND TOTAL",value:details.grandTotal==null?"__":details.grandTotal),
                  ListTileCard(type:"AMOUNT PAID",value:details.amountPaid==null?"__":details.amountPaid),
                  ListTileCard(type:"BALANCE",value:details.balance==null?"__":details.balance),
                  ListTileCard(type:"Last Paid On",
                  value:details.lastPaidOn==null?"__":(details.lastPaidOn)
                  .length<21?details.lastPaidOn:(details.lastPaidOn).substring(0,21)),
                  ListTileCard(type:"JOB STATUS",value:details.jobStatus==null?"__":details.jobStatus),
                
                
              ],
          ),
          
          
      ),
    ),
);
        // return AboutDialog(
        //    title:Text("Other Details"),
        //    content: SingleChildScrollView(
        //      child:ListBody(
        //        children: <Widget>[
        //          Text("onh")
        //      ],
        //      ),
        //    ),
        // );
      }
    
}