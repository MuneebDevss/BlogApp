part of 'Friends_bloc.dart';

@immutable
abstract class FriendsState {}

final class FriendsInitial extends FriendsState {}
final class FriendsLoading extends FriendsState
{}
final class FriendsSuccess extends FriendsState {
  final String id;

  FriendsSuccess({required this.id});
}
final class UsersAchievedState extends FriendsState
{
  final List<UserModel> models;

  UsersAchievedState({required this.models});
}
final class FriendsFailure extends FriendsState {
  final String message;

  FriendsFailure({required this.message});
}
final class FriendsRequestSuccess extends FriendsState {
  final List<FriendRequest> fr;

  FriendsRequestSuccess({required this.fr});




}
