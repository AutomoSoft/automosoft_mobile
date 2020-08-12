
import 'dart:convert';

import 'package:automosoft_mobile/models/requestDateAndTime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';

import '../../constant.dart';
class AvailableDateAndTime extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AvailableDateAndTime();
  }
}

class _AvailableDateAndTime extends State<AvailableDateAndTime> {

  List<EventDate> eventModel=[];
   Map<DateTime, List> event={};
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = event[_selectedDay] ?? [];
    });
    //print(_selectedEvents);
  }
   Future <void> getRequestDate() async{
   
    await http.get("http://${Ip.ip}:3000/reservations/viewAllReservations")
    .then((res) {
      var userData =json.decode(res.body);
     // print(userData['data'][0]['daterequested']);
       setState(() {
          for(Map i in userData['data']){
           // print(i);
            eventModel.add(EventDate.fromJson(i));
          }
       });
       print('ffffff');
    //  print(eventModel[0].date);
      // var event=Map.fromIterable(eventModel,key:(e)=>e.date,value:(e)=>[e.time]);
      // print(event);
       for(var i =0; i<eventModel.length; i++){
         //print(eventModel[i].date);
        //  print(eventModel[i].date.substring(0,3));//day
        //  print(eventModel[i].date.substring(4,7));//month
        //  print(eventModel[i].date.substring(8,10));//day int
        //  print(eventModel[i].date.substring(11,15));//year
         switch (eventModel[i].date.substring(4,7)) {
           case 'Jan':
                eventModel[i].date="${eventModel[i].date.substring(11,15)}, 01, ${eventModel[i].date.substring(8,10)}";
             
             break;
             case 'Feb':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 02, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Mar':
                eventModel[i].date="${eventModel[i].date.substring(11,15)}, 03, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Apr':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 04, ${eventModel[i].date.substring(8,10)}";
             
             break; 
              case 'May':
                  eventModel[i].date="${eventModel[i].date.substring(11,15)}, 05, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Jun':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 06, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Jul':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 07, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Aug':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 08, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Sep':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 09, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Oct':
                 eventModel[i].date="${eventModel[i].date.substring(11,15)}, 10, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Nov':
                  eventModel[i].date="${eventModel[i].date.substring(11,15)}, 11, ${eventModel[i].date.substring(8,10)}";
             
             break;
              case 'Dec':
                eventModel[i].date="${eventModel[i].date.substring(11,15)}, 12, ${eventModel[i].date.substring(8,10)}";
             
             break;
           default:
         }
       }
       DateFormat dateFormat = DateFormat("yyyy, MM, dd");
      for(var i =0; i<eventModel.length; i++){
        print(dateFormat.parse(eventModel[i].date));
        
        print(DateTime.now());
      }
      event=Map.fromIterable(eventModel, key:(e)=> dateFormat.parse(e.date),value:(e)=>[{"name":"Not Available ${e.time}","isDone":false}]);
     
  
    //   print("____________________________________________________");
    //  // print(event);
    //  // print(DateFor)
    }
           
    )
    .catchError((onError)=>
      print(onError)
    );
   }

  List _selectedEvents;
  DateTime _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedEvents = event[_selectedDay] ?? [];
    getRequestDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Available Date and Time")),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Calendar(
                bottomBarColor: Colors.amber,
                startOnMonday: true,
                weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                events: event,
                onRangeSelected: (range) =>
                    print("Range is ${range.from}, ${range.to}"),
                onDateSelected: (date) => _handleNewDate(date),
                isExpandable: true,
                selectedColor: Colors.black,
                todayColor: Colors.pink,
                eventColor: Colors.red,
                dayOfWeekStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 15),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(_selectedEvents[index]['name'].toString(),style: TextStyle(color:Colors.red,decorationColor:Colors.amber),),
            onTap: () {},
          ),
        ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}
 