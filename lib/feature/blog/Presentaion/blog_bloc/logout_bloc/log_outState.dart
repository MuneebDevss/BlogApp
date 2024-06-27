part of 'logout_bloc.dart';


abstract class LogOutState {

}

final class LogOutInitial extends LogOutState {}
final class LogOutLoading extends LogOutState
{}
final class LogOutSuccessState extends LogOutState
{
  final String message;

  LogOutSuccessState({required this.message});
}
final class LogOutFailureState extends LogOutState{
  final String message;

  LogOutFailureState({required this.message});
}