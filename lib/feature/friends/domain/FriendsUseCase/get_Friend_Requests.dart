import 'package:blog_app/Core/UseCase.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/friends/domain/Entities/friend_requests.dart';
import 'package:fpdart/fpdart.dart';

import '../freinds_repository/friends_repository.dart';
import 'get_all_Users.dart';

class GetFriendsRequestUseCase implements UseCase<List<FriendRequest>,Empty>{
  final FriendsRepository rep;

  GetFriendsRequestUseCase({required this.rep});
  @override
  Future<Either<failure, List<FriendRequest>>> call(Empty params) {
    // TODO: implement call
    return rep.getFriendRequests();
  }
}