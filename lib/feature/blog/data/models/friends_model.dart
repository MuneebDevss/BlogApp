import 'package:blog_app_vs/feature/blog/Domain/Entities/friends.dart';

class FriendsModel extends Friends{
  FriendsModel({required super.id});
  factory FriendsModel.fromJson(Map<String,dynamic> map)
  {
    return FriendsModel(id: map['friend']);
  }
}