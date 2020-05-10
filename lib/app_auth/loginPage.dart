import 'dart:convert';
import 'dart:async';

import 'package:automosoft_mobile/app_screen/forman/homePage.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

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
             Color.fromRGBO(11, 29, 71, 0.9),
             Color.fromRGBO(194, 132, 0, 0.9),
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
                  FlatButton(onPressed: (){}, child: Text("Forgot password?",
                  style:TextStyle(
                    color:Colors.black,
                    fontSize:20,
                    fontFamily:"Comic",
                    fontWeight: FontWeight.bold
                    ),
                  )
                  ),

                   SizedBox(height:20),
                   Container(
            width: 350,
            height: 50.0,
            
            child :RaisedButton(
                 
                    child: Text(" Login ",style:TextStyle(fontSize:25,fontFamily:"Comic",fontWeight: FontWeight.bold),),
                    onPressed: ()=>_login(_userNameController.text,_passwordController.text),
                    color: Color.fromRGBO(45, 99, 54, 1),
                    textColor: Colors.white,
                    splashColor: Colors.grey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    
                  )
            )
                  
                 
                 
                      ],),
                  
                ),
                 
               
            ]
        ),
      ),

      ],),
     
    );
  }
  Future<void> _login(String userName, String pass)async{
      // SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
     
     if(_formKey.currentState.validate()){
       // 
       Map data={
          "userName":userName,
          "password":pass,
       };
      // print(data["userName"]);
       var jsonResponse=null;
       var response=await http.post("http://192.168.1.102:3000/mobileUser/signIn",body:data);
       jsonResponse=json.decode(response.body);
       if(jsonResponse !=null){
     
           setState(() {
             
           });
           //sharedPreferences.setString('token', jsonResponse['token']);
          // print("Response stautus:${response.statusCode}");
          // print("Respose body:${response.body}");
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage(userName: _userNameController.text,)));
       }
         else {
           print("else");
             final snackBar = SnackBar(
             
             content: Container(
               height: 30,
               alignment: Alignment.center,
               child: Row(
                 children:<Widget>[
                        Icon(Icons.error,color:Colors.red),
                        Text("username and password is incorrect!", style: TextStyle(color:Colors.red),)
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
  Widget snakBar(){
     final snackBar=SnackBar(
            content: Text("UserName and Password Incorrect"),
            action: SnackBarAction(label:"Ok", onPressed:(){

            },
            ),
            
            );
            Scaffold.of(context).showSnackBar(snackBar);
  }
}

