
import 'dart:convert';
import 'dart:async';
import 'package:automosoft_mobile/constant.dart';
import 'package:automosoft_mobile/models/technician.dart';
import 'package:automosoft_mobile/models/vehicaleDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';

class JobCard extends StatefulWidget {
   String userId;
    JobCard({Key key ,this.userId}):super(key:key);

 

 

  @override
  _JobCardState createState() => _JobCardState(userId);
}

class _JobCardState extends State<JobCard> {
  var userids= List<String>();
  String foremanId;
   _JobCardState(String foremanid){
       foremanId=foremanid;
       print(foremanId);
   }
    
   List <Technician> listModel=[];
   List <Vehicle> vehicleModel=[];
   String vehicleDetails;
  
   final technicians=[];
   List <int> techIndex=[];
   List<int> vehicleIndexes=[];
    int vehicleIndexe=-1;
   String jobtype=null;
   String customer=null;

   var jobType=["Paint Job","Accident Repair","Vehicle Valuation","Other"];
   
   
    final _formKey=GlobalKey<FormState>();
     TextEditingController jobNo=TextEditingController();
     TextEditingController problemReport=TextEditingController();
     TextEditingController foremanObser=TextEditingController();
     TextEditingController  serviceChage=TextEditingController();
      DateTime  _selectday;
      String  selectday;
     
    
    
     

  /*..............................................................*/
  Future fetchCustomerid() async {

      await http.get('http://${Ip.ip}:3000/mobile/customer')
      .then((res)  {
        var userData =json.decode(res.body);
      
          userids.clear();
      for (var i in userData){
       // print(i);
        userids.add(i['userid']);        
      }
      
    
       
       }).
      catchError((err){
        
         print("error");
           print(err);
      });

}
/*.................................*/
  Future<void> getLastjobNumber() async{

    await http.get('http://${Ip.ip}:3000/getLastId/getLastJobNo')
    .then((res){
          var data=jsonDecode(res.body);
          print(data['data'][0]['jobNo']);
          String lastjobNo=data['data'][0]['jobNo'];
          String lastnum=lastjobNo.substring(5);
          int newNumber=1+(int.parse(lastnum));
          String newJobNo="JOB00$newNumber";
          print(newJobNo);
          jobNo.text=newJobNo;
    }
    
    )
    .catchError((onError){
      print(onError);
    });

  }

/*.....................................*/
// ignore: missing_return
Future<List<Technician>> fetchTech(String jobtype) async{
    final resbody=await http.get('http://${Ip.ip}:3000/mobile/getTechnicians/$jobtype')
    .then((res){
      final resbody=jsonDecode(res.body) ;
      //print(resbody);
      listModel.clear();
       setState(() {
         for(Map k in resbody){
        //   print(k);
           listModel.add(Technician.fromJson(k));
         }
       });
    })
    .catchError((onError){
         print(onError);
    });

}
/*...........................................*/
  // ignore: missing_return
  Future<List<Vehicle>> getvehicale({String custid})async{
     setState(() {
         this.customer=custid;
          
      });
     
    await http.get('http://${Ip.ip}:3000/mobile/vehicales/$custid').
    then((res){
    final vehicle=jsonDecode(res.body);
     vehicleModel.clear();
     setState(() {
            for(Map i in vehicle){
              vehicleModel.add(Vehicle.fromJson(i));
            }     
      });      
      
       

      
     
    }

     )
    .catchError((err){
      print("errr");
      print(err);
    });

}
/*...............................................................*/

