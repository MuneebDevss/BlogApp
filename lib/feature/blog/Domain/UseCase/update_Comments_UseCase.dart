import 'package:blog_app_vs/Core/UseCase.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/blog/Domain/repository/blog_respository.dart';
import 'package:blog_app_vs/feature/blog/data/blog_rep_impl/blog_rep_imp.dart';
import 'package:fpdart/src/either.dart';

import '../Entities/Comments.dart';
class CommentParam
{
  final String blogId;
  final String Comment;

  CommentParam({required this.blogId, required this.Comment});
}
class UpdateCommentsUseCase implements UseCase<Comments,CommentParam>{
  final BlogRespository impl;

  UpdateCommentsUseCase({required this.impl});
  @override
  Future<Either<failure, Comments>> call(CommentParam params) async {

    return await impl.updateComments(params.blogId, params.Comment);
  }
}