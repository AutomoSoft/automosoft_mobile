
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

class JobCard extends StatefulWidget {
 

 

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  var userids= List<String>();
  
   List <Technician> listModel=[];
   List <Vehicle> vehicleModel=[];

   String jobtype=null;
   String customer=null;

   var jobType=["Paint Job","Accident Repair","Valuation","Other"];
   
   
    final _formKey=GlobalKey<FormState>();
     TextEditingController jobNo=TextEditingController();
     TextEditingController problemReport=TextEditingController();
     TextEditingController foremanObser=TextEditingController();
     TextEditingController  serviceChage=TextEditingController();
      DateTime  _selectday;
     
    
    
     

  /*..............................................................*/
  Future fetchCustomerid() async {

      await http.get('http://${Ip.ip}:3000/mobile/customer')
      .then((res)  {
        var userData =json.decode(res.body);
      
          userids.clear();
      for (var i in userData){
        print(i);
        userids.add(i['userid']);        
      }
      
    
       
       }).
      catchError((err){
        
         print("error");
           print(err);
      });

}
/*.................................*/
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
                  },
                  value: jobtype,
                  ),
                
                  TextFormField(
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
                 
                  SizedBox(
                      height:100,
                    child: ListView.builder(
                      itemCount: vehicleModel.length,
                      itemBuilder:(context, i){
                        final vehicle=vehicleModel[i];
                         return  ListTile(
                              title:Text(vehicle.vehicleRegNo),
                              trailing:Icon(vehicle.checked? Icons.check_box: Icons.check_box_outline_blank,color:Colors.amber),
                              
                              onTap:(){
                                setState(() {
                                  vehicle.checked ^=true;
                                  
                                });
                              },
                          );;
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
               
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: listModel.length,
                    itemBuilder: (context, i){
                      final techician=listModel[i];
                       return
                           ListTile(
                              title:Text(techician.userid),
                              trailing:Icon(techician.checked? Icons.check_box: Icons.check_box_outline_blank,color:Colors.amber),
                              subtitle: Text("CURRENT WORK STATUS:  ${techician.curr} / ${techician.cap} "),
                              onTap:(){
                                setState(() {
                                  techician.checked ^=true;
                                  if(techician.checked){
                                    techician.curr=techician.curr+1;
                                  }
                                  else{
                                    techician.curr=techician.curr-1;
                                  }
                                  
                                });
                              },
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
                  RaisedButton(onPressed: (){},
                  color: Colors.green,
                       child:Container(
                      
                         width: double.infinity,
                        
                      
                           
                           child: Text("Submit",textAlign:TextAlign.center,),
                        
                       ),
   
   
                  ),
              ],
            ) 
            ),
       );
     }
     /*......................................................................*/
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
                          });
                        }
     }
   
 /*........................................................................*/    
   }
   


