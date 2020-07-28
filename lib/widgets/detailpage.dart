import 'package:flutter/material.dart';
import 'package:coloweather/api/weatherapi.dart';
import 'package:coloweather/util/utils.dart' as util;

class DetailPage extends StatelessWidget {
  final String city;
  final Color colHumidity,
      colText,
      colVisibility,
      colWind,
      colPressure,
      colClouds;

  const DetailPage(
      {Key key,
      this.city,
      this.colHumidity,
      this.colText,
      this.colVisibility,
      this.colWind,
      this.colPressure,
      this.colClouds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: findWeather(util.appID, city == null ? util.defaultCity : city),
      builder: (context, snapshot) {
        Map weatherJson = snapshot.data;
        if (snapshot.hasData) {
          return ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colHumidity,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * 0.022),
                      decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Icon(Icons.invert_colors,
                            color: Colors.blue[800], size: width * 0.08),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Humedad: ${weatherJson['main']['humidity']}%',
                        style:
                            TextStyle(fontSize: width * 0.04, color: colText),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colVisibility,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * 0.022),
                      decoration: BoxDecoration(
                          color: Colors.orange[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Icon(Icons.wb_sunny,
                            color: Colors.orange[800], size: width * 0.08),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Visibilidad: ${weatherJson['visibility']} m',
                        style:
                        TextStyle(fontSize: width * 0.04, color: colText),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colWind,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * 0.022),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Icon(Icons.gesture,
                            color: Colors.grey[800], size: width * 0.08),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Vientos: ${weatherJson['wind']['speed']} km/h',
                        style:
                        TextStyle(fontSize: width * 0.04, color: colText),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colPressure,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * 0.022),
                      decoration: BoxDecoration(
                          color: Colors.green[300],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Icon(Icons.tonality,
                            color: Colors.green[800], size: width * 0.08),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Presion: ${weatherJson['main']['pressure']} hPa',
                        style:
                        TextStyle(fontSize: width * 0.04, color: colText),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              Container(
                decoration: BoxDecoration(
                    color: colClouds,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(width * 0.022),
                      decoration: BoxDecoration(
                          color: Colors.indigo[200],
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Icon(Icons.filter_drama,
                            color: Colors.indigo[800], size: width * 0.08),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Nubes : ${weatherJson['clouds']['all']}%',
                        style:
                        TextStyle(fontSize: width * 0.04, color: colText),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
