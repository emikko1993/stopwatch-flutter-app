import 'package:flutter/material.dart';

import 'stopwatch_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stopwatch',
      theme: ThemeData(
        fontFamily: 'Electrolize',
        primarySwatch: Colors.blue,
      ),
      home: const StopWatchView(),
    );
  }
}
