import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String url;
  String time = '';
  String flag;
  bool isDayTime = false;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));

      Map data = jsonDecode(response.body);

      String dateTime = data['datetime'];

      String offset = data['utc_offset'];

      offset = offset.substring(1, 3);

      DateTime now = DateTime.parse(dateTime);

      now = now.add(
        Duration(
          hours: int.parse(offset),
        ),
      );

      isDayTime = now.hour > 6 && now.hour < 18 ? true : false;

      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Something went wrong $e');
      time = "Can't set the time";
    }
  }
}
