class Likes
{
  String name;
  String UserId;
  Likes ({required this.name,required this.UserId});
  factory Likes.fromjson(Map<String,dynamic> map)
  {
    return Likes(name: map['name'], UserId: map['likedby']);
  }
}