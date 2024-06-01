
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:splashh/pages/login/login.dart';
import 'package:splashh/pages/onboarding/onboarding_view.dart';
import 'package:splashh/components/bg.dart';
import 'package:splashh/components/nav_demo.dart' as MyNavigationBar;
import 'package:splashh/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashh/components/navigation_bar.dart';
import 'package:splashh/firebase_options.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'dart:async';
import 'dart:convert';
import 'package:splashh/components/notification.dart';
import 'package:http/http.dart' as http; // Import your NotificationHandler widget




// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   print("Handling a background message: ${message.messageId}");
//   // Handle the background message here
// }
  // Initialize Firebase Messaging
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   // Initialize GoogleSignIn with client ID
  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '148035665678-7bpvitectk90iralmelbr188lulpbbcf.apps.googleusercontent.com',
  );
  
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
   // Initialize Firebase
  // if (kIsWeb) {
  //   await Firebase.initializeApp(

  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyCDQ4KZE0tvMCzWVp02PN4NsbE5MVVGA_M", // Replace with your Firebase API key
  //       appId: "1:148035665678:web:bcca762e9365003d1c615f",  // Replace with your Firebase App ID
  //       projectId: "postfix-ce6e0",  // Replace with your Firebase Project ID
  //       storageBucket: "postfix-ce6e0.appspot.com", // Replace with your Firebase Storage Bucket
  //       messagingSenderId: "148035665678",  // Replace with your Firebase Messaging Sender ID
  //       authDomain: "postfix-ce6e0.firebaseapp.com",
  //       databaseURL: "https://postfix-ce6e0-default-rtdb.firebaseio.com",  // Replace with your Firebase Auth Domain
  //     ),
  //   );
  // }else{
  //   await Firebase.initializeApp(

  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyCDQ4KZE0tvMCzWVp02PN4NsbE5MVVGA_M", // Replace with your Firebase API key
  //       appId: "1:148035665678:android:1fb411753f8442931c615f",  // Replace with your Firebase App ID
  //       projectId: "postfix-ce6e0",  // Replace with your Firebase Project ID
  //       storageBucket: "postfix-ce6e0.appspot.com", // Replace with your Firebase Storage Bucket
  //       messagingSenderId: "148035665678",  // Replace with your Firebase Messaging Sender ID
  //       authDomain: "postfix-ce6e0.firebaseapp.com",
  //       databaseURL: "https://postfix-ce6e0-default-rtdb.firebaseio.com",  // Replace with your Firebase Auth Domain
  //     ),
  //   );

  // }

  //ivde fcm undarnn
  // Function to retrieve the FCM token
Future<String?> getFCMToken() async {
  // Get the FCM token for the device
  String? fcmToken = await _firebaseMessaging.getToken();
  return fcmToken;
}
    // Retrieve the FCM token for the device
  // String? fcmToken = await _firebaseMessaging.getToken();
  // print('FCM Token: $fcmToken');

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
    if (settings.name == '/login') {
      return MaterialPageRoute(builder: (context) => LogIn()); // Replace LoginScreen with your actual login screen widget
    }
      },
    //
      title: 'PostFix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        textTheme: GoogleFonts.montserratTextTheme(),
        useMaterial3: true,
        
      ),
      // home: NavigationBarCustom(username: 'YourUsername'),
      home: OnboardingView(),
    );
  }
}



