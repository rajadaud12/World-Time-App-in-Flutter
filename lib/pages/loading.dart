import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/WorldTime.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async{
    WorldTime worldTime =WorldTime(location: 'Berlin', flag:'germany.png', url: 'Europe/Berlin');
    await worldTime.getTime();
    Navigator.pushReplacementNamed(context, '/home',arguments: {
      'location':worldTime.location, 'flag':worldTime.flag ,'time':worldTime.time,'isDaytime':worldTime.isDaytime,
      'url':worldTime.url,
    });

  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueAccent,
      body:Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 80.0,
          ),
      )
    );
  }
}
