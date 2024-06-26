import 'Likes.dart';

class Blog {
  final String id;
  final DateTime updatedAt;
  final String posterId;
  final String title;
  final String content;
  final List<String> topic;
  final String imageUrl;
  final String uploaderName;
  List<Likes> likes;

  Blog( {
    required this.likes,
    required this.uploaderName,
    required this.id,
    required this.updatedAt,
    required this.posterId,
    required this.title,
    required this.content,
    required this.topic,
    required this.imageUrl,
  });



}

