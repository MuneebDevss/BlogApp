import 'dart:io';

import 'package:blog_app/feature/blog/Domain/Entities/friends.dart';
import 'package:blog_app/feature/blog/data/models/friends_model.dart';
import 'package:blog_app/feature/blog/data/models/like_model.dart';
import 'package:uuid/uuid.dart';
import 'package:blog_app/Core/errors/exception.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/blog/Domain/Entities/blogs.dart';
import 'package:blog_app/feature/blog/Domain/repository/blog_respository.dart';
import 'package:blog_app/feature/blog/data/models/blog_model.dart';
import 'package:blog_app/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:fpdart/fpdart.dart';

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
       List<LikeModel> likes=await impl.getLikes(model.id);

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
}
