import 'package:flutter/material.dart';
import 'home.dart';
import 'history.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/history': (context) => HistoryScreen(),
      },
    );
  }
}
