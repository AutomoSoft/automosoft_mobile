

import 'dart:convert';

import 'package:automosoft_mobile/app_screen/customer/listtile.dart';
import 'package:automosoft_mobile/constant.dart';
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
    // print((data['data']));
     //print((data['data'][1]['itemsUsed']));
        for(Map i in data['data']){
        print((i['itemsUsed']));
         
          serviceModels.add(Services.fromJson(i));
        }
        print(serviceModel.length);
        for(var i=0; i<(data['data']).length; i++){
             //  print((data['data'][i]['vehicle']) );
          
         
        }
        // String name='{"yasind":"name"}';
        //  print(jsonDecode(name));
      

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
                shadowColor: Colors.amber,
                elevation: 10.0,
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
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Table(
                     border: TableBorder.all(),
                     children:[
                       TableRow(
                        children:[
                          Text("ITEM ID"),
                          Text("ITEM NAME"),
                          Text("ITEM TYPE"),
                          Text("QUANTITY"),
                          Text("UNIT PRICE"),
                          Text("CHARGE")
                        ]
                       ),
                       TableRow(
                        children:[
                          Text("P0004"),
                          Text("ITEM NAME itme nMAE"),
                          Text("ITEM TYPEJ VALD D"),
                          Text("1000"),
                          Text("10000"),
                          Text("200000")
                        ]
                       )
                     ] ,
                     ),
                 ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("TECHNICIANS",style:TextStyle(fontSize: 25,fontWeight: FontWeight.w900,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Table(
                     border: TableBorder.all(),
                     children:[
                       TableRow(
                        children:[
                          Text("TECH ID"),
                          Text("ADDED DATE"),
                          
                        ]
                       ),
                       TableRow(
                        children:[
                          Text("ITEM ID"),
                          Text("ITEM NAME"),
                          
                        ]
                       )
                     ] ,
                     ),
                  ),
                   SizedBox(height:20),
                  ListTileCard(type:"SUB TOTAL",value:details.subTotal==null?"__":details.subTotal),
                  ListTileCard(type:"TAX",value:details.tax==null?"__":details.tax), 
                  ListTileCard(type:"GRAND TOTAL",value:details.grandTotal==null?"__":details.grandTotal),
                  ListTileCard(type:"AMOUNT PAID",value:details.amountPaid==null?"__":details.amountPaid),
                  ListTileCard(type:"BALANCE",value:details.balance==null?"__":details.balance),
                  ListTileCard(type:"Last Paid On",value:details.lastPaidOn==null?"__":(details.lastPaidOn).substring(0,21)),
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