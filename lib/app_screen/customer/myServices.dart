

import 'package:automosoft_mobile/app_screen/customer/listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class MyServices extends StatefulWidget {
  final String userId;
  MyServices({Key key, this.userId}) : super(key: key);

  @override
  _MyServicesState createState() => _MyServicesState(userId);
}

class _MyServicesState extends State<MyServices> {

  String userid;
  _MyServicesState(String userId){
    userid=userId;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Services'),),
      body: Container(
        padding: EdgeInsets.all(20),
        child:ListView(
            children: <Widget>[
              Card(
                shadowColor: Colors.amber,
                elevation: 10.0,
                child: ListTile(
              
                 title:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                   children:<Widget>[
                     ListTileCard(type:"JOB NUMBER",value:"JOB002",),
                       ListTileCard(type:"JOB TYPE",value:"FULL SERVICE",),
                     ListTileCard(type:"VEHICLE",value:"DDD-9898",),

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
                      onPressed: ()=>otherDetails(), 
                      child:Text("View",style:TextStyle(color:Colors.white)),
                      color:Colors.blue
                      ),
                  ],
                ),
              )
              ),
             
            ],
        ),
      ),
    );
  }
 Future<void> otherDetails() async{
   
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
                   child: Text('ITEM DETAILS'),
                 ),
                 ListTileCard(type:"JOB ID",value:"nmae"),
                 ListTileCard(type:"JOB TYPE",value:"nmae"),
                 ListTileCard(type:"CUSTOMER ID",value:"nmae"),
                 ListTileCard(type:"VEHICLE REG NO",value:"nmae"),
                 ListTileCard(type:"CHASIS",value:"nmae"),
                 ListTileCard(type:"ENGINE NO",value:"nmae"),
                 ListTileCard(type:"PROBLEM",value:"nmae"),
                 ListTileCard(type:"FORMAN OBSERVATION",value:"nmae"),
                 ListTileCard(type:"ESTIMATED CHARGE",value:"nmae"),
                
                Padding(padding: EdgeInsets.all(20.0),
                  child:Text("ITEM USED")

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
                  child: Text("TECHNICIANS"),
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
                  ListTileCard(type:"SUB TOTAL",value:"nmae"),
                  ListTileCard(type:"TAX",value:"nmae"), 
                  ListTileCard(type:"GRAND TOTAL",value:"nmae"),
                  ListTileCard(type:"AMOUNT PAID",value:"nmae"),
                  ListTileCard(type:"BALANCE",value:"nmae"),
                  ListTileCard(type:"LAST PAID ON",value:"nmae"),
                  ListTileCard(type:"JOB STATUS",value:"nmae"),
                
                
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