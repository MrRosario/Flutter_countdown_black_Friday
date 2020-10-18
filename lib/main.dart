import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(theme: ThemeData(fontFamily: 'Roboto'), home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int day = 0;
  int hour = 0;
  int min = 0;
  int sec = 0;

  void _updateDisplayTime() {
    setState(() {
      var currTime = DateTime.now().millisecondsSinceEpoch;
      var evtTime = DateTime(2020, 11, 27).millisecondsSinceEpoch;

      var remTime = evtTime - currTime;

      sec = (remTime / 1000).floor();
      min = (sec / 60).floor();
      hour = (min / 60).floor();
      day = (hour / 24).floor();

      hour %= 24;
      min %= 60;
      sec %= 60;
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (Timer time) => _updateDisplayTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
            child: Center(
          child: countDownCard(day, hour, min, sec),
        )));
  }
}

Widget countDownCard(day, hour, min, sec) {
  return Container(
      width: 330.0,
      height: 345.0,
      decoration: BoxDecoration(
          color: Colors.grey[900],
          border: Border.all(color: Colors.white, width: 2.0)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Black Friday".toUpperCase(),
              style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Contagem Regressiva".toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            timeContainer(day, hour, min, sec)
          ],
        ),
      ));
}

Widget timeContainer(day, hour, min, sec) {
  final Color redBg = Colors.red[800];
  final Color whiteBg = Colors.white12;

  return Container(
    width: double.infinity,
    color: Colors.grey[900],
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        timeItem(day, redBg, "Dias", 60.0, 60.0),
        timeItem(hour, whiteBg, "Horas", 50.0, 50.0),
        timeItem(min, whiteBg, "Min", 50.0, 50.0),
        timeItem(sec, whiteBg, "Seg", 50.0, 50.0),
      ],
    ),
  );
}

Widget timeItem(int timeTypeNum, Color itemColor, String timeType,
    double timeWidth, double timeHeight) {
  return Container(
    child: Column(
      children: [
        Container(
          width: timeWidth,
          height: timeHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: itemColor),
          child: Text(
            timeTypeNum < 10 ? '0$timeTypeNum' : '$timeTypeNum',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(timeType,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
