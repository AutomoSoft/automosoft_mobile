
import 'package:flutter/material.dart';

class ListTileCard extends StatelessWidget {
  final String value,type;
  const ListTileCard({Key key,this.value,this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(padding:EdgeInsets.all(10),
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: <Widget>[
                         Text("$type :",style:TextStyle(fontWeight:FontWeight.bold,color:Colors.black,fontSize:20)),
                         Text(value,style:TextStyle(color:Colors.black,fontSize:15)),
                       ],
                     ),
                     );
                
  }
}