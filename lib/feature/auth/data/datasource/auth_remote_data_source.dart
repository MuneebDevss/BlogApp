import 'package:blog_app/Core/errors/exception.dart';
import 'package:blog_app/Core/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource {
  Session? get CurrentUserSession;
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> logIn({
    required String email,
    required String password,
  });
  Future<UserModel?> getUser();
}

class Auth implements AuthDataSource {
  final SupabaseClient supabaseClient;

  const Auth({
    required this.supabaseClient,
  });

  @override
  Future<UserModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw const ServerException('User is null');
        print('Supabase SignUp Error:');
      }
      print('SignUp successful: ${response.user!.id}');
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      print('SignUp failed: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {
          'name': name,
        },
      );
      
      if (response.user == null) {
        throw const ServerException('User is null');
        print('Supabase SignUp Error:');
      }
      print('SignUp successful: ${response.user!.id}');
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      print('SignUp failed: $e');
      throw ServerException(e.toString());
    }
  }

  @override
  // TODO: implement CurrentUserSession
  Session? get CurrentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getUser() async {
    // TODO: implement getUser
    try {
      if (CurrentUserSession != null) {
        final currentUser = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', CurrentUserSession!.user.id);
        return UserModel.fromJson(currentUser.first);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
