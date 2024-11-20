import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {
  late String location; //location name for ui
  late String time; //time in that location
  late String flag; //url to asset flag icon
  late String url; //location url for api endpoint
  late bool isDaytime;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
          Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);
      //getting properties for data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //creating date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime = now.hour>6 && now.hour<19? true:false;
      time = DateFormat.jm().format(now); //setting time}
    }
    catch (e) {
      print('Caught error: $e');
      time='could not get time data';
    }
  }
}