import 'package:blog_app_vs/Core/Cubits/user_cubit.dart';
import 'package:blog_app_vs/feature/auth/Domain/auth_use_cases/Sign_in_use_Case.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Entities/User.dart';
import '../../Domain/auth_use_cases/current_user_use_case.dart';
import '../../Domain/auth_use_cases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final UserCubit _userCubit;

  final CurrentUserUseCase _currentUserUseCase;
  AuthBloc(
      UserCubit userCubit,
      SignUpUseCase signUpUseCase
      ,SignInUseCase signInUseCase,
      CurrentUserUseCase currentUserUseCase
      )
      : _userCubit=userCubit,_currentUserUseCase=currentUserUseCase,_signUpUseCase = signUpUseCase,_signInUseCase=signInUseCase,
        super(AuthInitial()) {
    on<BlocLogin>((event, emit) async {
      emit(AuthLoading());
      final res = await _signInUseCase.call(
          Params(
            email: event.email,
            password: event.password, name: '',
          ));
      res.fold(
            (l) => emit(AuthFailure(message: l.message)),
            (r) => _userCheck(emit,r),
      );
    });
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());
      final res = await _signUpUseCase.call(
          Params(
        email: event.email,
        name: event.name,
        password: event.password,
      ));
      res.fold(
            (l) => emit(AuthFailure(message: l.message)),
            (r) => _userCheck(emit,r),
      );
    });
    on<BlocCurrentUser>(_userSignUp);

  }
  void  _userSignUp(BlocCurrentUser event,Emitter<AuthState> emit)
  async{
    emit(AuthLoading());
    final res=await _currentUserUseCase.call(Empty());
    res.fold((l) => emit(AuthFailure(message: l.message)), (r) =>_userCheck(emit,r));
  }
  void _userCheck(Emitter<AuthState> emit,User user)
  {
    _userCubit.users(user);
    emit(AuthSuccess(id:user));
  }

}
