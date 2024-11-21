import 'package:flutter/material.dart';
import 'package:iothealthapp/screens/data_visualization_screen.dart';

// Define the Device model class
class Device {
  final String id;
  final String name;

  Device({required this.id, required this.name});
}

// Mock data for devices
final List<Device> mockDevices = [
  Device(id: '1', name: 'Device 1'),
  Device(id: '2', name: 'Device 2'),
  Device(id: '3', name: 'Device 3'),
];

void main() {
  runApp(MaterialApp(
    home: DeviceListScreen(),
    routes: {
      '/dataVisualization': (context) => DataVisualizationScreen(),
    },
  ));
}

class DeviceListScreen extends StatelessWidget {
  // Function to show loading dialog
  void _showConnectingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Rounded corners for the dialog
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16.0),
                  Text(
                    'Connecting...',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Device List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple, // Aesthetic color
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: mockDevices.length,
          itemBuilder: (context, index) {
            final device = mockDevices[index];
            return Card(
              elevation: 8.0, // Shadow effect for the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Rounded corners
              ),
              margin: EdgeInsets.symmetric(vertical: 12.0), // Spacing between cards
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Device Icon or Placeholder
                    Icon(
                      Icons.device_hub,
                      color: Colors.deepPurple,
                      size: 40.0,
                    ),
                    SizedBox(width: 16.0),
                    // Device Information
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            device.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            'Device ID: ${device.id}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Connect Button
                    ElevatedButton(
                      onPressed: () {
                        _showConnectingDialog(context); // Show the loading dialog

                        // Simulate a delay (for demonstration)
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.pop(context); // Dismiss the dialog
                          Navigator.pushNamed(
                            context,
                            '/dataVisualization',
                            arguments: device,
                          );
                        });
                      },
                      child: Text('Connect'),
                      style: ElevatedButton.styleFrom(
                       // Text color
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
