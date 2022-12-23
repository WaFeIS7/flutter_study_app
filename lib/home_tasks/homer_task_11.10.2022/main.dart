import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DeviceInfo(),
  ));
}

class DeviceInfo extends StatefulWidget {
  const DeviceInfo({Key? key}) : super(key: key);

  @override
  State<DeviceInfo> createState() => _DeviceInfoState();
}

class _DeviceInfoState extends State<DeviceInfo> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<IosDeviceInfo> info() async {
    return await deviceInfo.iosInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Device Info'),
        ),
        body: FutureBuilder<IosDeviceInfo>(
            future: info(),
            builder: ((context, snapshot) {
              var iosInfo = snapshot.data;
              if (iosInfo == null) {
                // https: //api.flutter.dev/flutter/widgets/FutureBuilder-class.html
                return const Center(
                    child: CircularProgressIndicator(
                  value: 1.1,
                ));
              } else {
                return GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: [
                    _showDeviceSetting(
                        'Device Name', iosInfo.name!, Colors.orange.shade300),
                    _showDeviceSetting(
                        'Device Model', iosInfo.model!, Colors.yellow.shade400),
                    _showDeviceSetting('Device Sys Name', iosInfo.systemName!,
                        const Color.fromARGB(255, 10, 205, 212)),
                    _showDeviceSetting('Device Version', iosInfo.systemVersion!,
                        Colors.green.shade400),
                    _showDeviceSetting('Device Vendor',
                        iosInfo.identifierForVendor!, Colors.cyanAccent),
                    _showDeviceSetting('Device is Physical',
                        iosInfo.isPhysicalDevice.toString(), Colors.transparent)
                  ],
                );
              }
            })));
  }

  Container _showDeviceSetting(
      String settingName, String settignValue, Color color) {
    return Container(
      // padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(15)),

      child: Center(
        child: ListTile(
          title: Text(
            settingName,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.deepPurple),
          ),
          subtitle: Text(settignValue,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.deepPurple)),
        ),
      ),
    );
  }
}
