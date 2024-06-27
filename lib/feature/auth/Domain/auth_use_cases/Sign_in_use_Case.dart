import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/auth/Domain/auth_repository/auth_repository.dart';
import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:fpdart/fpdart.dart';

class SignInUseCase implements UseCase<UserModel,Params>
{

  final AuthRepository rep;

  SignInUseCase({required this.rep});


  @override
  Future<Either<failure, UserModel>> call(Params params) async
  {
    return await rep.authLogin(email: params.email, password: params.password);
  }

}
class Params
{
  Params({required this.email,required this.name,required this.password});
  final String name;
  final String email;
  final String password;
}
