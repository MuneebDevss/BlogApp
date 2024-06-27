import 'dart:io';

import 'package:blog_app_vs/Core/errors/exception.dart';
import 'package:blog_app_vs/feature/blog/Domain/Entities/Comments.dart';
import 'package:blog_app_vs/feature/blog/data/models/CommentModel.dart';
import 'package:blog_app_vs/feature/blog/data/models/friends_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Domain/Entities/Likes.dart';
import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel model);
  Future<String> uploadImage(File image, BlogModel bm);
  Future<List<BlogModel>> getAllBlogs();
  Future<String> logOut();
  Future<List<FriendsModel>> getFriends();
  Future<String> updateLikes(String blogId, bool status);
  Future<List<Likes>> getLikes(String blogId);
  Future<CommentModel> updateComments(String blogId, String comment);
  Future<List<Comments>> getComments(String blogId);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImpl({required this.client});
  Session? get CurrentUserSession => client.auth.currentSession;
  @override
  Future<BlogModel> uploadBlog(BlogModel model) async {
    try {
      final res = await client.from('blogs').insert(model.toJson()).select();
      return BlogModel.fromJson(res.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage(File image, BlogModel bm) async {
    try {
      final res = await client.storage.from('blog_image').upload(bm.id, image);
      return client.storage.from('blog_image').getPublicUrl(bm.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> logOut() async {
    try {
      await client.auth.signOut();
      return "login";
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final res = await client.from('blogs').select('*,profiles(name)');
      return res
          .map((blog) => BlogModel.fromJson(blog)
              .copyWith(UploaderName: blog['profiles']['name']))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FriendsModel>> getFriends() async {
    try {
      final res = await client
          .rpc('get_friends', params: {'param1': CurrentUserSession!.user.id});

      // Assuming 'res' is a list of maps with 'friend' key
      if (res is List) {
        final friends = res
            .map((friendData) =>
                FriendsModel.fromJson(friendData as Map<String, dynamic>))
            .toList();
        return friends;
      } else {
        throw const ServerException("Unexpected response format");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> updateLikes(String blogId, bool status) async {
    try {
      if (status == true) {
        await client.rpc('update_likes',
            params: {'blogid': blogId, 'likedby': CurrentUserSession!.user.id});
      } else {
        await client.rpc('remove_like',
            params: {'blogid': blogId, 'likedby': CurrentUserSession!.user.id});
      }
      return "Logged";
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<Likes>> getLikes(String blogId) async {
    try {
      final res = await client.rpc('get_likes', params: {'blogid': blogId});
      if (res is List) {
        final likes = res.map((e) => Likes.fromjson(e)).toList();
        return likes;
      } else {
        throw const ServerException('Failed fetching likes');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<CommentModel> updateComments(String blogID, String comment) async {
    try {
      final res = CommentModel(
          name: '',
          blogId: blogID,
          comment: comment,
          uploadedAt: DateTime.now().toString(),
          uploaderId: CurrentUserSession!.user.id);
      final re = await client.from('comments').insert(res.tojson());
      return res;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CommentModel>> getComments(String blogId) async {
    try {
      final res =
          await client.from('comments').select('* ,profiles(name)').eq('blog_id', blogId);
      return res.map((e) => CommentModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
