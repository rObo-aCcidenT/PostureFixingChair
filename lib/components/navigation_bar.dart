import 'package:flutter/material.dart';
import 'package:splashh/pages/screens/home_page.dart' as Home;
import 'package:splashh/pages/screens/dashboard_page.dart' as Dashboard;
import 'package:splashh/pages/screens/settings_page.dart' as Settings;
import 'package:splashh/pages/screens/calibration_page.dart' as Calibration;
import 'package:splashh/utils/color.dart';
import 'package:splashh/services/database.dart';

class NavigationBarCustom extends StatefulWidget {
  final String username;

  const NavigationBarCustom({Key? key, required this.username}) : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBarCustom> {
  late List<Widget> _screens;
  int _selectedIndex = 0;
  int _calibrationTabIndex = 0;

  void _handleTabChange(int index) {
    setState(() {
      _calibrationTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
     // Fetch the current posture percentages from the Database
  double initialGoodPosturePercentage = DatabaseMethods().goodPosturePercentage;
  double initialBadPosturePercentage = DatabaseMethods().badPosturePercentage;
    _screens = [
      Home.HomeScreen(username: widget.username),
      // Dashboard.DashboardPage(goodPosturePercentage:0, badPosturePercentage:0 ),
      Dashboard.DashboardPage(goodPosturePercentage: initialGoodPosturePercentage,
      badPosturePercentage: initialBadPosturePercentage,),
      Calibration.CalibrationPage(initialTabIndex: 0, onTabChanged: _handleTabChange),
      Settings.SettingsPage(username: widget.username),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth>730) {
          return Row(
            children: [
              NavigationRail(
                selectedIndex: _selectedIndex,
                onDestinationSelected: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                leading: const MyLeadingWidget(),
                elevation: 10,
                useIndicator: true,
                backgroundColor: Colors.white,
                indicatorColor: AppColors.primaryColor,
                labelType: NavigationRailLabelType.none,
                unselectedIconTheme: IconThemeData(color: Colors.grey), // Color for unselected icons
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    selectedIcon: Icon(Icons.home, color: AppColors.backgroundColor),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.dashboard),
                    selectedIcon: Icon(Icons.dashboard, color: AppColors.backgroundColor),
                    label: Text('Dashboard'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.lightbulb),
                    selectedIcon: Icon(Icons.lightbulb, color: AppColors.backgroundColor),
                    label: Text('Calibration'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.settings),
                    selectedIcon: Icon(Icons.settings, color: AppColors.backgroundColor),
                    label: Text('Settings'),
                  ),
                ],
              ),
              const VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: _screens[_selectedIndex],
              ),
            ],
          );
        } else {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.lightbulb),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: '',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Colors.grey, // Color for unselected icons
              showSelectedLabels: false, // Hide selected labels
              showUnselectedLabels: false, // Hide unselected labels
              selectedLabelStyle: TextStyle(height: 0), // Set the selected label height to 0
              unselectedLabelStyle: TextStyle(height: 0), // Set the unselected label height to 0
              backgroundColor: Colors.white, // Background color of the bottom navigation bar
              type: BottomNavigationBarType.fixed, // Ensure the bottom navigation bar items are fixed
              selectedFontSize: 0, // Set the font size of the selected label to 0
              unselectedFontSize: 0, // Set the font size of the unselected label to 0
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
            body: _screens[_selectedIndex],
          );
        }
      },
    );
  }
}

class MyLeadingWidget extends StatelessWidget {
  const MyLeadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Center(
        child: RichText(
          text: TextSpan(
            text: 'Post',
            style: TextStyle(color: AppColors.accentColor), // Default color for "Post"
            children: [
              TextSpan(
                text: 'Fix',
                style: TextStyle(
                  color: AppColors.primaryColor, // Color for "Fix"
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
