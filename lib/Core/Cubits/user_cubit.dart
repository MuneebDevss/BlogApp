import 'package:blog_app_vs/Core/Entities/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cubit_state.dart';

class UserCubit extends Cubit<CubitState> {
  UserCubit() : super(CubitInitial());
  void users(User? user) {
    if (user == null) {
      emit(CubitInitial());
    } else {
      emit(CubitLogin(user: user));
    }
  }
}
