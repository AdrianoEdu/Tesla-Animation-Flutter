class BluetoothController {

  bool isScanBluetooth = false;

  void updateScanStatus() {
    isScanBluetooth = !isScanBluetooth;
  }
}
