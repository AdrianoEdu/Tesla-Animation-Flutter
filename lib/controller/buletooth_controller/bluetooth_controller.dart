import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothController {

  bool isScanBluetooth = false;

  final snackBarKeyB = GlobalKey<ScaffoldMessengerState>();

  void updateScanStatus() {
    isScanBluetooth = !isScanBluetooth;
  }

  void scan() async  {
    try {
      if(FlutterBluePlus.isScanningNow == false) {
        await FlutterBluePlus.startScan(
          timeout: const Duration(seconds: 15),
          androidUsesFineLocation: false,
        );
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(prettyException('Start scan error', e))
      );
      snackBarKeyB.currentState?.showSnackBar(snackBar);
    }
  }

  void stopScan() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(prettyException('Stop scan error', e))
      );
      snackBarKeyB.currentState?.showSnackBar(snackBar);
    }
  }
}

String prettyException(String prefix, dynamic e) {
  if (e is FlutterBluePlusException) {
    return "$prefix ${e.errorString}";
  } else if (e is PlatformException) {
    return "$prefix ${e.message}";
  }
  return prefix + e.toString();
}
