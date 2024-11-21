import 'package:flutter/material.dart';
import 'package:iothealthapp/screens/bluetoothdevice.dart';
import 'package:iothealthapp/screens/device_list_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _deviceController = TextEditingController();
  String _connectionType = "Bluetooth";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IoT Health App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _deviceController,
              decoration: InputDecoration(labelText: "Enter Device Name"),
            ),
            DropdownButton<String>(
              value: _connectionType,
              items: ["Bluetooth", "Wi-Fi"]
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _connectionType = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeviceListScreen()),
                );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
