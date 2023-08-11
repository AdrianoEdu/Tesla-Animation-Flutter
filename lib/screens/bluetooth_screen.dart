import 'package:flutter/material.dart';
import 'package:teslacaranimation/components/controller/buletooth_controller/bluetooth_controller.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final BluetoothController _controller = BluetoothController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey.withOpacity(0.2),
          padding: const EdgeInsets.all(10),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Start Scan blueooth', style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => setState(() {_controller.updateScanStatus();}),
                icon: _controller.isScanBluetooth ?
                  const Icon(Icons.stop, size: 48, color: Colors.white,):
                  const Icon(Icons.search, size: 48, color: Colors.white,)
              ),
            ],
          ),
        ),
      ],
    );
  }
}
