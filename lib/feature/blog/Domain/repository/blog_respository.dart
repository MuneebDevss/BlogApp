import 'dart:io';

import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/blog/Domain/Entities/blogs.dart';
import 'package:blog_app/feature/blog/Domain/Entities/friends.dart';
import 'package:fpdart/fpdart.dart';

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
  Future<Either<failure,String>> logOutRep();
  Future<Either<failure,String>> updateLikes(String blogId,bool status);
}