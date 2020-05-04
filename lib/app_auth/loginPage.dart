import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                        decoration: InputDecoration(
                            labelText:"Password",
                            
                        ),
                        obscureText: true,
                        
                        
                      ),
                      trailing: IconButton(onPressed:(){
                        
                      },icon: Icon(Icons.visibility_off),),
                    ),
                       
                        
                        
                   
                  ),
                  FlatButton(onPressed: (){}, child: Text("Forgot password?",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Comic",fontWeight: FontWeight.bold),)),

                   SizedBox(height:20),
                   Container(
            width: 350,
            height: 50.0,
            
            child :RaisedButton(
                 
                    child: Text(" Login ",style:TextStyle(fontSize:25,fontFamily:"Comic",fontWeight: FontWeight.bold),),
                    onPressed: (){},
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
}

