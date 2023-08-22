import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teslacaranimation/constants/constants.dart';

import '../../controller/buletooth_controller/bluetooth_controller.dart';

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
  late BluetoothDevice _deviceConnected;
  late List<BluetoothCharacteristic> listCaracteristic;

  bool disposeScreen = false;
  bool discoverServicesStatus = false;

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

  Future<dynamic> setStateScreen() async
  {
    setState(() {
      disposeScreen = true;
    });
  }

  Future<int> getRssiDevice() async {
    return _deviceConnected.readRssi();
  }

  Stream<int> getMtuDevice() {
    return _deviceConnected.mtu;
  }

  List<BluetoothService>? isDiscoverytServices () {
    return _deviceConnected.servicesList;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bluetoothConfig();

    return disposeScreen
     ? connectedBluetooth()
     : unconnectedBluetooth();
  }

  Column connectedBluetooth() {
    return Column(
    children: [
      Container(
        color: primaryColor.withOpacity(0.1),
        constraints: const BoxConstraints(minHeight: 50),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Text(
              _deviceConnected.localName, style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
            const Spacer(),
            Icon(Icons.bluetooth_connected, color: Colors.green[200])
          ],
        ),
      ),
      Container(
        color: primaryColor.withOpacity(0.1),
        margin: const EdgeInsets.all(0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('Discovery Services', style: TextStyle(fontSize: 16, color: Colors.white)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  color: Colors.grey[800],
                  onPressed: () async {
                    try {
                      await _deviceConnected.discoverServices();
                      setState(() {
                        discoverServicesStatus = true;
                      });
                    } catch (e) {
                      print(prettyException("Discover Services Error:", e));
                    }
                  },
                ),
              ],
            ),

            if (discoverServicesStatus)
              StreamBuilder(
                stream: _deviceConnected.servicesStream,
                builder: ((context, snapshot) {
                    List<BluetoothService> a = snapshot.data ?? [];
                    return Column(
                      children: [
                        if(a.isEmpty)
                          const Text('Services not found')
                        else
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                const Padding(padding: EdgeInsets.all(10)),
                                Text('Number of found services ${a.length}', style: const TextStyle(color: Colors.white, fontSize: 15),),
                                ...List.generate(a.length, (indexFirst) => Column(
                                  children: [
                                    Text('Service $indexFirst', style: const TextStyle(color: Colors.white, fontSize: 15),),
                                    ...List.generate(a[indexFirst].characteristics.length, (index) => Column(
                                      children: [
                                        Text('Caracteristic ${a[indexFirst].characteristics[index].uuid}', style: const TextStyle(color: Colors.white, fontSize: 15),),
                                        Text('Read: ${a[indexFirst].characteristics[index].properties.read}', style: const TextStyle(color: Colors.white, fontSize: 15),),
                                        Text('Write: ${a[indexFirst].characteristics[index].properties.write}', style: const TextStyle(color: Colors.white, fontSize: 15),),
                                        Text('Notify: ${a[indexFirst].characteristics[index].properties.notify}', style: const TextStyle(color: Colors.white, fontSize: 15),),
                                      ],
                                    ))
                                  ],
                                )),
                              ],
                            ),
                          ),
                      ],
                    );
                })
              )
      ],
        ),
      )
    ],
   );
  }

  Column unconnectedBluetooth() {
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
                            Text('Local Name: ${e.device.localName.toString()}' , style: const TextStyle(color: Colors.white, fontSize: 16)),
                            Text('Remote Id: ${e.device.remoteId.toString()}', style: const TextStyle(color: Colors.white, fontSize: 16)),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                try {
                                  await e.device.connect(timeout: const Duration(seconds: 4));

                                  setState(() {
                                    setStateScreen();
                                    _deviceConnected = e.device;
                                  });

                                } catch (e) {
                                  final snackBar = SnackBar(content: Text(prettyException("Connect Error:", e)));
                                  snackBarKeyB.currentState?.showSnackBar(snackBar);
                                }

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
