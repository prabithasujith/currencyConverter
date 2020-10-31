import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfo {
  DataConnectionChecker checker = DataConnectionChecker();
  bool isConnected;

  Future<bool> isNetworkConnected() async {
    isConnected = await checker.hasConnection;
    return isConnected;
  }
}