     @override
     void initState() { 
       super.initState();
       fetchCustomerid();
       getLastjobNumber();
      
      
       _selectday=DateTime.now();
      
     }
    
/*........................................................................*/
     @override
     Widget build(BuildContext context) {
       return Container(
         
          child: Form(
             key: _formKey,
            child:Column(
              children:<Widget>[
                Text("Job Card",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
                DropdownButton<String>(
                     isExpanded: true,
                     hint:Text("JOB TYPE"),
                  items:jobType.map((item){
                        return DropdownMenuItem<String>(
                          child: Text(item),
                          value:item,
                          );

                  }).toList(),
                 
                  onChanged:(String newValue){
                        setState(() {
                          this.jobtype=newValue;
                        });
                        fetchTech(newValue);
                     // ignore: unnecessary_statements
              
                  },
                  value: jobtype,
                  ),
                
                  TextFormField(
                      readOnly: true,
                         controller: jobNo,
                    validator: (value){
                      if(value.isEmpty ||value.trim()==""){
                         return  "Enter Job Number";
                      }
                    },
                    decoration: InputDecoration(
                      hintText:"Job No"
                    ),
                  ),
               SizedBox(height: 20,),
               
               
                ListTile(
                   leading: Icon(Icons.calendar_today),
                   title:Text("Date : ${_selectday.day.toString()}/${_selectday.month.toString()}/${_selectday.year.toString()}"),
                  
                   onTap: ()=>datePicker(),
                 ),
                 DropdownButton<String>(
                     isExpanded: true,
                     hint:Text("Customer Id"),
                  items:userids.map(( item){
                        return DropdownMenuItem<String>(
                          child: Text(item),
                          value:item,
                          );

                  }).toList(),
                 
                  onChanged:( newValue){
                       
                        getvehicale(custid:newValue);
                  },
                  value: customer,
                  ),
                                 SizedBox(height:20),
                  Text("SELECT VEHICLE" ,style:TextStyle(fontSize:20)),
                  SizedBox(
                      height:100,
                    child: ListView.builder(
                      itemCount: vehicleModel.length,
                      itemBuilder:(context, i){
                        final vehicle=vehicleModel[i];
                         return  ListTile(
                              title:Text(vehicle.vehicleRegNo),
                              trailing:Icon(vehicleIndexe==i? Icons.check_box: Icons.check_box_outline_blank,color:Colors.amber),
                            
                              onTap:(){
                                setState(() {
                                  vehicle.checked ^=true;
                                  if(vehicle.checked){
                                      vehicleIndexe=i;
                                   

                                  }
                                  
                                 
                                  
                                });
                              },
                          );
                      })
                     
                    ) ,
                  
                                  SizedBox(height:20),
                                  TextFormField(
                         controller:problemReport,
                         maxLines:5,
                    validator: (value){
                      if(value.isEmpty ||value.trim()==""){
                         return  "problem";
                      }
                    },
                    decoration: InputDecoration(
                      
                      hintText:"Problem Reported"
                    ),
                  ),
               SizedBox(height: 20,),
                TextFormField(
                      maxLines:5,
                            
                         controller:foremanObser,
                    validator: (value){
                      if(value.isEmpty ||value.trim()==""){
                         return  "Observation";
                      }
                    },
                    decoration: InputDecoration(
                      
                      hintText:"Foreman Observation"
                    ),
                  ),
               SizedBox(height: 20,),
                  Text("ADD TECHNICIANS" ,style:TextStyle(fontSize:20)),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: listModel.length,
                    itemBuilder: (context, i){
                      final techician=listModel[i];
                       return
                          ExpansionTile(
                              title:Text(techician.userid),
                              leading: IconButton(
                                color:Colors.amber,
                                icon:techician.checked? Icon(Icons.check_box, ):Icon(Icons.check_box_outline_blank),
                               onPressed:(){
                                  if(techician.checked==true){
                                      setState(() {
                                          techician.checked=false;
                                          
                                          
                                      });

                                  }
                                  else{
                                     setState(() {
                                        techician.checked=true;
                                     });
                                  }
                                  if(techician.checked){
                                             techIndex.add(i);
                                           
                                          }
                                          else{
                                            techIndex
                                            .remove(i);
                                          
                                          }
                                  
                               }),
                              subtitle: Text("CURRENT WORK STATUS:  ${techician.curr} / ${techician.cap} "),
                              children: <Widget>[
                                Padding(padding:EdgeInsets.all(20),
                                 child:  Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    
                                     IconButton(
                                       color:Colors.green,
                                       icon: Icon(Icons.add_circle ,size:45,), onPressed:techician.checked?(){
                                       setState(() {
                                         if(techician.curr<techician.cap){
                                           techician.curr=techician.curr+10;
                                         }
                                       });
                                     }:null),
                                     IconButton(
                                       color:Colors.red ,
                                       icon: Icon(Icons.cancel, size:45), onPressed:techician.checked?(){
                                       setState(() {
                                         if(techician.curr>0){
                                         techician.curr=techician.curr-10;
                                         }
                                       });
                                     }:null)
                                ],), 
                                ),
                              
                                  
                              ],
                              // onTap:(){
                              //   setState(() {
                              //     techician.checked ^=true;
                              //     if(techician.checked){
                              //       techician.curr=techician.curr+1;
                              //     }
                              //     else{
                              //       techician.curr=techician.curr-1;
                              //     }
                                  
                              //   });
                              // },
                          );
                        
                    }
                    ),
                ),
                 
               SizedBox(height: 20,),
                TextFormField(
                    keyboardType:TextInputType.number,
                         controller: serviceChage,
                    validator: (value){
                      if(value.isEmpty ||value.trim()==""){
                         return  "Enter Estimated service charge";
                      }
                    },
                    decoration: InputDecoration(
                      
                      hintText:"Estimated service charge"
                    ),
                  ),
               SizedBox(height: 20,),
                  RaisedButton(onPressed: ()=>submit(),
                  color: Colors.green,
                       child:Container(
                      
                         width: double.infinity,
                        
                      
                           
                           child: Text("Add Job Card",textAlign:TextAlign.center,),
                        
                       ),
   
   
                  ),
              ],
            ) 
            ),
       );
     }
     /*...............................dataPicker .......................................*/
     datePicker()async{
        DateTime newDateTime = await showRoundedDatePicker(
                    context: context,
                   
                    initialDate: _selectday,
                     firstDate: DateTime(DateTime.now().year),
                     lastDate: DateTime(DateTime.now().year + 1),
                 theme: ThemeData.dark()
                        );
                        if(newDateTime!=null){
                          setState(() {
                            _selectday=newDateTime;
                            selectday=DateFormat('EEE MMM  d '  'yyyy  ').format(_selectday);
                          });
                        }
     }
   
 /*...............................submit data .........................................*/    
  Future<void> submit() async{
    List<List<String>> addTechnicians=[];
     addTechnicians.clear();
     if(_formKey.currentState.validate()){
    for(var i in techIndex){
     
      addTechnicians.add([listModel[i].userid ,_selectday.toString()]);
    //  print(jsonEncode( addTechnicians));
    }
    
   
    
   print(addTechnicians);
        
      vehicleDetails='{"vehicleRegNo": "${vehicleModel[vehicleIndexe].vehicleRegNo}","chasis:"${vehicleModel[vehicleIndexe].chasis}","EngineNo":"${vehicleModel[vehicleIndexe].engineNo}"}';
    //  print(vehicleDetails);
    
    Map<dynamic, dynamic> data={
          "jobNo":jobNo.text,
           "jobType":jobtype,
            "custId": customer,
           "vehicle":vehicleDetails,
            "probCus":problemReport.text,
            "foremanObv":foremanObser.text,
             "technicians":addTechnicians,
            "addedby":foremanId,
            "addedon":DateFormat('EEE MMM  d '  'yyyy  ').format(_selectday),
             "lastmodifiedby":"Never Modified",
             "lastmodifiedon":DateFormat('EEE MMM  d '  'yyyy  ').format(_selectday).toString(),
             "estCharge":serviceChage.text,
             "jobStatus":"Queued",
              
    };
     print(data);
    return await http.post("http://${Ip.ip}:3000/jobs/addNewJob",body:data)
    .then((value){
        var data=json.decode(value.body);
         
           final snackBar = SnackBar(
           content: SizedBox(
             height: 50,
             child:data['state']?Text("${data["msg"]}",style:TextStyle(fontSize:20),)
             :Text("${data["msg"]}\n check Job No ",style:TextStyle(fontSize:20,color:Colors.red),),
           ),
             action: SnackBarAction(
               textColor:data['state']?Colors.amber:Colors.red,
             label: 'ok',
           onPressed: () {},
  ),
);
              Scaffold.of(context).showSnackBar(snackBar);
   if(data['state']){
      //  jobNo.text="";
      // problemReport.text="";
      // foremanObser.text="";
      // serviceChage.text="";
      
   }   
    }
    )
    .catchError((error){
      print("error");
       print(error);
       
      // jobNo.text="";
      // problemReport.text="";
      // foremanObser.text="";
      // serviceChage.text="";
    }

    );
     }
     

  }
 
   }
   


