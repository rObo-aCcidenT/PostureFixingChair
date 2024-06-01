import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:splashh/components/notification/web_notification.dart';
import 'package:splashh/components/notification/android_notification.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class PostureInfo {
  final String score;
  final String subSentence;
  final String tip;

  PostureInfo(this.score, this.subSentence, this.tip);
}

class DatabaseMethods {
  // Declare class-level variables for cumulative counts
  int cumulativeGoodPostureCount = 0;
  int cumulativeBadPostureCount = 0;
  double goodPosturePercentage = 0.0;
  double badPosturePercentage = 0.0;
  late Timer _updateTimer;
  late Timer _updateTimer2;
  bool _isMonitoringActive = false; // Flag to track monitoring state

  void updateRadialData() {
    _isMonitoringActive = !_isMonitoringActive;
    readPostureData();
    // Set up a timer to periodically update the posture data
      print(_isMonitoringActive);
    _updateTimer = Timer.periodic(Duration(seconds: 30), (Timer timer) {
      print(_isMonitoringActive);
      if (_isMonitoringActive) {
        readPostureData();
        print('called timer'); // Only call readPostureData if monitoring is active
      }
      // readPostureData();
    });
  }

  // Define the function calculatePercentages before it's referenced
  void calculatePercentages() {
    int totalReadings = cumulativeGoodPostureCount + cumulativeBadPostureCount;
    if (totalReadings > 0) {
      goodPosturePercentage = (cumulativeGoodPostureCount / totalReadings) * 100;
      badPosturePercentage = (cumulativeBadPostureCount / totalReadings) * 100;
    } else {
      // Reset percentages if no readings available
      goodPosturePercentage = 0.0;
      badPosturePercentage = 0.0;
    }

    print('good: $goodPosturePercentage');
    print('bad: $badPosturePercentage');
  }

  PostureInfo calculatePostureInfo(double goodPosturePercentage) {
    if (goodPosturePercentage >= 90) {
      return PostureInfo('Excellent', 'You have an excellent posture!', 'Keep up the good work!');
    } else if (goodPosturePercentage >= 80) {
      return PostureInfo('Good', 'Your posture is good!', 'Maintain it for better health.');
    } else if (goodPosturePercentage >= 70) {
      return PostureInfo('Fair', 'Your posture is fair.', 'Focus on improving your posture.');
    } else {
      return PostureInfo('Poor', 'Your posture needs improvement.', 'Try adjusting your sitting position.');
    }
  }

  //method to send notifications when bad posture repeat found
  void sendNotification(String posture) {
    String notificationMessage;

    // Define notification message based on the posture type
    switch (posture) {
      case 'Backward Slouch':
        notificationMessage = 'You are slouching backward! Please correct your posture.';
        break;
      case 'Right Lean':
        notificationMessage = 'You are leaning to the right! Please correct your posture.';
        break;
      case 'Left Lean':
        notificationMessage = 'You are leaning to the left! Please correct your posture.';
        break;
      case 'Forward Lean':
        notificationMessage = 'You are leaning forward too much! Please correct your posture.';
        break;
      default:
        notificationMessage = 'Unknown posture detected!';
    }
    // Print the notification message for testing
    print('Sending notification for repeated posture: $posture');
    print('Notification Message: $notificationMessage');
    // Call the appropriate method to send notification based on the current platform
    // You can call your platform-specific notification sending method here
    // For example:
    sendPlatformNotification(notificationMessage);
  }

  void sendPlatformNotification(String message) {
    if (kIsWeb) {
    WebNotificationHandler.showWebNotification(message);
  } else {
    AndroidNotificationHandler.showAndroidNotification('PostFix Alert',message);
  }
    // Implement platform-specific notification sending logic here
    // For example, use FCM for mobile platforms and web notifications for web platforms
    // You need to implement this method according to the notification service or API you're using
  }

