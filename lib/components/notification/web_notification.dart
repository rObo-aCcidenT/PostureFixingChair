

import 'dart:html';


class WebNotificationHandler {
  static Future<void> showWebNotification(String title) async {
    // Check if the Notification API is supported by the browser
    if (!Notification.supported) {
      // Notification API is not supported by the browser
      print('Notification API is not supported by this browser.');
      return;
    }

    // Check if the user has granted permission to display notifications
    if (Notification.permission != 'granted') {
      // Request permission from the user to display notifications
      var permission = await Notification.requestPermission();
      if (permission != 'granted') {
        // User denied permission to display notifications
        print('Permission denied to display notifications.');
        return;
      }
    }

    // Create and display the notification
    Notification(title);
  }
}
