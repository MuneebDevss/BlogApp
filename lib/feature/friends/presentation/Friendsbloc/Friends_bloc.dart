

import 'package:blog_app_vs/feature/friends/domain/FriendsUseCase/aor_use_case.dart';
import 'package:blog_app_vs/feature/friends/domain/FriendsUseCase/get_all_Users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Models/user_model.dart';
import '../../domain/Entities/friend_requests.dart';
import '../../domain/FriendsUseCase/add_friends_use_case.dart';
import '../../domain/FriendsUseCase/get_Friend_Requests.dart';

part 'Friends_event.dart';
part 'Friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  final GetAllUsersUseCase _getAllUsersUseCase;
  final AddFriendsUseCase _addFriendsUseCase;
  final GetFriendsRequestUseCase _friendsRequestUseCase;
  final AcceptOrRejectUseCase _acceptOrRejectUseCase;
  FriendsBloc(
  AddFriendsUseCase addFriendsUseCase,
  GetAllUsersUseCase getAllUsersUseCase,
  GetFriendsRequestUseCase getFriendsRequestUseCase,
  AcceptOrRejectUseCase acceptOrRejectUseCase,
      )
      :
       _acceptOrRejectUseCase=acceptOrRejectUseCase,_friendsRequestUseCase=getFriendsRequestUseCase,_getAllUsersUseCase=getAllUsersUseCase,_addFriendsUseCase=addFriendsUseCase, super(FriendsInitial()) {

    on<AddFriendsEvent>(_userSignUp);
    on<GetAllUsersEvent>(_getUser);
    on<GetFriendsRequestEvent>(_getFriendsRequest);
    on<AcceptOrRejectEvent>(_acceptOrReject);

  }
  void  _getUser(GetAllUsersEvent event,Emitter<FriendsState> emit)
  async{
    emit(FriendsLoading());
    final res=await _getAllUsersUseCase.call(Empty());
    res.fold((l) => emit(FriendsFailure(message: l.message)), (r) =>emit(UsersAchievedState(models: r)));
  }void  _getFriendsRequest(GetFriendsRequestEvent event,Emitter<FriendsState> emit)
  async{
    emit(FriendsLoading());
    final res=await _friendsRequestUseCase.call(Empty());
    res.fold((l) => emit(FriendsFailure(message: l.message)), (r) =>emit(FriendsRequestSuccess(fr: r)));
  }
  void  _userSignUp(AddFriendsEvent event,Emitter<FriendsState> emit)
  async{
    emit(FriendsLoading());
    final res=await _addFriendsUseCase.call(AddFriendsParam(id1: event.id1, id2: event.id2));
    res.fold((l) => emit(FriendsFailure(message: l.message)), (r) =>emit(FriendsSuccess(id:r)));
  }
  void  _acceptOrReject(AcceptOrRejectEvent event,Emitter<FriendsState> emit)
  async{
    emit(FriendsLoading());
    final res=await _acceptOrRejectUseCase.call(RequestStatus(id2: event.id2, Status: event.Status));
    res.fold((l) => emit(FriendsFailure(message: l.message)), (r) =>emit(FriendsSuccess(id:r)));
  }
}
