import 'dart:io';

import 'package:blog_app_vs/feature/blog/Domain/Entities/Comments.dart';
import 'package:blog_app_vs/feature/blog/Domain/Entities/blogs.dart';
import 'package:blog_app_vs/feature/blog/Domain/UseCase/log_out_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/UseCase/blog_upload_use_case.dart';
import '../../Domain/UseCase/get_blogs_use_case.dart';
import '../../Domain/UseCase/get_comments_use_Case.dart';
import '../../Domain/UseCase/update_Comments_UseCase.dart';
import '../../Domain/UseCase/update_likes_use_case.dart';

part 'Blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUploadUseCase _blogUploadUseCase;
  final GetBlogsUseCase _getBlogsUseCase;
  final LogOutUseCase _logOutUseCase;
  final UpdateLikesUseCase _updateLikesUseCase;
  final UpdateCommentsUseCase _commentsUseCase;
  final GetCommentsUseCase _getCommentsUseCase;
  //Contructor
  BlogBloc({
    required LogOutUseCase logOutUseCase,
    required BlogUploadUseCase blogUploadUseCase,
    required GetBlogsUseCase getBlogsUseCase,
    required UpdateLikesUseCase updateLikesUseCase,
    required UpdateCommentsUseCase commentsUseCase,
    required GetCommentsUseCase getCommentsUseCase,
  })  : _getCommentsUseCase = getCommentsUseCase,
        _commentsUseCase = commentsUseCase,
        _updateLikesUseCase = updateLikesUseCase,
        _logOutUseCase = logOutUseCase,
        _getBlogsUseCase = getBlogsUseCase,
        _blogUploadUseCase = blogUploadUseCase,
        super(BlogInitial()) {
    //Event Handling

    on<UploadBlog>((event, emit) async {
      emit(BlogLoading());
      final res = await _blogUploadUseCase.call(BlogParam(
          posterId: event.posterId,
          title: event.title,
          content: event.content,
          topic: event.topic,
          imageUrl: event.imageUrl,
          name: event.name));
      res.fold((l) {
        emit(BlogFailure(message: l.message));
      }, (r) => emit(BlogSuccess(id: r)));
    });
    
    on<GetBlogs>((event, emit) async {
      emit(BlogLoading());
      final res = await _getBlogsUseCase.call(Empty());
      res.fold((l) => emit(AchievementFailureState(message: l.message)), (r) {
        emit(BlogsAchieved(blogs: r));
      });
    });
    on<UpdateLikesEvent>((event, emit) async {
      final res = await _updateLikesUseCase
          .call(Likes(id: event.blogId, status: event.status));
      res.fold((l) => emit(AchievementFailureState(message: l.message)), (r) {
        emit(LikesUpdatedState(Updated: r));
      });
    });
    on<UpdateCommentEvent>((event, emit) async {
      final res = await _commentsUseCase
          .call(CommentParam(blogId: event.blogId, Comment: event.comment));
      res.fold((l) => emit(CommentsNotUpdatedState(message: l.message)), (r) {
        emit(CommentsUpdatedState(comment: r));
      });
    });
    on<GetComments>((event, emit) async {
      emit(BlogLoading());
      final res = await _getCommentsUseCase.call(event.BlogId);
      res.fold((l) => emit(CommentsNotAchievedState(message: l.message)),
          (r) => emit(CommentsAchievedState(r)));
    });
  }
}
