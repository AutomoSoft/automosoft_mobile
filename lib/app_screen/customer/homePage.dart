
import 'package:automosoft_mobile/app_auth/loginPage.dart';
import 'package:automosoft_mobile/app_screen/customer/makeReservation.dart';
import 'package:flutter/material.dart';

class CustomerHome extends StatefulWidget {
  String userName;
  String userId;
  CustomerHome({Key key,this.userName,this.userId}) : super(key: key);

  @override
  _CustomerHomeState createState() => _CustomerHomeState(userName,userId);
}

class _CustomerHomeState extends State<CustomerHome> {
  String username;
  String userid;
  _CustomerHomeState(String userName,String userId){
    username=userName;
    userid=userId;

  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           appBar: AppBar(),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
             DrawerHeader(
               child:Text(""),
               decoration:BoxDecoration(
                 gradient: LinearGradient(
                   colors:[
                     Color.fromRGBO(235, 132, 0, 0.9),
                    Color.fromRGBO(7, 14, 32, 0.9),
                   ]
                   ),
                    image:DecorationImage(
                    image:AssetImage('assets/images/logo.png')
                   ),
               ) ,
               ),
                ListTile(
                      leading: Icon(Icons.person),
                      title:Text(username,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                       onTap:(){

                       },

                      ),
                      ListTile(
                      leading: Icon(Icons.add_box),
                      title:Text("Make Reservation",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                       onTap:(){
                         makeResrvation();
                       },

                      ),
                      // ListTile(
                      // leading: Icon(Icons.assessment),
                      // title:Text("Job History",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      //  onTap:(){},

                      // ),
                      // ListTile(
                      // leading: Icon(Icons.assignment),
                      // title:Text("My Services",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      //  onTap:(){},

                      // ),
                      // ListTile(
                      //         leading: Icon(Icons.input),
                      //        title:Text("Log out",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      //        onTap: (){
                      //            _logout();
                              
                      //        },
                      // )
          ],
        ),
      ),
      body: Container(
         color: Color.fromRGBO(7, 30, 32, 0.5),
         width: double.infinity,
         padding: EdgeInsets.all(50),
         child: ListView(
           children: <Widget>[
                Card(
               shadowColor:Color.fromRGBO(192, 192, 192, 0.5),
              margin: EdgeInsets.all(20),
              shape:RoundedRectangleBorder(
                 borderRadius:BorderRadius.circular(12)
              ), 
            color: Color.fromRGBO(7, 14, 32, 0.9),
        child:InkWell(
             splashColor: Colors.amber.withAlpha(50),
        onTap: () {
            makeResrvation();
        },
        child: Container(
             margin: EdgeInsets.all(20),
             decoration: BoxDecoration(
              border: Border.all(
                color:Color.fromRGBO(235, 132, 0, 1)
              ),
              borderRadius: BorderRadius.circular(12)
             ),
            width: 300,
            height: 100,
            child: ListTile(
                
               leading:Icon(Icons.add_box,color:Color.fromRGBO(235, 132, 0, 1),size:30),
               subtitle: Text("Make Reservation",style:TextStyle(color:Color.fromRGBO(235, 132, 0, 1),fontSize:20)),
            ),
        ),
      
        )
           ),
        //     Card(
        //        shadowColor:Color.fromRGBO(192, 192, 192, 0.5),
        //       margin: EdgeInsets.all(20),
        //       shape:RoundedRectangleBorder(
        //          borderRadius:BorderRadius.circular(12)
        //       ), 
        //     color: Color.fromRGBO(7, 14, 32, 0.9),
        // child:InkWell(
        //      splashColor: Colors.amber.withAlpha(50),
        // onTap: () {
        //     print('Card tapped.');
        // },
        // child: Container(
        //      margin: EdgeInsets.all(20),
        //      decoration: BoxDecoration(
        //       border: Border.all(
        //         color:Color.fromRGBO(235, 132, 0, 1)
        //       ),
        //       borderRadius: BorderRadius.circular(12)
        //      ),
        //     width: 300,
        //     height: 100,
        //     child: ListTile(
                
        //        leading:Icon(Icons.assessment,color:Color.fromRGBO(235, 132, 0, 1),size:30),
        //        subtitle: Text("Job History",style:TextStyle(color:Color.fromRGBO(235, 132, 0, 1),fontSize:20)),
        //     ),
        // ),
      
        // )
        //    ),
        //     Card(
        //        shadowColor:Color.fromRGBO(192, 192, 192, 0.5),
        //       margin: EdgeInsets.all(20),
        //       shape:RoundedRectangleBorder(
        //          borderRadius:BorderRadius.circular(12)
        //       ), 
        //     color: Color.fromRGBO(7, 14, 32, 0.9),
        // child:InkWell(
        //      splashColor: Colors.amber.withAlpha(50),
        // onTap: () {
        //     print('Card tapped.');
        // },
        // child: Container(
        //      margin: EdgeInsets.all(20),
        //      decoration: BoxDecoration(
        //       border: Border.all(
        //         color:Color.fromRGBO(235, 132, 0, 1)
        //       ),
        //       borderRadius: BorderRadius.circular(12)
        //      ),
        //     width: 300,
        //     height: 100,
        //     child: ListTile(
                
        //        leading:Icon(Icons.assignment,color:Color.fromRGBO(235, 132, 0, 1),size:30),
        //        subtitle: Text("My Services",style:TextStyle(color:Color.fromRGBO(235, 132, 0, 1),fontSize:20)),
        //     ),
        // ),
      
        // )
        //    ),
           ],
                 
         )
      ),
    );
  }
    _logout ()async{
      
            await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (r)=>false);
 }
 makeResrvation () async{
    await Navigator.push(context,MaterialPageRoute(builder: (context)=> MakeReservation() ),);
 }
}