import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> history = ModalRoute.of(context)?.settings.arguments as List<String>? ?? [];
    return Scaffold(
      appBar: AppBar(title: Text('Conversion History')),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(history[index]));
        },
      ),
    );
  }
}
