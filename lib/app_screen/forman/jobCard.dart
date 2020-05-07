
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class JobCard extends StatefulWidget {
 

 

  @override
  _JobCardState createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
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
         child:Column(
           children:<Widget>[
             Text("Add Job Card"),
             SizedBox(height: 20,),
             
               TextFormField(
                 decoration: InputDecoration(
                   hintText:"Job NO"
                 ),
               ),
            SizedBox(height: 20,),
             TextFormField(
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
            Text("Vehicale Deatails"),
            SizedBox(height: 20,),
             TextFormField(
                 decoration: InputDecoration(
                   hintText:"Vehicale No"
                 ),
               ),
            SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Make"
                 ),
               ),
            SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Chassis No"
                 ),
               ),
             SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Model"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Engine No"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Milage"
                 ),
               ),
                 SizedBox(height: 20,),
                 Text("Customer Details"),
                 SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Customer Name"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Contact No"
                 ),
               ),
                 SizedBox(height: 20,),
              TextFormField(
                 decoration: InputDecoration(
                   hintText:"Address"
                 ),
               ),
                              SizedBox(height:20),
               RaisedButton(onPressed: (){},
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
