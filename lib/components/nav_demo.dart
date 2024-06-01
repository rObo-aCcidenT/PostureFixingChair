// import 'package:flutter/material.dart';
// import 'package:splashh/pages/screens/home_page.dart' as Home;
// import 'package:splashh/pages/screens/dashboard_page.dart' as Dashboard;
// import 'package:splashh/pages/screens/settings_page.dart' as Settings;
// import 'package:splashh/pages/screens/calibration_page.dart' as Calibration;

// class NavigationBar extends StatefulWidget {
//   const NavigationBar({Key? key}) : super(key: key);

//   @override
//   _NavigationBarState createState() => _NavigationBarState();
// }

// class _NavigationBarState extends State {
//   late List <Widget> _screens;
//   int _selectedIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _screens = [
//       const Home.HomeScreen(username: username),
//       const Dashboard.DashboardPage(),
//       const Settings.SettingsPage(),
//       Calibration.CalibrationPage(
//       initialTabIndex: 0, // Provide the initialTabIndex parameter
//       onTabChanged: _handleTabChange,
// ),

//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           if (constraints.maxWidth > 640) {
//             return Row(
//               children: [
//                 NavigationRail(
//                   selectedIndex: _selectedIndex,
//                   onDestinationSelected: (int index) {
//                     setState(() {
//                       _selectedIndex = index;
//                     });
//                   },
//                   labelType: NavigationRailLabelType.all,
//                   destinations: const [
//                     NavigationRailDestination(
//                       icon: Icon(Icons.home),
//                       label: Text('Home'),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(Icons.dashboard),
//                       label: Text('Dashboard'),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(Icons.settings),
//                       label: Text('Settings'),
//                     ),
//                     NavigationRailDestination(
//                       icon: Icon(Icons.lightbulb),
//                       label: Text('Calibration'),
//                     ),
//                   ],
//                 ),
//                 VerticalDivider(thickness: 1, width: 1),
//                 Expanded(
//                   child: IndexedStack(
//                     index: _selectedIndex,
//                     children: _screens,
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text('Navigation Bar'),
//               ),
//               body: _screens[_selectedIndex],
//               bottomNavigationBar: BottomNavigationBar(
//                 currentIndex: _selectedIndex,
//                 onTap: (int index) {
//                   setState(() {
//                     _selectedIndex = index;
//                   });
//                 },
//                 items: const [
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.home),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.dashboard),
//                     label: 'Dashboard', 
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.settings),
//                     label: 'Settings',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.lightbulb),
//                     label: 'Calibration',
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:splashh/pages/screens/home_page.dart' as Home;
// import 'package:splashh/pages/screens/dashboard_page.dart' as Dashboard;
// import 'package:splashh/pages/screens/settings_page.dart' as Settings;
// import 'package:splashh/pages/screens/calibration_page.dart' as Calibration;
// import 'package:splashh/utils/color.dart';

// class NavigationBarCustom extends StatefulWidget {
//   final String username;

//   const NavigationBarCustom({Key? key, required this.username}) : super(key: key);

//   @override
//   _NavigationBarState createState() => _NavigationBarState();
// }

// class _NavigationBarState extends State<NavigationBarCustom> {
//   late List<Widget> _screens;
//   int _selectedIndex = 0;
//   int _calibrationTabIndex = 0;

//   void _handleTabChange(int index) {
//     setState(() {
//       _selectedIndex = index;
//       // Check if the index is for the custom "Dashboard" item and navigate accordingly
//       if (index == 1) {
//         // Navigate to the Dashboard screen
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) => Dashboard.DashboardPage(),
//         ));
//       }
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _screens = [
//       Home.HomeScreen(username: widget.username),
//       const Dashboard.DashboardPage(),
//       Calibration.CalibrationPage(initialTabIndex: 0, onTabChanged: _handleTabChange),
//       const Settings.SettingsScreen(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           NavigationRail(
//             selectedIndex: _selectedIndex,
//             onDestinationSelected: (int index) {
//               setState(() {
//                 _selectedIndex = index;
//                 _handleTabChange(index); // Call the custom handler
//               });
//             },
//             labelType: NavigationRailLabelType.none,
//             unselectedIconTheme: IconThemeData(color: Colors.grey), // Color for unselected icons
//             destinations: const [
//               NavigationRailDestination(
//                 icon: Icon(Icons.home),
//                 selectedIcon: Icon(Icons.home, color: AppColors.accentColor),
//                 label: Text('Home'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.dashboard),
//                 selectedIcon: Icon(Icons.dashboard, color: AppColors.accentColor),
//                 label: Text('Dashboard'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.lightbulb),
//                 selectedIcon: Icon(Icons.lightbulb, color: AppColors.accentColor),
//                 label: Text('Calibration'),
//               ),
//               NavigationRailDestination(
//                 icon: Icon(Icons.settings),
//                 selectedIcon: Icon(Icons.settings, color: AppColors.accentColor),
//                 label: Text('Settings'),
//               ),
//             ],
//           ),
//           const VerticalDivider(thickness: 1, width: 1),
//           Expanded(
//             child: IndexedStack(
//                     index: _selectedIndex,
//                     children: _screens,
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }