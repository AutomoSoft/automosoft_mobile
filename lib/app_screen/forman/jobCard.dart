
import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:http/http.dart'as http;

class JobCard extends StatefulWidget {
 

 

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
   final _formKey=GlobalKey<FormState>();
     TextEditingController jobNo=TextEditingController();
     TextEditingController serialNo=TextEditingController();
     TextEditingController vehicalNo=TextEditingController();
     TextEditingController make=TextEditingController();
     TextEditingController chassisNo=TextEditingController();
     TextEditingController model=TextEditingController();
     TextEditingController engineNo=TextEditingController();
     TextEditingController milage=TextEditingController();
     TextEditingController customerName=TextEditingController();
     TextEditingController contactNo=TextEditingController();
     TextEditingController address=TextEditingController();
     TextEditingController emailAddress=TextEditingController();
    

      DateTime  _selectday;

  @override
  void initState() { 
    super.initState();
    _selectday=DateTime.now();
  }
 
  TextEditingController a=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      
       child: Form(
          key: _formKey,
         child:Column(
           children:<Widget>[
             Text("Add Job Card",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
             SizedBox(height: 20,),
             
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
             TextFormField(
                controller: serialNo,
               validator: (value){
                 if(value.isEmpty || value.trim()==""){
                   return "Enter Serial Number";
                 }
               },
                 decoration: InputDecoration(
                   hintText:"Serial No"
                 ),
               ),
            SizedBox(height: 20,),
             ListTile(
                leading: Icon(Icons.calendar_today),
                title:Text("Date : ${_selectday.day.toString()}/${_selectday.month.toString()}/${_selectday.year.toString()}"),
               
                onTap: ()=>datePicker(),
              ),
            Text("Vehicale Deatails",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 20,),
             TextFormField(
                 controller: vehicalNo,
                validator: (value){
                  if(value.isEmpty || value.trim()==""){
                    return "Enter Vehicle No";
                  }
                },
                 decoration: InputDecoration(
                   hintText:"Vehicale No"
                 ),
               ),
            SizedBox(height: 20,),
              TextFormField(
                   controller: make,
                  validator: (value){
                    if(value.isEmpty||value.trim()==""){
                      return "require";
                    }
                  },
                 decoration: InputDecoration(
                   hintText:"Make"
                 ),
               ),
            SizedBox(height: 20,),
              TextFormField(
                  controller:chassisNo,
                validator: (value){
                  if(value.isEmpty || value.trim()==''){
                    return "Enter chassis No";
                  }
                },
                 decoration: InputDecoration(
                   hintText:"Chassis No"
                 ),
               ),
             SizedBox(height: 20,),
              TextFormField(
                 controller: model,
                 validator: (value){
                   if(value.isEmpty||value.trim()==''){
                         return "require";
                   }
                 },
                 decoration: InputDecoration(
                   hintText:"Model"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                 controller: engineNo,
                 validator: (value){
                   if(value.isEmpty || value.trim()==''){
                     return "require";
                   }
                 },
                 decoration: InputDecoration(
                   hintText:"Engine No"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                 controller: milage,
                validator: (value){
                   if(value.isEmpty || value.trim()==''){
                     return "require";
                   }
                 },
                 decoration: InputDecoration(
                   hintText:"Milage"
                 ),
               ),
                 SizedBox(height: 20,),
                 Text("Customer Details",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                 SizedBox(height: 20,),
              TextFormField(
                 controller: customerName,
                 validator: (value){
                   if(value.isEmpty || value.trim()==''){
                     return "Enter Customer Name";
                   }
                 },
                 decoration: InputDecoration(
                   hintText:"Customer Name"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                controller: contactNo,
                 keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  validator: (value){
                   if(value.isEmpty || value.trim()==''||( value.length<10 || value.length>10 )){
                     return"Enter Contact No";
                   }
                 },
                 decoration: InputDecoration(
                   hintText:"Contact No"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                controller: address,
                validator: (value){
                  if(value.isEmpty ||value.trim()==""){
                    return "Enter Address";
                  }
                },
                 decoration: InputDecoration(
                   hintText:"Address"
                 ),
               ),
                  SizedBox(height: 20,),
              TextFormField(
                controller: emailAddress,
                 validator: (value){
                   if(value.isEmpty|| value.trim()==''){
                     return "Enter email";
                   }
                  else if(!EmailValidator.validate(value)){
                     return "Email is not valid";
                  }
                   
                     
                 },
                
                 decoration: InputDecoration(
                   hintText:"Email Address"
                 ),
               ),
               
                              SizedBox(height:20),
               RaisedButton(onPressed: ()=>submitData(),
               color: Colors.green,
                    child:Container(
                   
                      width: double.infinity,
                     
                   
                        
                        child: Text("submit",textAlign:TextAlign.center,),
                     
                    ),


               ),
           ],
         ) 
         ),
    );
  }
  submitData() async{
    if(_formKey.currentState.validate()){
          Map data={
            "jobNo":jobNo.text,
            "serialNo":serialNo.text,
            "date":_selectday.toIso8601String(),
            "vehicalNo":vehicalNo.text,
            "make":make.text,
            "chassisNo":chassisNo.text,
            "model":model.text,
            "engineNo":engineNo.text,
            "milage":milage.text,
            "customerName":customerName.text,
            "contactNo":contactNo.text,
            "address":address.text,
            "emailAddress":emailAddress.text
             
          };
          var jsonResponse=null;
          var response=await http.post("http://192.168.1.102:3000/addJobCard",body:data);
          jsonResponse=json.decode(response.body);
          if(jsonResponse!=null){
            print("data Post");
            jobNo.text="";
            serialNo.text="";
           
            vehicalNo.text="";
            make.text="";
            chassisNo.text="";
            model.text="";
            engineNo.text="";
            milage.text="";
            customerName.text="";
            contactNo.text="";
            address.text="";
            emailAddress.text="";
            setState(() {
               _selectday=DateTime.now();
            });
           final snackBar = SnackBar(
             
             content: Container(
               height: 30,
               alignment: Alignment.center,
               child: Row(
                 children:<Widget>[
                        Icon(Icons.check_circle,color:Colors.green),
                        Text("The Form was submitted successfully")
                 ]
               ),
             ),
              action: SnackBarAction(
              label: 'ok',
               onPressed: () {
     
              },
                  ),
           );
             Scaffold.of(context).showSnackBar(snackBar);

          }
           


    }
  }
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
}
