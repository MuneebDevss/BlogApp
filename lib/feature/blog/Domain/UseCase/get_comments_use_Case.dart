import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/blog/Domain/repository/blog_respository.dart';
import 'package:fpdart/src/either.dart';

import '../Entities/Comments.dart';

class GetCommentsUseCase implements UseCase<List<Comments>,String>{
  final BlogRespository rep;

  GetCommentsUseCase({required this.rep});
  @override
  Future<Either<failure, List<Comments>>> call(String params) {
    return rep.getComments(params);

  }
}