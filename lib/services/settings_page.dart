// // import 'package:flutter/material.dart';
// // import 'package:demo/components/bg.dart';

// // class SettingsScreen extends StatelessWidget {
// //   const SettingsScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BackgroundWrapper(
// //       child: Scaffold(
// //         // ... your existing Scaffold content
// //         appBar: AppBar(
// //           title: Text('settings'),
// //         ),
// //        body: Center(
// //           child: Container(
// //             decoration: BoxDecoration(
// //               image: DecorationImage(image: AssetImage("assets/images/bg.png"),
// //               fit: BoxFit.cover)
// //             ),
// //           )
// //         ),
// //       ),
// //       backgroundImage: 'images/bg.png', // Set your image path (different from others)
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:splashh/components/bg.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key}) : super(key: key);

//   @override
//   _SettingsScreenState createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen> {
//   bool autoStart = false; // Initial state of auto start
//   bool notificationModeVibration = true; // Initial state for notification mode

//   @override
//   Widget build(BuildContext context) {
//     return BackgroundWrapper(
//       backgroundImage: 'images/bg.png', // Set your image path (different from others)
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Settings'),
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: <Widget>[
//             const SizedBox(height: 20),
//             buildToggleTile(
//               title: 'Auto Start',
//               subtitle: 'Set this for constant background running.',
//               value: autoStart,
//               onChanged: (bool value) {
//                 setState(() {
//                   autoStart = value;
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             buildNotificationSection(),
//             const SizedBox(height: 30),
//             ListTile(
//               leading: const Icon(Icons.exit_to_app),
//               title: const Text('Log Out'),
//               onTap: () {
//                 // Implement log out functionality here
//                 print('User logged out');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildToggleTile({
//     required String title,
//     required String subtitle,
//     required bool value,
//     required void Function(bool) onChanged,
//   }) {
//     return SwitchListTile(
//       title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//       subtitle: Text(subtitle),
//       value: value,
//       onChanged: onChanged,
//       activeColor: Colors.blue[800], // Dark blue color for enabled state
//     );
//   }

//   Widget buildNotificationSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Notification Mode',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         ListTile(
//           title: const Text('Vibration Mode'),
//           leading: Radio<bool>(
//             value: true,
//             groupValue: notificationModeVibration,
//             onChanged: (bool? value) {
//               setState(() {
//                 notificationModeVibration = value!;
//               });
//             },
//             activeColor: Colors.blue[800], // Dark blue when selected
//           ),
//         ),
//         ListTile(
//           title: const Text('Pop-Up Mode'),
//           leading: Radio<bool>(
//             value: false,
//             groupValue: notificationModeVibration,
//             onChanged: (bool? value) {
//               setState(() {
//                 notificationModeVibration = value!;
//               });
//             },
//             activeColor: Colors.blue[800], // Dark blue when selected
//           ),
//         ),
//       ],
//     );
//   }
// }
