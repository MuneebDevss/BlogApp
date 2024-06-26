import 'dart:io';


import 'package:blog_app/Core/errors/exception.dart';
import 'package:blog_app/feature/blog/data/models/friends_model.dart';
import 'package:blog_app/feature/blog/data/models/like_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/blog_model.dart';

abstract interface class BlogRemoteDataSource
{
  Future<BlogModel> uploadBlog(BlogModel model);
  Future<String> uploadImage( File image,  BlogModel bm);
  Future<List<BlogModel>> getAllBlogs();
  Future<String> logOut();
  Future<List<FriendsModel>> getFriends();
  Future<String> updateLikes(String blogId,bool status);
  Future<List<LikeModel>> getLikes(String blogId);
}
class BlogRemoteDataSourceImpl implements BlogRemoteDataSource{

  final SupabaseClient client;

  BlogRemoteDataSourceImpl({required this.client});
  Session? get CurrentUserSession => client.auth.currentSession;
  @override
  Future<BlogModel> uploadBlog(BlogModel model) async
  {
    try{
      final res=await client.from('blogs').insert(model.toJson()).select();
      return BlogModel.fromJson(res.first);
    }
    catch(e){
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage(File image, BlogModel bm) async {
    try{
      final res=await client.storage.from('blog_image').upload(bm.id, image);
      return client.storage.from('blog_image').getPublicUrl(bm.id);
    }
        catch(e){
      throw ServerException(e.toString());
        }
  }
  @override
  Future<String> logOut() async {
    try{
      await client.auth.signOut();
      return "login";
    }
    catch (e)
    {
      throw ServerException(e.toString());
    }
  }
  @override
  Future<List<BlogModel>> getAllBlogs() async{
   try{
     final res= await client.from('blogs').select('*,profiles(name)');
     return res.map((blog) => BlogModel.fromJson(blog).copyWith(UploaderName: blog['profiles']['name'])).toList();
   }
   catch(e)
   {
     throw ServerException(e.toString());
   }
  }

  @override
  Future<List<FriendsModel>> getFriends() async {
    try {
      final res = await client.rpc('get_friends', params: {'param1': CurrentUserSession!.user.id});

      // Assuming 'res' is a list of maps with 'friend' key
      if (res is List) {
        final friends = res.map((friendData) => FriendsModel.fromJson(friendData as Map<String, dynamic>)).toList();
        return friends;
      }

      else{
    throw const ServerException("Unexpected response format");
    }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> updateLikes(String blogId,bool status) async {
    try{
      if(status==true) {
        await client.rpc('update_likes',params: {'blogid':blogId,'likedby':CurrentUserSession!.user.id});
      }
      else
        {
          await client.rpc('remove_like',params: {'blogid':blogId,'likedby':CurrentUserSession!.user.id});
        }
      return "Logged";
    }
    catch (e)
    {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<LikeModel>> getLikes(String blogId) async {
    try
    {
   final res=await client.rpc('get_likes',params: {'blogid':blogId,'likedby':CurrentUserSession!.user.id});
   if(res is List) {
     final likes=res.map((e) => LikeModel.fromjson(e)).toList();
     return likes;
   }
   else {
     throw const ServerException('Failed fetching likes');
   }
  }
  catch (e)
  {
  throw ServerException(e.toString());
  }
  }
}
