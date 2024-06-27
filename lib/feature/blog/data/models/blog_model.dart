import 'package:blog_app_vs/feature/blog/Domain/Entities/Likes.dart';


import '../../Domain/Entities/blogs.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.updatedAt,
    required super.posterId,
    required super.title,
    required super.content,
    required super.topic,
    required super.imageUrl, required super.uploaderName,
    required super.likes,


  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      updatedAt: json['updated_at'] == null ? DateTime.now() : DateTime.parse(json['updated_at']),
      posterId: json['poster_id'],
      title: json['title'],
      content: json['content'],
      topic:  List<String>.from(json['topic'] ??[]),
      imageUrl: json['image_url'],
      uploaderName: 'name',  likes: [],

    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'poster_id': posterId,
      'title': title,
      'content': content,
      'topic': topic,
      'image_url': imageUrl,
      'name':uploaderName,
      'likes':likes
    };
  }

  BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? posterId,
    String? title,
    String? content,
    List<String>? topic,
    String? imageUrl,
    String? UploaderName,
    List<Likes>? likes,
  }) {
    return BlogModel(
      uploaderName: UploaderName?? this.uploaderName,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      topic: topic ?? this.topic,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes?? this.likes,
    );
  }
}
