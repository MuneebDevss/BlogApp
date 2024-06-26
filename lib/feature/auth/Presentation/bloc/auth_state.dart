part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState
{}
final class AuthSuccess extends AuthState {
  final User id;

  AuthSuccess({required this.id});
}

final class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});
}
