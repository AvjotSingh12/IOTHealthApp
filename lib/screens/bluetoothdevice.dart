import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothDevicesScreen extends StatefulWidget {
  @override
  _BluetoothDevicesScreenState createState() => _BluetoothDevicesScreenState();
}

class _BluetoothDevicesScreenState extends State<BluetoothDevicesScreen> {
  List<BluetoothDevice> connectedDevices = [];
  bool isScanning = false;

  @override
  void initState() {
    super.initState();

    requestPermissions();
    fetchConnectedDevices();
  }

  // Request Bluetooth and Location Permissions
  void requestPermissions() async {
    if (await Permission.bluetoothScan.request().isGranted) {
      print("Bluetooth Scan Permission Granted");
    } else {
      print("Bluetooth Scan Permission Denied");
    }
    if (await Permission.bluetoothConnect.request().isGranted) {
      print("Bluetooth Connect Permission Granted");
    } else {
      print("Bluetooth Connect Permission Denied");
    }
    if (await Permission.locationWhenInUse.request().isGranted) {
      print("Location Permission Granted");
    } else {
      print("Location Permission Denied");
    }
  }

  // Fetch connected devices
  void fetchConnectedDevices() async {
    connectedDevices = await FlutterBluePlus.connectedDevices;
    setState(() {});
  }

  // Start Bluetooth scanning
  void startScanning() {
    setState(() => isScanning = true);
    FlutterBluePlus.startScan(timeout: Duration(seconds: 5));
  }

  // Stop Bluetooth scanning
  void stopScanning() {
    setState(() => isScanning = false);
    FlutterBluePlus.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          isScanning
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: startScanning,
                  child: Text('Start Scanning'),
                ),
          Expanded(
            child: StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('No devices found');
                return ListView(
                  children: snapshot.data!
                      .map((result) => ListTile(
                            title: Text(result.device.name.isNotEmpty
                                ? result.device.name
                                : "Unknown Device"),
                            subtitle: Text(result.device.id.toString()),
                            trailing: ElevatedButton(
                              onPressed: () {
                                // Add connection logic here
                                connectToDevice(result.device);
                              },
                              child: Text('Connect'),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: stopScanning,
        child: Icon(Icons.stop),
      ),
    );
  }

  // Function to connect to a device (dummy for now)
  void connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      print('Connected to ${device.name}');
    } catch (e) {
      print('Failed to connect: $e');
    }
  }
}
