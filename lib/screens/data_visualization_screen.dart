import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async'; // For the Timer
import 'dart:math'; // For generating random numbers

class DataVisualizationScreen extends StatefulWidget {
  @override
  _DataVisualizationScreenState createState() =>
      _DataVisualizationScreenState();
}

class _DataVisualizationScreenState extends State<DataVisualizationScreen> {
  List<FlSpot> spots = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
  ];

  late Timer _timer; // Declare a timer

  @override
  void initState() {
    super.initState();
    // Start the timer when the screen loads
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateData();
    });
  }

  // Function to update the data dynamically
  void _updateData() {
    setState(() {
      // Generate random data to simulate heart rate changes
      double newValue = 60 + (10 * (0.5 - Random().nextDouble())); // Random y-value
      spots.add(FlSpot(
        spots.length.toDouble(), // Incrementing x-axis value
        newValue.toDouble(), // Y-value
      ));

      // Limit the number of data points on the chart to avoid overflow
      if (spots.length > 10) {
        spots.removeAt(0); // Remove the first point if we exceed the limit
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer.cancel();
    super.dispose();
  }

  // Function to determine the color of the line based on trend
  Color _getLineColor(int index) {
    if (index == 0) return Colors.deepPurple; // First point always purple

    // Compare the current value with the previous value
    double currentValue = spots[index].y;
    double previousValue = spots[index - 1].y;

    // If the current value is higher than the previous, use green (upward trend)
    if (currentValue > previousValue) {
      return Colors.green;
    } else {
      // Otherwise, use red (downward trend)
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data Visualization',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple, // Aesthetic color for the app bar
        elevation: 4.0, // Elevation for app bar to add depth
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Data Overview',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false, // Disable vertical lines
                    drawHorizontalLine: true, // Show horizontal lines
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots, // Dynamically updated spots here
                      isCurved: true,
                      color: _getLineColor(spots.length - 1), // Get the line color
                      dotData: FlDotData(show: false), // Hides individual data points
                      belowBarData: BarAreaData(
                        show: true,
                        color: _getLineColor(spots.length - 1).withOpacity(0.2), // Set the color below the bar (same as line color)
                      ),
                      barWidth: 4,
                    ),
                  ],
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
