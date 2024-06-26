import 'dart:async';

import 'package:blog_app/Core/Models/user_model.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/friends/domain/Entities/friend_requests.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class FriendsRepository
{
  Future<Either<failure,String>> addFriendsRep(String firstId,String secondId);
  Future<Either<failure,List<UserModel>>> getAllUsersRepo();
  Future<Either<failure,List<FriendRequest>>> getFriendRequests();
  Future<Either<failure,String>> acceptOrRejectRequest(String id2,bool Status);
}