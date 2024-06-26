import '../../Domain/Entities/Likes.dart';

class LikeModel extends Likes{
  LikeModel({required super.blog_id, required super.UserId});
  factory LikeModel.fromjson(Map<String,dynamic> map)
  {
    return LikeModel(blog_id: map['blogid'], UserId: map['likedby']);
  }
}