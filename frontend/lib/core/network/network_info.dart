import 'dart:io';
// import 'package:data_connection_checker/data_connection_checker.dart';

// ignore: one_member_abstracts
abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImplementation implements NetworkInfo {
  // final DataConnectionChecker connectionChecker;

  // NetworkInfoImplementation(this.connectionChecker);

  @override
  Future<bool> isConnected() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      return response.isNotEmpty;
    } on SocketException {
      return false;
    } catch (error) {
      return false;
    }
  }
}
