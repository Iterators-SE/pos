import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementation implements NetworkInfo {
  final DataConnectionChecker connectionChecker;

  NetworkInfoImplementation(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}