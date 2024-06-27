import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/friends/domain/freinds_repository/friends_repository.dart';
import 'package:fpdart/src/either.dart';

class AddFriendsParam{
  final String id1;
  final String id2;

  AddFriendsParam({required this.id1, required this.id2});
}
class AddFriendsUseCase implements UseCase<String,AddFriendsParam>{
  final FriendsRepository rep;

  AddFriendsUseCase({required this.rep});
  @override
  Future<Either<failure, String>> call(AddFriendsParam params)
  {
  return rep.addFriendsRep(params.id1, params.id2);
  }
}