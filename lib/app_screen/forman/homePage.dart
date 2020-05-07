

import 'package:automosoft_mobile/app_auth/loginPage.dart';
import 'package:automosoft_mobile/app_screen/forman/jobCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';



class HomePage extends StatefulWidget {
  String userName;
 
  HomePage({Key key,this.userName}) : super(key: key);

 



  @override
  _HomePageState createState() => _HomePageState(userName);
}

class _HomePageState extends State<HomePage> {
  String username;
   static bool  jobCard=false;
  _HomePageState(String userName){
     username=userName;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
           
              title: Container(
                decoration: BoxDecoration(
                   gradient:LinearGradient(
                     colors:[
                                Color.fromRGBO(11, 29, 71, 0.9),
                                 Color.fromRGBO(194, 132, 0, 0.9),
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
                                 Color.fromRGBO(11, 29, 71, 0.9),
                                 Color.fromRGBO(194, 132, 0, 0.9),
                              ]
                              ),
                           image:DecorationImage(
                             image:AssetImage('assets/images/logo.png')
                             ),
                        ),
                       ),
                    ListTile(
                      leading: Icon(Icons.person),
                      title:Text(username),
                      

                      ),
                      ListTile(
                              leading: Icon(Icons.add),
                             title:Text("Add Job card"),
                             onTap: (){
                                setState(() {
                                  jobCard=true;
                                });
                               Navigator.pop(context);
                             },
                      ),
                       ListTile(
                              leading: Icon(Icons.input),
                             title:Text("Log out"),
                             onTap: (){
                                 logout();
                               Navigator.pop(context);
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
              jobCard?JobCard():Text(""),
         
              
                
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
  Future<void> logout ()async{
      
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (c) => LoginPage()),
                    (r) => false);
  }
 }