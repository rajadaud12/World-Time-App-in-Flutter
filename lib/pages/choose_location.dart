import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/WorldTime.dart';
class ChooseLocation extends StatefulWidget {

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];
  void updateTime(index) async{
    WorldTime worldTime=locations[index];
    await worldTime.getTime();
    Navigator.pop(context,{
      'location':worldTime.location, 'flag':worldTime.flag ,'time':worldTime.time,'isDaytime':worldTime.isDaytime,
      'url':worldTime.url,
    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.blueAccent,
        title: Text("Choose a Location",
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'OpenSans-Bold'
        )
          ,),
        centerTitle: true,
        elevation: 0,
      ),

      body:ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 1.0 ),
            child: Card(
              child:ListTile(
                tileColor: Colors.grey[300],
                selectedColor: Colors.blueAccent,
                onTap:(){
                  updateTime(index);
                } ,
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
                title:Text(
                    locations[index].location,
                  style: TextStyle(
                    fontFamily: 'JosefinSans-Regular',
                    fontSize: 18,
                  ),
                ),
              )
            ),
          );
        },
      )


    );
  }
}
