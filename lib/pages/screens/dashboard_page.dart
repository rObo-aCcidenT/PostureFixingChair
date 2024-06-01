import 'package:flutter/material.dart';
import 'package:splashh/services/database.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:splashh/utils/color.dart';
import 'package:splashh/pages/screens/barchart.dart';
// import 'package:splashh/services/database.dart';
class DashboardPage extends StatefulWidget {
  // const DashboardPage({Key? key}) : super(key: key);
  const DashboardPage({Key? key, required this.goodPosturePercentage, required this.badPosturePercentage}) : super(key: key);


  final double goodPosturePercentage;
  final double badPosturePercentage;

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with AutomaticKeepAliveClientMixin {
  late double goodPosturePercentage;
  late double badPosturePercentage;
  late PostureInfo postureInfo;

  @override
  bool get wantKeepAlive => true;
  void initState() {
    super.initState();
    goodPosturePercentage = widget.goodPosturePercentage;
    badPosturePercentage = widget.badPosturePercentage;
    
  }

  @override
  void didUpdateWidget(covariant DashboardPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.goodPosturePercentage != goodPosturePercentage ||
        widget.badPosturePercentage != badPosturePercentage) {
      setState(() {
        goodPosturePercentage = widget.goodPosturePercentage;
        badPosturePercentage = widget.badPosturePercentage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    // realtime data for the radial bar chart
    List<Map<String, dynamic>> chartData = [
      {'category': 'Good Posture', 'value': goodPosturePercentage}, 
      {'category': 'Bad Posture', 'value': badPosturePercentage}, 
    ];

   // Return the radial bar chart widget here
  // return SfCircularChart(chartData : );


    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the back button
        title: Text(
          'Dashboard',
          style: TextStyle(
            backgroundColor: Colors.transparent,
            fontWeight: FontWeight.w400,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(60.0, 15.0, 60.0, 20.0), // Left, top, right, bottom
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = MediaQuery.of(context).size.width;
              bool isWideScreen = screenWidth > 730;

              double textFontSize = screenWidth * 0.05;
              double smalltextFontSize = screenWidth * 0.05;
              textFontSize = textFontSize > 18 ? 18 : textFontSize;
              smalltextFontSize = smalltextFontSize > 12 ? 12 : smalltextFontSize;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // First container
                  isWideScreen
                      ? Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 232, 235, 242),
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5), // Adjust color
                                      offset: Offset(4.0, 4.0), // Adjust offset
                                      blurRadius: 10.0, // Adjust blur radius
                                      spreadRadius: 2.0, // Adjust spread radius (optional)
                                    ),
                                  ],
                                ),
                                // Inside the container where you want to add the titled texts
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Your Posture Score:',
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Slouchy Scholar',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 5.0), // Adjust spacing between the titles and subtitles
                                    Text(
                                      'You are in 50% of correct sitting posture.',
                                      style: TextStyle(
                                        fontSize: smalltextFontSize,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 15.0), // Adjust spacing between the first titled text and the second titled text
                                    Text(
                                      'Tip:',
                                      style: TextStyle(
                                        fontSize: textFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Reduce backward slouch sitting.',
                                      style: TextStyle(
                                        fontSize: smalltextFontSize,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            ),
                            ),
                          ],
                        )
                      : Container(
                          height: 200.0,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 235, 242),
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5), // Adjust color
                                offset: Offset(4.0, 4.0), // Adjust offset
                                blurRadius: 10.0, // Adjust blur radius
                                spreadRadius: 2.0, // Adjust spread radius (optional)
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Posture Score:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Slouchy Scholar',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 5.0), // Adjust spacing between the titles and subtitles
                                    Text(
                                      'You are in 50% of correct sitting posture.',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 15.0), // Adjust spacing between the first titled text and the second titled text
                                    Text(
                                      'Tip:',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Reduce backward slouch sitting.',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ),
                        ),
                  SizedBox(height: 30.0),
                  // Second container
                  isWideScreen
                      ? Container(
                        height: 250.0,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 232, 235, 242),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // Adjust color
                              offset: Offset(4.0, 4.0), // Adjust offset
                              blurRadius: 10.0, // Adjust blur radius
                              spreadRadius: 2.0, // Adjust spread radius (optional)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container for the chart
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title above the radial bar chart
                                    Text(
                                      'Daily Progress',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(height: 10.0), // Adjust spacing between the title and the chart
                                    // Chart
                                    Row(
                                      children: [
                                      ClipRRect(
                        borderRadius: BorderRadius.circular(135 / 2), // Half of the height or width, assuming the container is a perfect circle
                        child: Container(
                          width: 180, // Adjust the width of the chart container as needed
                          height: 180, // Adjust the height of the chart container as needed
                          child: SfCircularChart(
  series: <RadialBarSeries<Map<String, dynamic>, String>>[
    RadialBarSeries<Map<String, dynamic>, String>(
      dataSource: chartData,
      xValueMapper: (datum, _) => datum['category'],
      yValueMapper: (datum, _) => datum['value'],
      cornerStyle: CornerStyle.bothCurve,
      maximumValue: 100, // Set the maximum value for the radial bar chart
      gap: '20%', // Set the gap between each bar
      dataLabelSettings: DataLabelSettings(isVisible: true),
      // Set the custom colors for the radial bars
      pointColorMapper: (datum, _) {
        // Assuming 'value' field in your data determines the color
        if (datum['value'] >= 50) {
          // Return yellow color for values >= 50
          return Colors.amber[600];
        } else {
          // Return red color for values < 50
          return Colors.red;
        }
      },
    ),
  ],
),

                        ),
                      ),

                              SizedBox(width: 20.0), // Adjust spacing between the chart and the tiny boxes
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Tiny box 1 with text
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 20.0, // Adjust the width of the tiny box
                                                  height: 20.0, // Adjust the height of the tiny box
                                                  color: AppColors.primaryColor, // Adjust the color
                                                  margin: EdgeInsets.only(right: 10.0), // Adjust spacing between the box and the text
                                                ),
                                                Text(
                                                  'Good Posture',
                                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            // Tiny box 2 with text
                                            Row(
                                              children: [
                                                Container(
                                                  width: 20.0, // Adjust the width of the tiny box
                                                  height: 20.0, // Adjust the height of the tiny box
                                                  color: Colors.red[600], // Adjust the color
                                                  margin: EdgeInsets.only(right: 10.0), // Adjust spacing between the box and the text
                                                ),
                                                Text(
                                                  'Bad Posture',
                                                  style: TextStyle(fontSize: 14.0,fontWeight: FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Tiny boxes vertically arranged
                            ],
                          ),
                        ),
                      )

                      : Container(
                    height: 300.0, // Adjust the height of the container as needed
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 235, 242),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Adjust color
                          offset: Offset(4.0, 4.0), // Adjust offset
                          blurRadius: 10.0, // Adjust blur radius
                          spreadRadius: 2.0, // Adjust spread radius (optional)
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Title
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Daily Progress',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // Radial Bar Chart
                        Container(
                          width: 200, // Adjust the width of the chart container as needed
                          height: 200, // Adjust the height of the chart container as needed
                          child: SfCircularChart(
  series: <RadialBarSeries<Map<String, dynamic>, String>>[
    RadialBarSeries<Map<String, dynamic>, String>(
      dataSource: chartData,
      xValueMapper: (datum, _) => datum['category'],
      yValueMapper: (datum, _) => datum['value'],
      cornerStyle: CornerStyle.bothCurve,
      maximumValue: 100, // Set the maximum value for the radial bar chart
      gap: '20%', // Set the gap between each bar
      dataLabelSettings: DataLabelSettings(isVisible: true),
      // Set the custom colors for the radial bars
      pointColorMapper: (datum, _) {
        // Assuming 'value' field in your data determines the color
        if (datum['value'] >= 50) {
          // Return yellow color for values >= 50
          return Colors.amber[600];
        } else {
          // Return red color for values < 50
          return Colors.red;
        }
      },
    ),
  ],
),
                        ),
                        // Tiny Boxes with Names
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Tiny Box 1 with Name
                            Container(
                              width: 20.0, // Adjust the width of the tiny box
                              height: 20.0, // Adjust the height of the tiny box
                              color: AppColors.primaryColor, // Adjust the color of the tiny box
                              margin: EdgeInsets.all(8.0), // Adjust spacing around the box
                            ),
                            Text(
                              'Good Posture',
                              style: TextStyle(fontSize: smalltextFontSize,color: Colors.grey),
                            ),
                            SizedBox(width: 20.0), // Adjust spacing between the boxes
                            // Tiny Box 2 with Name
                            Container(
                              width: 20.0, // Adjust the width of the tiny box
                              height: 20.0, // Adjust the height of the tiny box
                              color: Colors.red, // Adjust the color of the tiny box
                              margin: EdgeInsets.all(8.0), // Adjust spacing around the box
                            ),
                            Text(
                              'Bad Posture',
                              style: TextStyle(fontSize: smalltextFontSize,color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.0),
                  // Long rectangle
                  Container(
                    height: 400.0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 235, 242),
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Adjust color
                          offset: Offset(4.0, 4.0), // Adjust offset
                          blurRadius: 10.0, // Adjust blur radius
                          spreadRadius: 2.0, // Adjust spread radius (optional)
                        ),
                      ],
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.only(bottom: 20.0, left: 30.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Weekly Progress',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Expanded(
                            child: BarChartSample3(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
