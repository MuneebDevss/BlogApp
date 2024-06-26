import 'package:blog_app/Core/Theme/Palatte.dart';
import 'package:blog_app/Core/Widgets/badges.dart';
import 'package:blog_app/Core/Widgets/loading.dart';
import 'package:blog_app/feature/auth/Presentation/Pages/login.dart';


import 'package:blog_app/feature/blog/Presentaion/Widgets/blogs_list.dart';
import 'package:blog_app/feature/blog/Presentaion/blog_bloc/blog_bloc.dart';
import 'package:blog_app/feature/friends/presentation/Pages/add_freinds_page.dart';
import 'package:blog_app/feature/friends/presentation/Pages/friends_request_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Utils/snack_bar.dart';
import '../../Domain/Entities/blogs.dart';
import 'add_blog.dart';




class Blogs extends StatefulWidget {
  const Blogs({Key? key}); // Use Key? key instead of super.key
  static rout()=>MaterialPageRoute(builder: (context)=>const Blogs());
  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {

  int _selectedIndex = 0;
  void routing()
  {
    if(_selectedIndex==1)
    {
      Navigator.pushAndRemoveUntil(context, FriendsRequestPage.rout(), (route) => false);
    }
    if(_selectedIndex==2)
    {
      Navigator.pushAndRemoveUntil(context, AddFriendsPage.rout(), (route) => false);
    }
  }



  void showSuccess(BuildContext context) {
    showSnackBar(context, 'Successfully Uploaded');
  }
  final List<int> liked=[];
   List<Blog> blogs=[];
  @override
  void initState() {
    context.read<BlogBloc>().add(GetBlogs());
    super.initState();
  }

  // Define a function to create the MaterialPageRoute for navigation
  MaterialPageRoute<void> createRoute(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (context) => const AddBlog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',

          ),
          BottomNavigationBarItem(
            icon: badge(),
            label: 'Connection Requests',

          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.connect_without_contact),
            label: 'Connect',

          ),

        ],

        currentIndex: _selectedIndex,
        selectedItemColor: AppPallete.blue,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
            routing();
          });
        },
      ),
      appBar: AppBar(

        title: const Text("Meta 2.0"),
        leading: GestureDetector(
          onTap: (){
            context.read<BlogBloc>().add(BlocLogOut());
            setState(() {

            });
          },
            child: const Icon(Icons.logout_rounded)),


        actions: [

          const SizedBox(width: 10,),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppPallete.whiteColor,
                width: 3
              ),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Row(
              children: [
                const SizedBox(width: 5,),
                const Text('Post'),
                IconButton(
                  onPressed: () {
                    // Use createRoute to create the route for navigation
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddBlog()));
                  },
                  icon: const Icon(CupertinoIcons.add_circled),
                ),
              ],
            ),
          ),

        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is AchievementFailureState) {
            showSnackBar(context, state.message);
          }
          if(state is LogOutSuccessState)
          {
            if(state.message=="success") {

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const Login()), (route) => false);

            }
          }
          if(state is LogOutFailureState)
          {
            showSnackBar(context, state.message);
            state=BlogsAchieved(blogs: blogs);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogsAchieved) {
            blogs=state.blogs.reversed.toList();
            return BlogsList(blogs: blogs);
          }
          if(state is LikesUpdatedState) {
            return BlogsList(blogs: blogs);
          }
          return const Center(child: Text('Let\'s Add new Friends and Connect'));
        },
      ),
    );
  }
}
