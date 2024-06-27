import '../../Domain/Entities/Comments.dart';

class CommentModel extends Comments {
  CommentModel(
      {required super.uploaderId,
      required super.name,
      required super.blogId,
      required super.comment,
      required super.uploadedAt});
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        name: json['profiles']['name'],
        blogId: json['blog_id'],
        comment: json['comment'],
        uploadedAt: json['update_at'],
        uploaderId: '');
  }
  Map<String, dynamic> tojson() {
    return {
      'blog_id': blogId,
      'comment': comment,
      'update_at': uploadedAt,
      'comment_by':uploaderId
    };
  }
}
