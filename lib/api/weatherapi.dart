import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map> findWeather(String appID, String city) async {
  String urlAPI =
      'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appID&units=metric';
  http.Response response = await http.get(urlAPI);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("API Call Failed");
  }
}

Future<Map> findListToday(String appID, String city) async {
  String urlAPI =
      'http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$appID&units=metric';
  http.Response response = await http.get(urlAPI);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("API Call Failed");
  }
}
