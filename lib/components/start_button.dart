import 'package:flutter/material.dart';
import 'package:splashh/utils/color.dart';
import 'package:http/http.dart' as http;

class StartButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isMonitoringStarted;

  const StartButton({Key? key, required this.onPressed, required this.isMonitoringStarted}) : super(key: key);

  @override
Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Send GET request to start monitoring
        sendStartMonitoringRequest();
        // Call onPressed function to toggle monitoring state
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isMonitoringStarted ? Colors.red : AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 4.0,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
      ),
      child: Text(
        isMonitoringStarted ? 'Stop' : 'Start',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }

    Future<void> sendStartMonitoringRequest() async {
    try {
      // Replace 'your-server-url' with the actual URL of your server
      final response = await http.get(Uri.parse('http://192.168.169.49:5000/startMonitoring'));
      if (response.statusCode == 200) {
        print('Monitoring started');
      } else {
        print('Failed to start monitoring: ${response.statusCode}');
      }
    } catch (e) {
      print('Error starting monitoring: $e');
    }
  }
}

