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
  var formatData = DateFormat('yyyy, dd MMMM', 'es_ES');//dd/MM/yyyy
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
                    left: width * 0.1, right: width * 0.1, top: width * 0.04),
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
                    Text ('          ${formatData.format(actualDate)}',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.orange[700]),
                    ),
                    SizedBox (
                      // TODO: Animated Icon to check weather status
                    )
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
