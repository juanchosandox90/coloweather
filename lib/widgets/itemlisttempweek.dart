import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:intl/intl.dart';

class ItemListTempWeek extends StatelessWidget {
  final String data;
  final String temp;
  final Color colText;
  final Color colContainer;
  final String animation;

  const ItemListTempWeek(
      {Key key,
      this.data,
      this.temp,
      this.colText,
      this.colContainer,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat formatDayName = DateFormat.E('es_ES');
    DateFormat formatDayMonth = DateFormat('dd/MM');
    DateTime receivedData = DateTime.parse(data);
    String formattedData = formatDayName.format(receivedData);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: colContainer,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: width * 0.2,
                padding: EdgeInsets.only(
                    left: width * 0.02,
                    right: width * 0.02,
                    top: width * 0.04,
                    bottom: width * 0.04),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue[900], Colors.purple]),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(25)),
                ),
                child: Center(
                  child: Text(
                    formattedData,
                    style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    child: FlareActor(
                      'assets/weather3.flr',
                      fit: BoxFit.contain,
                      animation: animation,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15, left: 10),
                    child: Text(
                      '${temp[0]}${temp[1].replaceAll(".", "")}°c',
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: colText,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: width * 0.015,
        )
      ],
    );
  }
}
