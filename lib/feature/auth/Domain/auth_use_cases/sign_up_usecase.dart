import 'package:blog_app/Core/UseCase.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/auth/Domain/auth_repository/auth_repository.dart';
import 'package:blog_app/Core/Models/user_model.dart';
import 'package:fpdart/fpdart.dart';

import 'Sign_in_use_Case.dart';

class SignUpUseCase implements UseCase<UserModel,Params>
{

  final AuthRepository rep;

  SignUpUseCase({required this.rep});


  @override
  Future<Either<failure, UserModel>> call(Params params) async
  {
    return await rep.authSignUp(name: params.name, email: params.email, password: params.password);
  }
  
}
