import 'package:flutter/material.dart';
import 'dart:async';

import 'package:worldtimeapp/services/WorldTime.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  Map data = {};
  late Timer timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    startTimer();
    // Initial fetch of time
    fetchData();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) {
      // Code to be executed every 30 seconds
      fetchData();
    });
  }

  Future<void> fetchData() async {
    if (data != null && data['location'] != null && data['flag'] != null && data['url'] != null) {
      WorldTime worldTime = WorldTime(location: data['location'], flag: data['flag'], url: data['url']);
      await worldTime.getTime();
      setState(() {
        data['time'] = worldTime.time;
      });
    }
  }


  @override
  void dispose() {
    // Cancel the timer when the widget is disposed to avoid memory leaks
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    data=data.isNotEmpty?data:ModalRoute.of(context)!.settings.arguments as Map;
    //setTING background
    String bgImage=data['isDaytime']?'day.jpg':'night.jpg';
    return Scaffold(
      backgroundColor: bgImage=='day.jpg'?Color.fromRGBO(98, 178, 189, 20):Color.fromRGBO(20, 48, 62, 20),
      body: SafeArea(
          child:Container(
            decoration: BoxDecoration(
              image:DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 20, 0),
              child: Column(
                children: [
                  TextButton.icon(
                      onPressed: () async{
                        dynamic result=await Navigator.pushNamed(context,'/location');
                        setState(() {
                          data={
                            'time':result['time'],
                            'location':result['location'],
                            'flag':result['flag'],
                            'isDaytime':result['isDaytime'],
                            'url':result['url'],
                          };
                        });

                      },
                      icon: Icon(
                        Icons.edit_location,
                        size: 30,
                        color: Colors.blueAccent,



                      ),
                      label: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                        child: Text("Edit Location",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),

                        ),
                      )

                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontFamily: 'JosefinSans-Regular',
                          letterSpacing: 2,

                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 140,),
                  Text(data['time'],
                  style: TextStyle(
                    fontSize:80,
                    fontFamily: 'digital-7',
                    color: Colors.white
                  ),
                  )

                ],

                    ),
            ),
          )),
    );
  }
}
