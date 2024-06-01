

// import 'package:demo/auth/forgotpass/forgot_password.dart';
// import 'package:demo/auth/login/login.dart';
// import 'package:demo/auth/signup/signup.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: LogIn()
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:demo/components/bg.dart';
// import 'package:demo/components/navigation_bar.dart' as MyNavigationBar;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: BackgroundWrapper(
//         backgroundImage: 'images/bg.png',
//         child: Scaffold(
//           body: MyNavigationBar.NavigationBar(),
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// class MyHomePage extends StatefulWidget {

//   const MyHomePage({Key? key}) : super(key: key);


//   @override

//   State<MyHomePage> createState() => _MyHomePageState();

// }


// class _MyHomePageState extends State<MyHomePage> {

//   late MQTTManager manager;


//   void _configureAndConnect() {

//     String osPrefix = 'Flutter_iOS';

//     if (Platform.isAndroid) {

//       osPrefix = 'Flutter_Android';

//     }

//     manager = MQTTManager(

//       host: "127.0.0.1",

//       topic: "app/test",

//       identifier: osPrefix,

//     );

//     manager.initializeMQTTClient();

//     manager.connect();

//   }


//   void _disconnect() {

//     manager.disconnect();

//   }


//   void _publishMessage(String text) {

//     String osPrefix = "mobile_client";

//     final String message = osPrefix + ' says: ' + text;

//     manager.publish(message);

//   }


//   @override

//   void initState() {

//     _configureAndConnect();

//     super.initState();

//   }


//   @override

//   Widget build(BuildContext context) {

//     return Scaffold(

//       appBar: AppBar(

//         title: const Text(

//           'Flutter Demo',

//         ),

//       ),

//       body: Stack(

//         children: [

//           Column(

//             children: [

//                 child: ElevatedButton(

//                   style: ElevatedButton.styleFrom(

//                     fixedSize: const Size(240, 50),

//                   ),

//                   onPressed: () {

//                     try {

//                       _publishMessage("Hi");

//                     } on ConnectionException catch (e) {

//                       print(e);

//                       final snackBar = SnackBar(

//                         content: const Text('Connecting...'),

//                         backgroundColor: (Colors.black),

//                         duration: const Duration(seconds: 1),

//                         action: SnackBarAction(

//                           label: 'Dismiss',

//                           onPressed: () {},

//                         ),

//                       );

//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);

//                     }

//                   },

//                   child: const Text(

//                     "Refresh",

//                     style: TextStyle(

//                       fontFamily: 'Open Sans',

//                       fontSize: 17.5,

//                     ),

//                   ),

//                 ),


// ),

//             ],

//           ),

//         ],

//       ),

//     );

//   }


//   @override

//   void deactivate() {

//     _disconnect();

//     super.deactivate();

//   }

// }

