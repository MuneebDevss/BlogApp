import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:blog_app_vs/Core/errors/exception.dart';
import 'package:blog_app_vs/feature/friends/data/Entities/friend_request_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class FriendsRemoteDataSource
{
  Session? get CurrentUserSession;
  Future<void> addFriends(String firstId,String secondId);
  Future<List<UserModel>> getAllUsers();
  Future<List<FriendRequestImpl>> getRequests();
  Future<void> acceptOrReject(String id2,bool status);
}
class FriendsDataSourceImplementation implements FriendsRemoteDataSource {
  final SupabaseClient client;

  FriendsDataSourceImplementation({required this.client});
  @override
  Future<void> addFriends(String firstId, String secondId) async {
    try{
      await client.rpc('add_friends', params: {'param1': firstId,'param2': secondId,});
    }
    catch(e)
    {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    // TODO: implement getUser
    try {

        final currentUser = await client.rpc('get_users',params: {'param1':CurrentUserSession!.user.id});
        if(currentUser is List) {
          final models=currentUser.map((e) => UserModel.fromJson(e as Map<String,dynamic>)).toList();
          return models;
        }
        else {
          throw const ServerException("Unexpected Format");
        }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FriendRequestImpl>> getRequests() async {
    try {
      final currentUser = await client.rpc('get_friend_requests', params: {'param1': CurrentUserSession!.user.id});

      // Ensure that the result is a List of Maps
      if (currentUser is List) {
        final models = currentUser.map((e) => FriendRequestImpl.fromJson(e as Map<String, dynamic>)).toList();
        return models;
      } else {
        throw const ServerException("Unexpected response format");
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }


  @override
  // TODO: implement CurrentUserSession
  Session? get CurrentUserSession => client.auth.currentSession;

  @override
  Future<void> acceptOrReject( String id2, bool status) async {
    try {
      if(status==true) {
         await client.rpc('accept_request',
          params: {'param1': CurrentUserSession!.user.id,'param2':id2});
      }
      else
      {
        await client.rpc('cancel_request',
            params: {'param1': CurrentUserSession!.user.id,'param2':id2});
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
