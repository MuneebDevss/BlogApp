import 'package:blog_app/Core/Cubits/user_cubit.dart';
import 'package:blog_app/feature/blog/Domain/Entities/Likes.dart';
import 'package:flutter/cupertino.dart';
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
  List<Blog> blogs;
  BlogsList({required this.blogs,super.key});

  @override
  State<BlogsList> createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  String user="";
  @override
  void initState(){
    user=(context.read<UserCubit>().state as CubitLogin).user.id;
    super.initState();
  }
  String getTimeDifference(DateTime inputDateTime) {
    DateTime currentTime = DateTime.now();
    Duration difference = currentTime.difference(inputDateTime);

    int minut = difference.inMinutes;
    int hours=difference.inHours;
    int days=difference.inDays;
    if(days==0)
    {
      if(hours==0)
      {
        return "$minut min";
      }
      else
      {
        return "$hours hours";
      }
    }
    else
    {
      return "$days days";
    }
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.blogs.length,
        itemBuilder: (context, index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Row(
                    children: widget.blogs[index]
                        .topic
                        .map((e) =>
                        Button(text: e, color: AppPallete.gradient2))
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
                                onDoubleTap: (){
                                  if(!widget.blogs[index].likes.contains(Likes(blog_id: widget.blogs[index].id, UserId: user))) {
                                    widget.blogs[index].likes.add(Likes(blog_id: widget.blogs[index].id, UserId: user));
                                    setState(() {

                                    });
                                  }
                                  else
                                  {
                                    widget.blogs[index].likes.remove(Likes(blog_id: widget.blogs[index].id, UserId: user));
                                    setState(() {

                                    });
                                  }
                                },
                                onTap: (){
                                  Navigator.push(context, SelectImage.rout(widget.blogs[index].imageUrl,));
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
                              Text("${getTimeDifference(widget.blogs[index].updatedAt)} ago"),
                              Row(
                                children: [
                                  IconButton(onPressed: (){
                                    if(widget.blogs[index].likes.contains(Likes(blog_id: widget.blogs[index].id, UserId: user))) {
                                      widget.blogs[index].likes.remove(Likes(blog_id: widget.blogs[index].id, UserId: user));
                                      context.read<BlogBloc>().add(UpdateLikesEvent(status: false, blogId: widget.blogs[index].id));
                                    } else {
                                      widget.blogs[index].likes.add(Likes(blog_id: widget.blogs[index].id, UserId: user));
                                      context.read<BlogBloc>().add(UpdateLikesEvent(status: true, blogId: widget.blogs[index].id));
                                    }
                                    setState(() {

                                    });},
                                      icon:widget.blogs[index].likes.contains(Likes(blog_id: widget.blogs[index].id, UserId: user))? const FaIcon(FontAwesomeIcons.solidHeart,color: AppPallete.gradient2):const FaIcon(FontAwesomeIcons.heart,)),
                                  Text('${widget.blogs[index].likes.length}'),
                                  IconButton(onPressed: (){}, icon: const FaIcon(FontAwesomeIcons.comment))
                                ],
                              ),
                            ]),

                      ],

                    )),


              ]);
        });
  }
}
