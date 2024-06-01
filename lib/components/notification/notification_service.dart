import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationService {
  static Future<void> sendNotification(String fcmToken, String title, String body) async {
    final String serverKey = 'AAAAInec_w4:APA91bHXHiVK_eNKsuAvjuCXxGy6nh1-IySI4focel_Xxfyp5E95Mr-L62-JTii1b24nDXnfcpcFy4JVWMvwl0PcHg0PYrmVMAuru6wQaSYAHLakREHvcIJgsmtkrtiXJkH4hMR1Z1I_'; // Your FCM server key
    final String fcmEndpoint = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, dynamic> data = {
      'notification': {'title': title, 'body': body},
      'priority': 'high',
      'to': fcmToken, // Send notification to the specific device using its FCM token
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    final response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
    }
  }
}
