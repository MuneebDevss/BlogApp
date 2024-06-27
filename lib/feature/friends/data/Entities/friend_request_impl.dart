
import 'package:blog_app_vs/feature/friends/domain/Entities/friend_requests.dart';

class FriendRequestImpl extends FriendRequest {
  FriendRequestImpl({

   required super.firstId, required super.secondId, required super.name, required super.firstStatus, required super.secondStatus
  });

  factory FriendRequestImpl.fromJson(Map<String, dynamic> json) {
    return FriendRequestImpl(

      firstStatus: json['first_status'],
      secondStatus: json['second_status'],
      name: json['name'],
      firstId: json['first_id'],
      secondId: json['second_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_status': firstStatus,
      'second_status': secondStatus,
      'name': name,
    };
  }
}
