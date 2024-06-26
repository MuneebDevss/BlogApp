
part of 'user_cubit.dart';





@immutable
abstract class CubitState {}

final class CubitInitial extends CubitState {}
final class CubitLogin extends CubitState
{
  final User user;

  CubitLogin( {required this.user});
}

