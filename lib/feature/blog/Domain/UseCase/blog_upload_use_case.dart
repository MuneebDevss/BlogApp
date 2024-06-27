import 'dart:io';
import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/blog/Domain/repository/blog_respository.dart';
import 'package:fpdart/fpdart.dart';
import '../Entities/blogs.dart';

class BlogUploadUseCase implements UseCase<Blog, BlogParam> {
  final BlogRespository rep;

  BlogUploadUseCase({required this.rep});

  @override
  Future<Either<failure, Blog>> call(BlogParam params) async {
    return await rep.uploadBlogRep(
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      topic: params.topic,
      imageUrl: params.imageUrl, name:params.name,
    );
  }
}

class BlogParam {
  final String posterId;
  final String title;
  final String content;
  final List<String> topic;
  final File imageUrl;
  final String name;

  BlogParam({required this.posterId, required this.title, required this.content, required this.topic, required this.imageUrl, required this.name});

}
