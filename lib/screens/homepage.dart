import 'package:flare_flutter/flare_actor.dart';
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
  TextEditingController _controllerCity = TextEditingController();
  var formatData = DateFormat('yyyy, dd MMMM', 'es_ES'); //dd/MM/yyyy
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
    double height = MediaQuery.of(context).size.height;
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
        actions: [
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.1, right: width * 0.1, top: width * 0.1),
                //TODO: Validation of the json to search city. In future builder
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              visibleCity = false;
                            });
                          },
                          child: Icon(
                            Icons.location_on,
                            size: width * 0.08,
                            color: valueSwitch == false
                                ? Colors.grey[700]
                                : Colors.orange[600],
                          ),
                        ),
                        Visibility(
                          visible: visibleCity,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                visibleCity = false;
                              });
                            },
                            // TODO: Text will be compare with the JSON
                            child: Text('Searching',
                                style: TextStyle(
                                    fontSize: width * 0.09,
                                    fontWeight: FontWeight.bold,
                                    color: colText)),
                          ),
                        ),
                        Visibility(
                            visible: !visibleCity,
                            child: Expanded(
                                child: TextField(
                              autofocus: true,
                              style: TextStyle(color: colText),
                              controller: _controllerCity,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onSubmitted: (_) {
                                setState(() {
                                  if (_controllerCity.text == null ||
                                      _controllerCity.text.isEmpty) {
                                  } else {
                                    _informedCity = _controllerCity.text;
                                  }
                                  visibleCity = true;
                                });
                              },
                            ))),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.009,
                    ),
                    Text(
                      '          ${formatData.format(actualDate)}',
                      style: TextStyle(
                          fontSize: width * 0.04, color: Colors.orange[700]),
                    ),
                    SizedBox(
                      height: width * 0.01,
                    ),
                    Container(
                      height: height * 0.25,
                      width: width,
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              right: -20,
                              child: Container(
                                height: height * 0.22,
                                width: width * 0.55,
                                child: FlareActor(
                                  'assets/weather3.flr',
                                  fit: BoxFit.contain,
                                  //TODO: will hanlde the animation from the JSON
                                  //animation: '3',
                                ),
                              )),
                          Positioned(
                            top: 10,
                            left: 0,
                            child: Text(
                              //TODO: Will get the temp from the JSON
                              '20°',
                              style: TextStyle(
                                  fontSize: width * 0.29,
                                  fontWeight: FontWeight.w600,
                                  color: colText),
                            ),
                          ),
                          Positioned(
                            top: width * 0.33,
                            left: 5,
                            child: Row(
                              children: [
                                Text(
                                  //TODO: Will get min the temp from the JSON
                                  'Min: 10°',
                                  style: TextStyle(
                                      fontSize: width * 0.038,
                                      fontWeight: FontWeight.w300,
                                      color: colText),
                                ),
                                Text(
                                  //TODO: Will get the max temp from the JSON
                                  ' / Max: 20°',
                                  style: TextStyle(
                                      fontSize: width * 0.038,
                                      fontWeight: FontWeight.w300,
                                      color: colText),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: width * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    visibleDetails = true;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  padding: visibleDetails == true
                                      ? EdgeInsets.all(0)
                                      : EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          top: 10,
                                          bottom: 10),
                                  decoration: BoxDecoration(
                                      border: visibleDetails == true
                                          ? null
                                          : Border.all(
                                              color: Colors.orange[600],
                                              width: 1.2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Text(
                                      'Detalles',
                                      style: TextStyle(
                                          fontSize: visibleDetails == true
                                              ? width * 0.05
                                              : width * 0.05,
                                          color: colText,
                                          fontWeight: visibleDetails == true
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    visibleDetails = false;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  padding: visibleDetails == false
                                      ? EdgeInsets.all(0)
                                      : EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          top: 10,
                                          bottom: 10),
                                  decoration: BoxDecoration(
                                      border: visibleDetails == false
                                          ? null
                                          : Border.all(
                                              color: Colors.orange[600],
                                              width: 1.2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Text(
                                      'Previsión',
                                      style: TextStyle(
                                          fontSize: visibleDetails == false
                                              ? width * 0.05
                                              : width * 0.05,
                                          color: colText,
                                          fontWeight: visibleDetails == false
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
