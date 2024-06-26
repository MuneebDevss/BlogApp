import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker
{
  Future<bool> get connected;
}
class ConnectionImpl implements ConnectionChecker{
  final InternetConnection internetConnection;

  ConnectionImpl({required this.internetConnection});
  @override

  Future<bool> get connected async =>internetConnection.hasInternetAccess;
}