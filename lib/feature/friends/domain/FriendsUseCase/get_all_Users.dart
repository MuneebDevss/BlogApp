import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/friends/domain/freinds_repository/friends_repository.dart';
import 'package:fpdart/src/either.dart';
class Empty{}
class GetAllUsersUseCase implements UseCase<List<UserModel>,Empty>{
  final FriendsRepository rep;

  GetAllUsersUseCase({required this.rep});
  @override
  Future<Either<failure, List<UserModel>>> call(Empty params) {
    // TODO: implement call
    return rep.getAllUsersRepo();
  }
}