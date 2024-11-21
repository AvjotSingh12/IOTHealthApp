import 'package:flutter/material.dart';
import '../models/device.dart';

class DeviceProvider with ChangeNotifier {
  Device? _selectedDevice;

  Device? get selectedDevice => _selectedDevice;

  void selectDevice(Device device) {
    _selectedDevice = device;
    notifyListeners();
  }
}
