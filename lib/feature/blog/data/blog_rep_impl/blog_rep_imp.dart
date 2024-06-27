import 'dart:io';

import 'package:blog_app_vs/feature/blog/Domain/Entities/Comments.dart';
import 'package:blog_app_vs/feature/blog/Domain/Entities/friends.dart';
import 'package:blog_app_vs/feature/blog/data/models/CommentModel.dart';

import 'package:uuid/uuid.dart';
import 'package:blog_app_vs/Core/errors/exception.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/blog/Domain/Entities/blogs.dart';
import 'package:blog_app_vs/feature/blog/Domain/repository/blog_respository.dart';
import 'package:blog_app_vs/feature/blog/data/models/blog_model.dart';
import 'package:blog_app_vs/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

import '../../Domain/Entities/Likes.dart';

class BlogRepImpl implements BlogRespository {
  final BlogRemoteDataSourceImpl impl;

  BlogRepImpl({required this.impl});

  @override

  Future<Either<failure, Blog>> uploadBlogRep({
    required String posterId,
    required String title,
    required String content,
    required List<String> topic,
    required File imageUrl,
    required String name,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        updatedAt: DateTime.now(),
        posterId: posterId,
        title: title,
        content: content,
        topic: topic,
        imageUrl: '',
        uploaderName: name, likes: [],
      );
      final image = await impl.uploadImage(imageUrl, blogModel);
      blogModel = blogModel.copyWith(imageUrl: image);
      final model = await impl.uploadBlog(blogModel);
      return Right(model);
    } on ServerException catch (e) {
      return Left(failure(e.message));
    }
  }
  @override
  Future<Either<failure, String>> logOutRep() async {
    try{
      final res=await impl.logOut();
      return Right(res);
    }
    on ServerException catch(e){
      return Left(failure(e.message));
    }
  }
  @override
  Future<Either<failure, List<Blog>>> getAllBlogsRep()
  async {
   try{
     final List<BlogModel> res=await impl.getAllBlogs();
     final friends=await impl.getFriends();
     List<BlogModel> models=[];
     for(BlogModel model in res)
     {
       for(Friends friend in friends) {
         if(friend.id==model.posterId)
       {
         models.add(model);
       }
       }
     }
     for(BlogModel model in res)
     {
       List<Likes> likes=await impl.getLikes(model.id);
       model.likes=likes;
     }
     return Right(models);
      }
       on ServerException catch(e)
       {
         return Left(failure(e.message));
       }
  }

  @override
  Future<Either<failure, String>> updateLikes(String blogId,bool status) async {
    try{
      final res=await impl.updateLikes(blogId,status);
      return Right(res);
    }
    on ServerException catch(e){
      return Left(failure(e.message));
    }
  }

  @override
  Future<Either<failure, CommentModel>> updateComments(String blogId, String comment) async {
   try{
     final res=await impl.updateComments(blogId, comment);
     return Right(res);
   }
       on ServerException catch(e)
       {
         return Left(failure(e.message));
       }
  }

  @override
  Future<Either<failure, List<Comments>>> getComments(String blogId) async {
    // TODO: implement getComments
    try{
      final res=await impl.getComments(blogId);
      return Right(res);
    }
        on ServerException catch(e)
        {
          return Left(failure(e.message));
        }
  }
}
