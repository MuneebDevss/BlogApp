part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

final class BlogInitial extends BlogState {}
final class BlogLoading extends BlogState
{}
final class BlogSuccess extends BlogState {
  final Blog id;

  BlogSuccess({required this.id});
}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure({required this.message});
}
final class BlogsAchieved extends BlogState
{
final List<Blog> blogs;

  BlogsAchieved({required this.blogs});
}
final class LikesUpdatedState extends BlogState
{
  final String Updated;

  LikesUpdatedState({required this.Updated});
}
final class AchievementFailureState extends BlogState
{
  final String message;

  AchievementFailureState({required this.message});
}
final class LogOutSuccessState extends BlogState
{
  final String message;

  LogOutSuccessState({required this.message});
}
final class LogOutFailureState extends BlogState{
  final String message;

  LogOutFailureState({required this.message});
}