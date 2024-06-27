import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/blog/Domain/repository/blog_respository.dart';

import 'package:fpdart/src/either.dart';

import '../../../../Core/UseCase.dart';
import 'get_blogs_use_case.dart';

class LogOutUseCase implements UseCase<String,Empty>{
  final BlogRespository impl;

  LogOutUseCase({required this.impl});
  @override
  Future<Either<failure, String>> call(Empty params) {
    return impl.logOutRep();
  }
}