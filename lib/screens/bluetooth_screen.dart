import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controller/buletooth_controller/bluetooth_controller.dart';

final snackBarKeyB = GlobalKey<ScaffoldMessengerState>();

void main() {
  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      runApp(const BluetoothScreen());
    });
  } else {
    runApp(const BluetoothScreen());
  }
}

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final BluetoothController _controller = BluetoothController();

  void isStartOrStopScan(bool status) {
    if(status) return _controller.stopScan();

    return _controller.scan();
  }

  Icon getIconStoptOrStartScan(bool status) {
    late IconData icon;

    if(status) {
      icon = Icons.stop;
    }
    else{
      icon = Icons.search;
    }

    return  Icon(
      icon,
      color: Colors.white,
      size: 48,
    );
  }

  void bluetoothConfig() async {
    if (await FlutterBluePlus.isAvailable == false) {
      print("Bluetooth not supported by this device");
      return;
    }

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    await FlutterBluePlus.adapterState
        .where((s) => s == BluetoothAdapterState.on)
        .first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bluetoothConfig();

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
              StreamBuilder<bool>(
                stream: FlutterBluePlus.isScanning,
                initialData: false,
                builder: (context, snapshot) {
                  bool status = snapshot.data ?? false;
                  return IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => setState(() { isStartOrStopScan(status); }),
                    icon: getIconStoptOrStartScan(status),
                  );
                },
              ),
            ],
          ),
        ),
        StreamBuilder<List<ScanResult>>(
              stream: FlutterBluePlus.scanResults,
              initialData: const [],
              builder: (context, snapshot) => Column(
                children: (snapshot.data ?? [])
                .map((e) => Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5),
                      color: Colors.grey.withOpacity(0.2),
                      constraints: const BoxConstraints(minHeight: 40, minWidth: 180),
                      child:
                      Row(
                        children: [
                          Column(
                            children: [
                              Text('Local Name: ${e.device.localName.toString()}' , style: const TextStyle(color: Colors.white, fontSize: 24)),
                              Text('Remote Id: ${e.device.remoteId.toString()}', style: const TextStyle(color: Colors.white, fontSize: 24)),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  e.device.connect(timeout: const Duration(seconds: 4)).catchError((e) {
                                    final snackBar = SnackBar(content: Text(prettyException("Connect Error:", e)));
                                    snackBarKeyB.currentState?.showSnackBar(snackBar);
                                  });
                                  setState(() {
                                  });
                                },
                                icon: const Icon(Icons.connect_without_contact_sharp),
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
               ),).toList(),
              ),
        ),
      ],
    );
  }
}
