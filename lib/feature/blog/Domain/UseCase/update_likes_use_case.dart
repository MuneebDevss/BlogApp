import 'package:blog_app/Core/UseCase.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/blog/Domain/repository/blog_respository.dart';
import 'package:fpdart/src/either.dart';

class Likes
{
  final String id;
  final bool status;

  Likes({required this.id, required this.status});
}
class UpdateLikesUseCase implements UseCase<String,Likes> {
  final BlogRespository rep;

  UpdateLikesUseCase({required this.rep});
  @override
  Future<Either<failure, String>> call(Likes params) {
    return rep.updateLikes(params.id, params.status);
  }
}
