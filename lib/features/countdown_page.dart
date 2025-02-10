import 'package:flutter/material.dart';
import 'package:flutter_samples/widgets/countdown_widget.dart';

class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CountdownWidget(
          duration: 7 * 24 * 60 * 60 * 1000,
          calculator: getFormattedTime,
          textStyle: const TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
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

    return '倒计时${daysStr}Days $hoursStr:$minutesStr:$secondsStr';
  }
}
