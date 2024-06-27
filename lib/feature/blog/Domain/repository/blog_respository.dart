import 'dart:io';

import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/blog/Domain/Entities/blogs.dart';

import 'package:fpdart/fpdart.dart';

import '../Entities/Comments.dart';

abstract interface class BlogRespository
{
  Future<Either<failure,Blog>> uploadBlogRep({
    required String posterId,
    required String title,
    required String content,
    required List<String> topic,
    required String name,
    required File imageUrl,});

  Future<Either<failure,List<Blog>>> getAllBlogsRep();
  Future<Either<failure,List<Comments>>> getComments(String blogId);
  Future<Either<failure,String>> logOutRep();
  Future<Either<failure,String>> updateLikes(String blogId,bool status);
  Future<Either<failure,Comments>> updateComments(String blogId,String comment);

}