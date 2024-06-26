import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/blog/Domain/Entities/blogs.dart';
import 'package:blog_app/feature/blog/Domain/repository/blog_respository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../Core/UseCase.dart';

class Empty{}
class GetBlogsUseCase implements UseCase<List<Blog>,Empty>{
  final BlogRespository impl;

  GetBlogsUseCase({required this.impl});
  @override
  Future<Either<failure, List<Blog>>> call(Empty params) async {
    return await impl.getAllBlogsRep();
  }
}