import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:blog_app_vs/Core/errors/exception.dart';
import 'package:blog_app_vs/Core/errors/failure.dart';
import 'package:blog_app_vs/feature/friends/data/Entities/friend_request_impl.dart';
import 'package:blog_app_vs/feature/friends/data/data_source/friends_remote_data_source.dart';
import 'package:blog_app_vs/feature/friends/domain/freinds_repository/friends_repository.dart';
import 'package:fpdart/src/either.dart';

class FriendsRepositoryImpl implements FriendsRepository{
  final FriendsDataSourceImplementation impl;

  FriendsRepositoryImpl({required this.impl});

  @override
  Future<Either<failure, String>> addFriendsRep(String firstId, String secondId) async {
    try{
      await impl.addFriends(firstId, secondId);
      return const Right("passed");
    }
    on ServerException catch(e)
    {
      return Left(failure(e.message));
    }
  }

  @override
  Future<Either<failure, List<UserModel>>> getAllUsersRepo() async {
 try{
   final res=await impl.getAllUsers();
      return Right(res);
      }
     on ServerException catch (e)
     {
   return Left(failure(e.message));
     }
  }
  @override
  Future<Either<failure, List<FriendRequestImpl>>> getFriendRequests() async {
 try{
   final res=await impl.getRequests();
   if(res!=[]) {
      return Right(res);
   }
   return Left(failure('Failure'));
      }
     on ServerException catch (e)
     {

    return Left(failure(e.message));
     }
  }

  @override
  Future<Either<failure, String>> acceptOrRejectRequest(String id2, bool Status) async {
    // TODO: implement acceptOrRejectRequest
    try{
      await impl.acceptOrReject(id2, Status);
      return const Right(("Success"));
    }
        on ServerException catch(e)
        {
          return Left(failure(e.message));
        }
  }


}