  // Method to read posture data from Realtime Database
  Future<void> readPostureData() async {
    // Assuming your posture data is stored under a node named 'posture_data'
    DatabaseReference postureRef = FirebaseDatabase.instance.ref().child('posture_data');
    // Map<String, int> postureCount = {};
    String? lastDetectedPosture; // Variable to store the last detected posture
    int consecutiveCount = 0; 
_updateTimer2 = Timer.periodic(Duration(seconds: 1), (Timer timer) async{// Variable to track consecutive occurrences of a posture
    DataSnapshot snap = await postureRef.limitToLast(1).get();
    // print(DateTime.now().millisecondsSinceEpoch);
    Map<dynamic, dynamic>? data = snap.value as Map<dynamic, dynamic>?;
    Map<dynamic,dynamic>? value = data![data!.keys.first as String];
          if (value != null && value['predicted_posture'] != null) {
            // Access the value associated with the key '0' under 'predicted_posture'
            String? predictedPosture = value['predicted_posture'][0];

            // counting bad posture repetitin
            if (predictedPosture != null && predictedPosture != 'Ideal Position' && predictedPosture != 'Empty Chair') {
              // Check if the detected posture is the same as the last detected posture
              if (predictedPosture == lastDetectedPosture) {
                print(consecutiveCount);
                consecutiveCount++; // Increment consecutive count
              } else {
                consecutiveCount = 1; // Reset consecutive count if the posture changes
              }

              lastDetectedPosture = predictedPosture; // Update last detected posture

              // Check if the consecutive count for the posture reaches the threshold (10 times)
              if (consecutiveCount == 30) {

                // Trigger notification for the repeated posture
                sendNotification(predictedPosture);
                consecutiveCount =0;
                print('notification fn called');
                _updateTimer2.cancel();
              }
            }

            if (predictedPosture != null) {
              // Use the predicted posture value here as needed
              print('Predicted Posture: $predictedPosture');
            }

            if (predictedPosture == 'Ideal Position') {
              cumulativeGoodPostureCount++;
            } else if (predictedPosture != 'Empty Chair') {
              cumulativeBadPostureCount++;
            }
          }
});
    // });
    // postureRef.onValue.listen((event) {
    //   print(DateTime.now().millisecondsSinceEpoch);
    //   // Use event.snapshot.value to access the entire data under posture_data
    //   Map<dynamic, dynamic>? data = event.snapshot.value as Map<dynamic, dynamic>?;
    //   Map<dynamic, dynamic>? data = event.snapshot.value as Map<dynamic, dynamic>?;
    //   print(1);
    //   // Update cumulative counts with new data
    //   // if (data != null) {
    //   //   data.forEach((key, value) {
    //   //     // String? predictedPosture = value['predicted_posture'];

    //   //     if (value != null && value['predicted_posture'] != null) {
    //   //       // Access the value associated with the key '0' under 'predicted_posture'
    //   //       String? predictedPosture = value['predicted_posture'][0];

    //   //       // counting bad posture repetitin
    //   //       if (predictedPosture != null && predictedPosture != 'Ideal Position' && predictedPosture != 'Empty Chair') {
    //   //         // Check if the detected posture is the same as the last detected posture
    //   //         if (predictedPosture == lastDetectedPosture) {
    //   //           consecutiveCount++; // Increment consecutive count
    //   //         } else {
    //   //           consecutiveCount = 1; // Reset consecutive count if the posture changes
    //   //         }

    //   //         lastDetectedPosture = predictedPosture; // Update last detected posture

    //   //         // Check if the consecutive count for the posture reaches the threshold (10 times)
    //   //         if (consecutiveCount == 30) {

    //   //           // Trigger notification for the repeated posture
    //   //           // sendNotification(predictedPosture);
    //   //           consecutiveCount =0;

    //   //           // print('notification fn called');
    //   //         }
    //   //       }

    //   //       if (predictedPosture != null) {
    //   //         // Use the predicted posture value here as needed
    //   //         // print('Predicted Posture: $predictedPosture');
    //   //       }

    //   //       if (predictedPosture == 'Ideal Position') {
    //   //         cumulativeGoodPostureCount++;
    //   //       } else if (predictedPosture != 'Empty Chair') {
    //   //         cumulativeBadPostureCount++;
    //   //       }
    //   //     }
    //   //   });

    //   //   // Calculate percentages using cumulative counts
    //   //   calculatePercentages();
    //   // }
    // }).onError((error) {
    //   print('Error reading posture data: $error');
    // });
  }

  void stopreadPostureData() {
    // Stop the timer if it's active
    if (_updateTimer.isActive) {
      _updateTimer.cancel();
      print('timer stopped');
    }
    if(_updateTimer2.isActive){
      _updateTimer2.cancel();
      print('timers stopped');
    }
    _isMonitoringActive = false;
    print('posture reading stopped') ;// Set monitoring flag to false
  }
}
