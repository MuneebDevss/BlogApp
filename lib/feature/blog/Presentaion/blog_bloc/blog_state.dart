part of 'blog_bloc.dart';


abstract class BlogState {

}

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
//Logout States

//comment States
class CommentsAchievedState extends BlogState{
  final List<Comments> comments;

  CommentsAchievedState(this.comments);
}
class CommentsNotAchievedState extends BlogState
{
  final String message;

  CommentsNotAchievedState({required this.message});
}
class CommentsUpdatedState extends BlogState
{
  final Comments comment;

  CommentsUpdatedState({required this.comment});
}
class CommentsNotUpdatedState extends BlogState
{
  final String message;

  CommentsNotUpdatedState({required this.message});
}