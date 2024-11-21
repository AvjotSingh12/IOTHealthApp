import 'package:flutter/material.dart';
import 'package:iothealthapp/screens/bluetoothdevice.dart';
import 'screens/home_screen.dart';
import 'screens/data_visualization_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Health App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
       '/bluetooth': (context) => BluetoothDevicesScreen(),
        '/dataVisualization': (context) => DataVisualizationScreen(),
      },
    );
  }
}
