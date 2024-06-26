import 'package:blog_app/Core/UseCase.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/auth/Domain/auth_repository/auth_repository.dart';
import 'package:blog_app/feature/auth/Domain/auth_use_cases/Sign_in_use_Case.dart';
import 'package:blog_app/Core/Models/user_model.dart';
import 'package:blog_app/feature/auth/data/Repository/repository_impl.dart';
import 'package:fpdart/src/either.dart';

class CurrentUserUseCase implements UseCase<UserModel,Empty>
{
  final AuthRepository repositoryImpl;

  CurrentUserUseCase({required this.repositoryImpl});
  @override
  Future<Either<failure, UserModel>> call(Empty empty) async{
    // TODO: implement call
    return await repositoryImpl.repCurrentUser();
  }

}
class Empty{}