import 'package:circle_wave_progress/circle_wave_progress.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyStatelessApp());
}

class MyStatelessApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stateless Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StatelessWidgetDemo(),
    );
  }
}

class StatelessWidgetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.teal,
            body: Center(
                child: CircleWaveProgress(
              width: 300,
              height: 300,
              borderWidth: 10.0,
              backgroundColor: Colors.transparent,
              borderColor: Colors.white,
              waveColor: Colors.white54,
            ))));
  }
}
