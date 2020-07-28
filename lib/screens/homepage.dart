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
  String _informedCity;
  var formatData = DateFormat('YYYY, dd MMMM', 'pt_BR');
  DateTime actualDate = DateTime.now();
  Color colHumidity, colVisibility, colWind, colPressure, colClouds;
  Color colText, colBackground, colTextList, colContainerItemList;
  bool valueSwitch = false;
  bool visibleCity;
  bool visibleDetails;

  setColors() {
    if (valueSwitch == false) {
      colHumidity = Colors.blue[300];
      colVisibility = Colors.orange[300];
      colWind = Colors.grey[300];
      colPressure = Colors.green[300];
      colClouds = Colors.indigo[300];
      colText = Colors.grey[800];
      colBackground = Colors.white;
      colTextList = Colors.grey[800];
      colContainerItemList = Colors.grey[100];
    } else {
      colHumidity = Colors.grey[700];
      colVisibility = Colors.grey[700];
      colWind = Colors.grey[700];
      colPressure = Colors.grey[700];
      colClouds = Colors.grey[700];
      colText = Colors.white;
      colBackground = Colors.grey[900];
      colTextList = Colors.orange[800];
      colContainerItemList = Colors.grey[700];
    }
  }

  @override
  void initState() {
    setColors();
    visibleCity = true;
    visibleDetails = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Colo Weather',
          style: TextStyle(
              fontSize: width * 0.05, color: colText.withOpacity(0.7)),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          Switch(
              value: valueSwitch,
              onChanged: (value) {
                setState(() {
                  valueSwitch = value;
                  setColors();
                });
              })
        ],
      ),
    );
  }
}
