import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Position _position;
  StreamSubscription<Position> _positionStream;
  String latitude, longitude;

  @override
  void initState() {
    super.initState();
    var locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    _positionStream = Geolocator()
        .getPositionStream(locationOptions)
        .listen((Position position) {
      _position = position;
      latitude = position == null ? "Unknow" : position.latitude.toString();
      longitude = position == null ? "Unknow" : position.longitude.toString();
      print(latitude + ', ' + longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Colo Weather",
          style: TextStyle(
              fontSize: width * 0.05, color: Colors.white.withOpacity(0.7)),
        ),
      ),
      body: Center(
        child: Text(
          "Color Weather !",
          style: TextStyle(fontSize: 50, color: Colors.blue),
        ),
      ),
    );
  }
}
