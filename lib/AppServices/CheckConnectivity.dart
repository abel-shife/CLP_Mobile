import 'package:connectivity/connectivity.dart';

class CheckConnection{
  static Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();

    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi)
      return true;
    else
      return false;
  }
}
