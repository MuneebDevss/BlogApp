part of 'Friends_bloc.dart';

@immutable
sealed class FriendsEvent {}

final class AddFriendsEvent extends FriendsEvent {
  final String id1;
  final String id2;

  AddFriendsEvent({required this.id1, required this.id2});

}final class GetAllUsersEvent extends FriendsEvent
{
}final class GetFriendsRequestEvent extends FriendsEvent
{
}

final class AcceptOrRejectEvent extends FriendsEvent
{
  final String id2;
  final bool Status;

  AcceptOrRejectEvent({required this.id2, required this.Status});
}