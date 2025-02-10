import 'dart:async';

import 'package:flutter/material.dart';

// define a Function
typedef CountdownCalculator = String Function(int remainingMilliseconds);

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
      {super.key,
      required this.duration,
      required this.textStyle,
      this.calculator});

  final int duration;
  final TextStyle textStyle;
  final CountdownCalculator? calculator;

  @override
  CountdownState createState() => CountdownState();
}

class CountdownState extends State<CountdownWidget> {
  late Timer _timer;
  late int _start = widget.duration;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start < 1000) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start -= 1000;
          });
        }
      },
    );
  }

  String getFormattedTime(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);

    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String daysStr = days.toString().padLeft(2, '0');
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return '${daysStr}D $hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.calculator != null
          ? widget.calculator!(_start)
          : getFormattedTime(_start),
      style: widget.textStyle,
    );
  }
}
