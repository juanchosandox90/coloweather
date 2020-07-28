import 'package:flutter/material.dart';
import 'package:coloweather/screens/homepage.dart';
import 'package:intl/date_symbol_data_local.dart';

main(List<String> args) {
  initializeDateFormatting('pt_BR', null).then((_) {
    runApp(MaterialApp(
      home: HomePage(),
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
    ));
  });
}
