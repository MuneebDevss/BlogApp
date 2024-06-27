import 'package:blog_app_vs/Core/errors/exception.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/Core/network/connection_checker.dart';
import 'package:blog_app_vs/feature/auth/Domain/auth_repository/auth_repository.dart';
import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../datasource/auth_remote_data_source.dart';

class RepositoryImpl implements AuthRepository {
  final Auth data;
  final ConnectionChecker checker;
  const RepositoryImpl( {required this.checker,required this.data});

  @override
  Future<Either<failure, UserModel>> authLogin({
    required String email,
    required String password,
  })
  async{
    return await _get(() => data.logIn(email: email, password: password));
  }

  @override
  Future<Either<failure, UserModel>> authSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _get(() => data.signUp(name: name, email: email, password: password));
  }

  @override
  Future<Either<failure, UserModel>> repCurrentUser() async{
    try{
      final res=await data.getUser();
      // if(!await checker.connected) {
      //   final session=data.CurrentUserSession;
      //   if(session!=null) {
      //     return Right(UserModel(id: session.user.id, email: session.user.email??'', name: ''));
      //   }
      //   return Left(failure('No internet Connection'));
      // }
      if(res!=null)
        {
          return Right(res);
        }
      return Left(failure('User is not signed in'));
    }
        on ServerException catch(e)
        {
          return Left(failure(e.message));
        }
  }
  Future<Either<failure, UserModel>> _get(
      Future<UserModel> Function() f,
      ) async {
    try {
      if(!await checker.connected) {
        return Left(failure('No internet Connection'));
      }
      final id = await f();
      return Right(id);

    }
    on AuthException catch(e)
    {
      return Left(failure(e.message));
    }
    on ServerException catch (e) {
      return Left(failure(e.message));
    }
  }



}
