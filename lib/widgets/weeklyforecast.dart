import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:coloweather/util/utils.dart' as util;
import 'package:coloweather/api/weatherapi.dart';
import 'package:coloweather/widgets/itemlisttempweek.dart';

class WeeklyForecast extends StatelessWidget {
  final String city;
  final Color colTextList, colContainerItemList;

  WeeklyForecast(
      {Key key, this.city, this.colTextList, this.colContainerItemList})
      : super(key: key);

  String yearMonth;

  var formatYearMonth = DateFormat("yyyy-MM-");
  var formatYearMonthDay = DateFormat("yyyy-MM-dd");
  DateTime dateActual = DateTime.now();

  @override
  Widget build(BuildContext context) {
    yearMonth = formatYearMonth.format(dateActual);

    return FutureBuilder(
        future: findListToday(
            util.appID, city == null ? util.defaultCity : city),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map conteudo = snapshot.data;
            List conteudolist = conteudo['list'];

            double somaTemperaturas = 0;
            int qntdForPercorrido = 0;
            List listDias = [];
            List listDiasUnicos = [];
            List listTemp = [];
            List listTempDIA = [];
            List listMapDataTemp = [];
            List iconList = [];

            conteudolist.forEach((f) {
              if (f.toString().contains("$yearMonth")) {
                listDias
                    .add(formatYearMonthDay.format(DateTime.parse(f['dt_txt'])));
              }
            });

            listDiasUnicos = listDias.toSet().toList();

            for (int i = 0; i < listDiasUnicos.length; i++) {
              conteudolist.forEach((f) {
                String dataListaUnica;
                dataListaUnica = listDiasUnicos[i];

                if (f.toString().contains('$dataListaUnica')) {
                  somaTemperaturas = somaTemperaturas +
                      double.parse(
                          f['main']['temp'].toString().replaceAll(',', '.'));
                  if (f.toString().contains('$dataListaUnica 15:00:00')) {
                    iconList.add({
                      'data': '$dataListaUnica 15:00:00',
                      'icon': f['weather'][0]['icon'].toString()
                    });
                  }
                  qntdForPercorrido++;
                }
              });

              listTemp.add(somaTemperaturas);

              listTempDIA.add((somaTemperaturas / qntdForPercorrido).round());
              listMapDataTemp.add({
                'data': listDiasUnicos[i],
                'temp_media':
                (somaTemperaturas / qntdForPercorrido).toStringAsFixed(2)
              });

              somaTemperaturas = 0;
              qntdForPercorrido = 0;
            }

            if (listMapDataTemp[0]
                .toString()
                .contains(formatYearMonthDay.format(dateActual))) {
              listMapDataTemp.removeAt(0);
            }
            if(listMapDataTemp.length >5){
              listMapDataTemp.removeLast();
            }

            if (iconList.length < 5) {
              iconList.add({'icon': '03d'});
            }

            return Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: listMapDataTemp.length,
                itemBuilder: (context, index) {
                  return ItemListTempWeek(
                    data: listMapDataTemp[index]['data'].toString(),
                    temp: listMapDataTemp[index]['temp_media'].toString(),
                    colText: colTextList,
                    colContainer: colContainerItemList,
                    animation: iconList[index]['icon'],
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
