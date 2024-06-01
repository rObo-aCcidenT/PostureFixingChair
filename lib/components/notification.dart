// import 'package:flutter/material.dart';
// import 'package:windows_notification/notification_message.dart';
// import 'package:windows_notification/windows_notification.dart';

// class NotificationHandler extends StatefulWidget {
//   final WindowsNotification winNotifyPlugin;

//   const NotificationHandler({Key? key, required this.winNotifyPlugin}) : super(key: key);

//   @override
//   _NotificationHandlerState createState() => _NotificationHandlerState();
// }

// class _NotificationHandlerState extends State<NotificationHandler> {
//   @override
//   void initState() {
//     super.initState();
//      print("NotificationHandler initialized"); // Debug statement
//     sendWindowsNotification();
//   }

//   void sendWindowsNotification() {
//     NotificationMessage message = NotificationMessage.fromPluginTemplate(
//       "notification_id_1",
//       "Notification Title",
//       "Notification Body",
//       largeImage: "assets/images/treeeee.jpg",
//       image: "assets/images/treeeee.jpg",
//     );
//     widget.winNotifyPlugin.showNotificationPluginTemplate(message);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // You can return any widget here if needed
//     return SizedBox();
//   }
