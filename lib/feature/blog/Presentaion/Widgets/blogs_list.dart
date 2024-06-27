import 'package:blog_app_vs/Core/Cubits/user_cubit.dart';
import 'package:blog_app_vs/feature/blog/Domain/Entities/Likes.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/Pages/comments_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Core/Theme/Palatte.dart';
import '../../Domain/Entities/blogs.dart';
import '../Pages/image_page.dart';
import '../blog_bloc/blog_bloc.dart';
import 'Button.dart';

class BlogsList extends StatefulWidget {
  final List<Blog> blogs;
  BlogsList({required this.blogs, super.key});

  @override
  State<BlogsList> createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  String containes(int index) {
    for (Likes like in widget.blogs[index].likes) {
      
      if (like.UserId == user) {
        return user;
      }
    }
    return '';
  }

  bool likesAreEqual(Likes like1, Likes like2) {
    return like1.name == like2.name && like1.UserId == like2.UserId;
  }

  int indexOfLike(List<Likes> likes, Likes like) {
    return likes.indexWhere((element) => likesAreEqual(element, like));
  }

  String user = "";
  String name = "";
  @override
  void initState() {
    user = (context.read<UserCubit>().state as CubitLogin).user.id;
    name = (context.read<UserCubit>().state as CubitLogin).user.name;
    super.initState();
  }

  String getTimeDifference(DateTime inputDateTime) {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(inputDateTime);

    int minut = difference.inMinutes;
    int hours = difference.inHours;
    int days = difference.inDays;
    if (days == 0) {
      if (hours == 0) {
        return "$minut min";
      } else {
        return "$hours hours";
      }
    } else {
      return "$days days";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.blogs.length,
        itemBuilder: (context, index) {
          bool ch = containes(index).isNotEmpty ? true : false;
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: widget.blogs[index].topic
                        .map(
                            (e) => Button(text: e, color: AppPallete.gradient2))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 380,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.blogs[index].uploaderName}   [${widget.blogs[index].title}]",
                                style: GoogleFonts.abel(
                                    textStyle: const TextStyle(fontSize: 16),
                                    fontWeight: FontWeight.w500,
                                    color: AppPallete.whiteColor),
                              ),
                              Text(
                                widget.blogs[index].content,
                                style: GoogleFonts.oswald(
                                  color: AppPallete.whiteColor,
                                  textStyle:
                                      Theme.of(context).textTheme.caption,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onDoubleTap: () {
                                  if (!ch) {
                                    widget.blogs[index].likes
                                        .add(Likes(name: name, UserId: user));
                                    setState(() {});
                                  } else {
                                    widget.blogs[index].likes.removeLast();
                                    setState(() {});
                                  }
                                },
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      SelectImage.rout(
                                        widget.blogs[index].imageUrl,
                                      ));
                                },
                                child: SizedBox(
                                  height: 200,
                                  width: 300,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      widget.blogs[index].imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  "${getTimeDifference(widget.blogs[index].updatedAt)} ago"),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (ch) {
                                          widget.blogs[index].likes
                                              .removeLast();
                                          context.read<BlogBloc>().add(
                                              UpdateLikesEvent(
                                                  status: false,
                                                  blogId:
                                                      widget.blogs[index].id));
                                        } else {
                                          widget.blogs[index].likes.add(
                                              Likes(name: name, UserId: user));
                                          context.read<BlogBloc>().add(
                                              UpdateLikesEvent(
                                                  status: true,
                                                  blogId:
                                                      widget.blogs[index].id));
                                        }
                                        setState(() {});
                                      },
                                      icon: ch
                                          ? const FaIcon(
                                              FontAwesomeIcons.solidHeart,
                                              color: AppPallete.gradient2)
                                          : const FaIcon(
                                              FontAwesomeIcons.heart,
                                            )),
                                  Text('${widget.blogs[index].likes.length}'),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentsPage(
                                                        blogId: widget
                                                            .blogs[index].id)));
                                      },
                                      icon: const FaIcon(
                                          FontAwesomeIcons.comment))
                                ],
                              ),
                            ]),
                      ],
                    )),
              ]);
        });
  }
}
