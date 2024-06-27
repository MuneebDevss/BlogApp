
import 'package:blog_app_vs/feature/blog/Domain/UseCase/log_out_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/UseCase/get_blogs_use_case.dart';



part 'logout_event.dart';
part 'log_outState.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  
  final LogOutUseCase _logOutUseCase;
  
  //Contructor
  LogOutBloc({
    required LogOutUseCase logOutUseCase,
    
  })  : 
        _logOutUseCase = logOutUseCase,
        
        super(LogOutInitial()) {
    //Event Handling

    on<LogOutEvent>((event, emit) async {
      final res = await _logOutUseCase.call(Empty());
      res.fold((l) => emit(LogOutFailureState(message: l.message)),
          (r) => emit(LogOutSuccessState(message: 'success')));
    });
    
  }
}
