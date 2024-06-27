import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/auth/Domain/auth_repository/auth_repository.dart';

import 'package:blog_app_vs/Core/Models/user_model.dart';

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