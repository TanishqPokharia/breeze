import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isDeviceOnline() async {
  try {
    final List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();

    // If any type of connection exists, device is online
    return !connectivityResult.contains(ConnectivityResult.none);
  } catch (e) {
    // In case of error, assume offline
    return false;
  }
}
