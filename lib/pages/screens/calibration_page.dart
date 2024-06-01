import 'package:flutter/material.dart';
import 'package:splashh/components/button.dart'; // Import ButtonWidget
import 'package:splashh/pages/screens/dashboard_page.dart'; // Import the DashboardPage

class CalibrationPage extends StatefulWidget {
  final int initialTabIndex;
  final Function(int) onTabChanged;

  const CalibrationPage({Key? key, required this.initialTabIndex, required this.onTabChanged}) : super(key: key);

  @override
  _CalibrationPageState createState() => _CalibrationPageState();
}

class _CalibrationPageState extends State<CalibrationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: widget.initialTabIndex);
    _tabController.addListener(() {
      widget.onTabChanged(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        appBar: AppBar(
          automaticallyImplyLeading: false, // Disable the back button
          title: Text('User Guide',
          style: TextStyle(
            backgroundColor: Colors.transparent,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Set Up intro'), // Updated tab names
              Tab(text: 'Good Posture'),
              Tab(text: 'Bad Posture'),
              Tab(text: 'All set'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child:SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Meet the Postfix Chair, \nyour gateway to a smarter sitting experience.\n\n Designed with cutting-edge ML and IoT technologies, \nthis chair not only adapts to your personal comfort needs\n but also helps optimize your posture and health throughout the day.\n\n Experience the future of furniture with the Postfix Chair, where innovation meets everyday convenience.',
                      style: TextStyle(
                        fontSize: 14),
                        textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ButtonWidget(
                      buttonText: 'Continue', // Tab 1 button text for ButtonWidget
                      onPressed: () {
                        // Redirect to the Good Posture tab when the button is pressed
                        goToGoodPostureTab();
                      },
                    ),
                  ],
                ),
                )
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child:SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Maintaining good posture while sitting \nis crucial for your back health.\nHere are some key principles to follow:\n\n',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    // SizedBox(height: 20),
                    // // Image.asset(
                    //   'images/5.png', // Replace 'your_image.png' with your actual image path
                    //   height: 200, // Adjust the height as needed
                    //   width: 200, // Adjust the width as needed
                    // ),
                    Text(
                      'Neutral Spine: Aim for a neutral spine.\nThis means your hips, knees, and ankles should be bent at roughly 90-degree angles.\n Your back should be straight and supported by your chairs lumbar curve.\n\n',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Relaxed Upper Body: Keep your shoulders relaxed \nand avoid hunching forward. \nYour elbows should be close to your body, \nbent at around 90 degrees. \nKeep your wrists straight and in line with your forearms.',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Movement Matters: Do not stay glued to your seat! \nChange positions frequently throughout the day,\n even if it is just minor adjustments. \nAvoid sitting for extended periods \n(ideally less than 50 minutes at a time).',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ButtonWidget(
                      buttonText: 'Continue', // Tab 1 button text for ButtonWidget
                      onPressed: () {
                        // Redirect to the Good Posture tab when the button is pressed
                        goToBadPostureTab();
                      },
                    ),
                  ],
                ),
                )
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child:SingleChildScrollView(
                   child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sitting for long periods can strain your back \nif you are not mindful of your posture.\n Here are some common mistakes to avoid:\n\n',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    // Image.asset(
                    //   'images/5.png', // Replace 'your_image.png' with your actual image path
                    //   height: 200, // Adjust the height as needed
                    //   width: 200, // Adjust the width as needed
                    // ),
                    Text(
                      'To avoid back pain while sitting, ditch the slouch! \nKeep your spine in a neutral position\n with good back support.',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Avoid crossing your legs or arms for long periods,\n and do not let your feet dangle. \nGet up and move around frequently to prevent muscle strain, \nand adjust your screen or document position to avoid craning your neck forward. ',
                      style: TextStyle(fontSize: 14,),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: 20),
                    ButtonWidget(
                      buttonText: 'Continue', // Tab 1 button text for ButtonWidget
                      onPressed: () {
                        // Redirect to the Good Posture tab when the button is pressed
                        goToAllSetTab();
                      },
                    ),
                  ],
                ),
                )
               
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 100,
                    ),
                    Text(
                      'You are all set.',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Thank You!\nNow you know PostFix.\nYou can monitor from the dashboard.',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                   ButtonWidget(
                          buttonText: 'Go to Dashboard',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DashboardPage(goodPosturePercentage:0, badPosturePercentage:0 ,)),
                            );
                          },
                        ),
                  ],
                ),)
                
              ),
            ),
          ],
        ),

    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Method to switch to the Good Posture tab
  void goToGoodPostureTab() {
    _tabController.animateTo(1); // Index 1 corresponds to the Good Posture tab
  }
  void goToBadPostureTab() {
    _tabController.animateTo(2); // Index 1 corresponds to the Good Posture tab
  }
  void goToAllSetTab() {
    _tabController.animateTo(3); // Index 1 corresponds to the Good Posture tab
  }
}

