

import 'dart:io';

import 'package:blog_app/feature/blog/Domain/Entities/blogs.dart';
import 'package:blog_app/feature/blog/Domain/UseCase/log_out_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/UseCase/blog_upload_use_case.dart';
import '../../Domain/UseCase/get_blogs_use_case.dart';
import '../../Domain/UseCase/update_likes_use_case.dart';

part 'Blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogUploadUseCase _blogUploadUseCase;
  GetBlogsUseCase _getBlogsUseCase;
  LogOutUseCase _logOutUseCase;
  UpdateLikesUseCase _updateLikesUseCase;
  //Contructor
  BlogBloc(
  {

    required LogOutUseCase logOutUseCase,
    required BlogUploadUseCase blogUploadUseCase,
    required GetBlogsUseCase getBlogsUseCase,
    required UpdateLikesUseCase updateLikesUseCase,
  })
      :
       _updateLikesUseCase=updateLikesUseCase,_logOutUseCase=logOutUseCase,_getBlogsUseCase=getBlogsUseCase, _blogUploadUseCase=blogUploadUseCase,super(BlogInitial()) {
    //Event Handling

    on<UploadBlog>((event,emit)
    async{
      emit(BlogLoading());
      final res= await _blogUploadUseCase.call(BlogParam(posterId: event.posterId, title: event.title, content: event.content, topic: event.topic, imageUrl: event.imageUrl, name: event.name));
      res.fold((l) {
        emit(BlogFailure(message: l.message));
      }, (r)=> emit(BlogSuccess(id: r)));
    });
    on<BlocLogOut>((event,emit)
    async {
      final res= await _logOutUseCase.call(Empty());
      res.fold((l) => emit(LogOutFailureState( message: l.message)), (r) => emit(LogOutSuccessState(message: 'success')));
    });
    on<GetBlogs>(
        (event,emit)
        async {
          final res= await _getBlogsUseCase.call(Empty());
          res.fold((l) => emit(AchievementFailureState(message: l.message)), (r) { emit(LogOutSuccessState(message: ""));emit(BlogsAchieved( blogs: r));});
        }
    );
    on<UpdateLikesEvent>(
        (event,emit)
        async {
          final res= await _updateLikesUseCase.call(Likes(id: event.blogId, status: event.status));
          res.fold((l) => emit(AchievementFailureState(message: l.message)), (r) { emit(LikesUpdatedState(Updated: r));});
        }
    );
  }
}
