
import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:fpdart/fpdart.dart';

import "package:blog_app_vs/Core/errors/failure.dart";
abstract interface class AuthRepository
{
  //arguments

Future<Either<failure,UserModel>> authLogin({

  required String email,
  required String password,
});
Future<Either<failure,UserModel>> repCurrentUser();
Future<Either<failure,UserModel>> authSignUp(
    {
      required String name,
      required String email,
      required String password,
}
    );
}