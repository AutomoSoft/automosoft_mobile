

import 'package:automosoft_mobile/app_auth/loginPage.dart';
import 'package:automosoft_mobile/app_screen/forman/jobCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';



class HomePage extends StatefulWidget {
  String userName;
  String userid;
 
  HomePage({Key key,this.userName, this.userid}) : super(key: key);

 



  @override
  _HomePageState createState() => _HomePageState(userName,userid);
}

class _HomePageState extends State<HomePage> {
  
  
   
  String username;
  String userId;
   static bool  jobCard=false;
  _HomePageState(String userName, String userid){
     username=userName;
     userId=userid;

  }
  @override
  void initState() {
  
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
           
              title: Container(
                decoration: BoxDecoration(
                   gradient:LinearGradient(
                     colors:[
                          Color.fromRGBO(235, 132, 0, 0.9),
                           Color.fromRGBO(7, 14, 32, 0.9),
                                
                     ] 
                   ),
                ),
              ),
            ),
          
             drawer: Drawer(
                    
                   child:ListView(
                     padding: EdgeInsets.zero,
                     children: <Widget>[
                       DrawerHeader(
                         child:Text(""),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                  Color.fromRGBO(235, 132, 0, 0.9),
                                     Color.fromRGBO(7, 14, 32, 0.9),
                              ]
                              ),
                           image:DecorationImage(
                             image:AssetImage('assets/images/logo.png')
                             ),
                        ),
                       ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title:Text(username,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                       onTap:(){},

                      ),
                      ListTile(
                              leading: Icon(Icons.add),
                             title:Text("Job card",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                             onTap: (){
                                setState(() {
                                  jobCard=true;
                                });
                               Navigator.pop(context);
                             },
                      ),
                       ListTile(
                              leading: Icon(Icons.input),
                             title:Text("Log out",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                             onTap: (){
                                 _logout();
                              
                             },
                      )
                     ],
                   ),
  
           ),
           body:Padding(
             padding:EdgeInsets.all(30),
            child: ListView(
             children: <Widget>[
               
               SizedBox(height: 20,),
              jobCard?JobCard(userId: userId,):Text(""),
         
              
                
             ],
           ),
           ),
          
         floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
           child:Icon(Icons.menu),
           children: [
              SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
              label: 'Add Card',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                setState(() {
                  jobCard=true;
                });
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.delete),
              backgroundColor: Colors.blue,
              label: 'Delete',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
               setState(() {
                 jobCard=false;
               });
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.restore_page),
              backgroundColor: Colors.blue,
              label: 'Reset Page',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
               setState(() {
                 jobCard=false;
               });
              },
            ),
           ],
           ),  
    );
  }
  _logout ()async{
      
            await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (r)=>false);
 }
 }