import 'package:flutter/material.dart';
import 'dart:async';

import 'package:splashh/components/start_button.dart';

class TimerWidget extends StatefulWidget {
  final bool isMonitoringStarted;
  final Function toggleMonitoring;

  const TimerWidget({Key? key, required this.isMonitoringStarted,required this.toggleMonitoring})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  late DateTime _startTime;
  late Duration _pausedDuration;
  late bool _isTimerRunning;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    _pausedDuration = Duration.zero;
    _isTimerRunning = false;
    // isMonitoringStarted1 = widget.isMonitoringStarted;

    // Start the timer if monitoring is already started
    // if (widget.isMonitoringStarted) {
    //   startTimer();
    // }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    if (_isTimerRunning) return;

    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _isTimerRunning = true;
      });
    });
  }

  void stopTimer() {
    if (!_isTimerRunning) return;

    _timer.cancel();
    _pausedDuration = DateTime.now().difference(_startTime);
    _isTimerRunning = false;
  }

  void resumeTimer() {
    if (_isTimerRunning) return;

    _startTime = DateTime.now().subtract(_pausedDuration);
    startTimer();
  }

  void resetTimer() {
    _startTime = DateTime.now();
    _pausedDuration = Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    print("dfd");
    return SizedBox(
      width: 100,
      height: 100,
      child:
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.timer, size: 24.0),
        SizedBox(width: 8.0),
        Text(
          DateTime.now().millisecondsSinceEpoch.toString(),
          // _formatDuration(
          //     // DateTime.now().difference(_startTime) + _pausedDuration),
          //     DateTime.now().difference(_startTime) ),
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(width: 10.0),
        // TextButton(
        //   onPressed: widget.isMonitoringStarted ? stopTimer : startTimer,
        //   child: Text(widget.isMonitoringStarted ? 'Stop' : 'Start'),
        // ),
        StartButton(
          onPressed: widget.toggleMonitoring(),
          isMonitoringStarted: !widget.isMonitoringStarted,
        ),
      ],
    )
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
  }
}
