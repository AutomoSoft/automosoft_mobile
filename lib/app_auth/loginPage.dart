import 'dart:convert';
import 'dart:async';

import 'package:automosoft_mobile/app_screen/customer/homePage.dart';
import 'package:automosoft_mobile/app_screen/forman/homePage.dart';
import 'package:automosoft_mobile/constant.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey=GlobalKey<FormState>();
   
  TextEditingController _userNameController= TextEditingController();
  TextEditingController _passwordController= TextEditingController();
  bool _passwordVisble=true;
  bool _isLogin=true;
  String userNotFound;
  FocusNode _node;

  
  @override
  void initState() {
     _node=FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          
       body:Stack(children: <Widget>[
         Container(
              
           width: double.infinity,
        decoration: BoxDecoration(
         gradient: LinearGradient(
           colors:[
            
             Color.fromRGBO(235, 132, 0, 0.9),
              Color.fromRGBO(7, 14, 32, 0.9),
           ],
         
           ),
           image: DecorationImage(
             alignment: Alignment.topCenter,
              fit:BoxFit.contain,
             image:AssetImage('assets/images/logo.png') 
             ),
        ),
        child:  Column(
                    
                 crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget>[
                   
              SizedBox(
                height: 120,
              ),
              Text("Login",style:TextStyle(color:Colors.white,fontSize:40,fontWeight:FontWeight.bold,fontFamily:'Comic')),
                SizedBox(height:20),
                Form(
                  
                  key:_formKey,
                  child:
                    Column(
                      children: <Widget>[
                              Container(
                  
                  margin:EdgeInsets.only(right:30,left:30),
                  decoration: BoxDecoration(
                     color:Colors.white,
                     borderRadius: BorderRadius.circular(20)
                  ),
                 
                    child: ListTile(
                      
                      leading:Icon(Icons.person),
                      title: TextFormField(
                        
                        controller: _userNameController,
                      textInputAction: TextInputAction.next,
                        onEditingComplete: (){
                          FocusScope.of(context).requestFocus(_node);
                        },
                        
                        validator: (value){
                          if(value.isEmpty ||value.trim()==""){
                            return "Please enter  your Username";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                      labelText: 'Username',
                        
                        ),
                      ),
                    ),
                    
                       
                        
                        
                   
                  ),
                   SizedBox(height:20),
                    Container(
                  
                  margin:EdgeInsets.only(right:30,left:30),
                  decoration: BoxDecoration(
                     color:Colors.white,
                     borderRadius: BorderRadius.circular(20)
                  ),
                 
                    child: ListTile(
                      leading: Icon(Icons.lock),
                      title: TextFormField(
                        
                        controller: _passwordController,
                        focusNode: _node,
                        
                        validator: (value){
                          if(value.isEmpty ||value.trim()==""){
                            return "Enter Your Password";

                          }
                          else if(value.length<8){
                            return "Password is less than 8";
                          }
                        },
                        decoration: InputDecoration(
                            labelText:"Password",
                            suffixIcon: IconButton(
                            
                              icon:Icon(_passwordVisble?Icons.visibility_off : Icons.visibility),
                              onPressed: (){
                                setState(() {
                                  _passwordVisble ^=true;
                                });
                              },
                            ),
                        ),
                        obscureText:_passwordVisble,
                        
                        
                      ),
                      
                    ),
                       
                        
                        
                   
                  ),
                  // FlatButton(onPressed: (){}, child: Text("Forgot password?",
                  // style:TextStyle(
                  //   color:Colors.black,
                  //   fontSize:20,
                  //   fontFamily:"Comic",
                  //   fontWeight: FontWeight.bold
                  //   ),
                  // )
                  // ),

                   SizedBox(height:40),

                   Container(
            width: 350,
            height: 50.0,
            
            child :
            RaisedButton(
                 
                    child: Text(" Login ",style:TextStyle(fontSize:25,fontFamily:"Comic",fontWeight: FontWeight.bold),),
                    onPressed: ()=>  _login(_userNameController.text,_passwordController.text) ,
                    color: Color.fromRGBO(45, 99, 54, 1),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    
                  )
            ),
             
                
                 
                 
                      ],),
                  
                ),
                 
               
            ]
        ),
      ),

      ],),
     
    );
  }
 void showAleart(String msg){
  
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.black,
             title: new Text("$msg" ,style:TextStyle(color:Colors.red)),
          content: new Text("Enter Registered User Id and password ",style:TextStyle(color:Colors.red)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK",style:TextStyle(color:Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
          );
        }
        );
         
  
 }
    Future<void> _login(String userName, String pass)async{
      if(_formKey.currentState.validate()) {
       
       Map data={
          "userid":userName,
          "password":pass,
       };
        return await http.
        post("http://${Ip.ip}:3000/mobile/login",body:data).
         then(( http.Response res ){
            var userData=json.decode(res.body);
          // print(userData['msg']);
            userNotFound=userData['msg'];
           print(userData['state']);
           
            bool state=userData['state'];
            if (state==false){
              showAleart(userNotFound);
                
               
              }
              
           else {
               String usertype=userData['user']['usertype'];
               String fname=userData['user']['firstname'];
               String lname=userData['user']['lastname'];
               String name="${fname} ${lname}";
             
               if(usertype=="Foreman"){
                 setState(() {
                    _isLogin=true;
                 });
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(userName:name, userid:userName,)));
            }
            else if( usertype=="Customer"){
               setState(() {
                    _isLogin=true;
                 });
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerHome(userName:name,userId:userName)));
            }
            else{
          
               showAleart(userNotFound);
            }
             
            }          
            
         }).catchError((onError){
           print("sdjflsdkjflk");
           print(onError);
           
         });
        
        
               
               }
        
            }
         
          // Widget snakBar(){
          //    final snackBar=
          //          
          // }
        }
        


