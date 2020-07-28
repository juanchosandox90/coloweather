import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String latitude, longitude;

  const HomePage({Key key, this.latitude, this.longitude}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var formatData = DateFormat('YYYY, dd MMMM', 'pt_BR');
  DateTime actualDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Colo Weather',
          style: TextStyle(
              fontSize: width * 0.05, color: Colors.white.withOpacity(0.7)),
        ),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}
