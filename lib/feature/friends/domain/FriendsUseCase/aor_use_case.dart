import 'package:blog_app/Core/UseCase.dart';
import 'package:blog_app/Core/errors/failure.dart';
import 'package:blog_app/feature/friends/domain/FriendsUseCase/get_all_Users.dart';
import 'package:blog_app/feature/friends/domain/freinds_repository/friends_repository.dart';
import 'package:fpdart/src/either.dart';
class RequestStatus
{
  final String id2;
  final bool Status;

  RequestStatus({required this.id2, required this.Status});
}
class AcceptOrRejectUseCase implements UseCase<String,RequestStatus> {
  final FriendsRepository rep;

  AcceptOrRejectUseCase({required this.rep});
  @override
  Future<Either<failure, String>> call(RequestStatus params) {

    return rep.acceptOrRejectRequest(params.id2, params.Status);
  }
}
