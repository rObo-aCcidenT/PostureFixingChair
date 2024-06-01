import 'package:flutter/material.dart';
import 'package:splashh/utils/color.dart';
import 'package:splashh/components/start_button.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:splashh/services/database.dart';
import 'dart:async';
import 'package:splashh/components/timer_utils.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final DatabaseMethods database = DatabaseMethods(); 

  HomeScreen({Key? key, required this.username}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  bool isMonitoringStarted = false;
  late Timer _timer;
  late DateTime _startTime;
  late Duration _pausedDuration;
  late bool _isTimerRunning;


 @override
 bool get wantKeepAlive => true;
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

  void toggleMonitoring() {
    setState(() {
      isMonitoringStarted = !isMonitoringStarted;
    });

    if (isMonitoringStarted) {
      print("coll");
    // Start monitoring: Call both updateRadialData and readPostureData
      widget.database.updateRadialData();
      // widget.database.readPostureData();
  } else {
    // Stop monitoring (optional): You might want to add functionality to stop the periodic updates if needed
    // For example, you can cancel the timer if necessary
      widget.database.stopreadPostureData();
  }
  }
 void _updateTimer(Timer timer) {
    // Update the timer display or perform any other actions here
    // This function will be called every second while the timer is active
    // You can update the UI with the current time using the timer.tick property
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
  
  return Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false, // Disable the back button
      title: Text(
        'Home',
        style: TextStyle(
          backgroundColor: Colors.transparent,
          fontWeight: FontWeight.w400,
          fontSize: 22,
        ),
      ),
    ),
    
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 30.0),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // double screenWidth = constraints.maxWidth;
              double screenWidth = MediaQuery.of(context).size.width;
              double textFontSize = screenWidth * 0.05; // Adjust multiplier as needed
              double imageSize = screenWidth * 0.5; // Adjust multiplier as needed for image size

      // Limit the maximum font size to 40
      textFontSize = textFontSize > 40 ? 40 : textFontSize;
      imageSize = imageSize > 400 ? 400 : imageSize; 
              bool isWideScreen = screenWidth > 730;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 235, 242),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(4.0, 4.0),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: -10,
                          child: Image.asset(
                            'assets/images/hhe.png',
                            width: imageSize, // Fixed width
                            height: 400, // Fixed height
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          left: 20.0,
                          bottom: 20.0,
                          child: Text(
                            'Hi ${widget.username}!',
                            style: TextStyle(
                              fontSize: textFontSize, // Fixed font size
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  isWideScreen
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 232, 235, 242),
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Text(
                                      'Click the start button to begin monitoring and remember to sit up straight!\n\n'
                                      'Feel free to minimize this window once monitoring has started. Just come back to the window when you need to pause the monitoring.\n\n',
                                   
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 30.0),
                            Expanded(
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 232, 235, 242),
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Start Monitoring', // Title
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'When start clicked, timer starts and resets on next day', // Subtitle
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.timer, size: 24.0),
                                          SizedBox(width: 12.0),
                                          // 
                                          // TimerWidget
                                          // TimerWidget(isMonitoringStarted: isMonitoringStarted,toggleMonitoring: toggleMonitoring,),                                        SizedBox(width: 30.0),
                                          Text(
          _formatDuration(
              DateTime.now().difference(_startTime) + _pausedDuration),
              // DateTime.now().difference(_startTime) ),
          style: TextStyle(fontSize: 16.0),
        ),
                                                  SizedBox(width: 12.0),
                                          StartButton(
                                            onPressed: (){if(isMonitoringStarted){stopTimer();}else{resetTimer();resumeTimer();}toggleMonitoring();},
                                            isMonitoringStarted: isMonitoringStarted,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 235, 242),
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: Text(
                                    'Click the start button to begin monitoring and remember to sit up straight!\n\n'
                                    'Feel free to minimize this window once monitoring has started. Just come back to the window when you need to pause the monitoring.\n\n',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400,color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 235, 242),
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(4.0, 4.0),
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child:Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Column(
                                    
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Start Monitoring', // Title
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'When start clicked, timer starts and resets on next day', // Subtitle
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.timer, size: 24.0),
                                          SizedBox(width: 12.0),
                                          // 
                                          // TimerWidget
                                          // TimerWidget(isMonitoringStarted: isMonitoringStarted,toggleMonitoring: toggleMonitoring,),                                        SizedBox(width: 30.0),
                                          Text(
          _formatDuration(
              DateTime.now().difference(_startTime) + _pausedDuration),
              // DateTime.now().difference(_startTime) ),
          style: TextStyle(fontSize: 16.0),
        ),
                                                  SizedBox(width: 12.0),
                                          StartButton(
                                            onPressed: (){if(isMonitoringStarted){stopTimer();}else{resetTimer();resumeTimer();}toggleMonitoring();},
                                            isMonitoringStarted: isMonitoringStarted,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              );
            },
          ),
        ),
      ),
    ),
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