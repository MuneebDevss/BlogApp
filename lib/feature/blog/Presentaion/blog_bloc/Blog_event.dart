part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class UploadBlog extends BlogEvent{
  final String posterId;
  final String title;
  final String content;
  final List<String> topic;
  final File imageUrl;
  final String name;

  UploadBlog( {required this.name,required this.posterId, required this.title, required this.content, required this.topic, required this.imageUrl});
}
final class GetBlogs extends BlogEvent
{}

final class UpdateLikesEvent extends BlogEvent{
  final String blogId;
  final bool status;
  UpdateLikesEvent( {required this.status, required this.blogId});
}
//comments events
final class UpdateCommentEvent extends BlogEvent
{
  final String blogId;
  final String comment;

  UpdateCommentEvent({required this.blogId, required this.comment});
}
class GetComments extends BlogEvent {
  final String BlogId;

  GetComments({required this.BlogId});
}
