import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

class NetworkInfoImplementation {
  NetworkInfoImplementation._internal();

  static final NetworkInfoImplementation _singleton =
      NetworkInfoImplementation._internal();

  static NetworkInfoImplementation getInstance() => _singleton;

  Future<bool> isConnected() async {
    // TODO: NOTE THAT THIS METHOD WILL NOT WORK ON WEB DUE TO DATACONNECTIONCHECKER PACKAGE
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult != ConnectivityResult.none) {
        return await DataConnectionChecker().hasConnection;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
