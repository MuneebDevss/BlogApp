import 'package:blog_app_vs/Core/Cubits/user_cubit.dart';
import 'package:blog_app_vs/Core/Models/user_model.dart';
import 'package:blog_app_vs/Core/Theme/Palatte.dart';
import 'package:blog_app_vs/Core/Utils/snack_bar.dart';
import 'package:blog_app_vs/Core/Widgets/badges.dart';
import 'package:blog_app_vs/Core/Widgets/loading.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/Pages/Blogs_page.dart';
import 'package:blog_app_vs/feature/friends/presentation/Friendsbloc/Friends_bloc.dart';
import 'package:blog_app_vs/feature/friends/presentation/Pages/friends_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});
  static rout()=>MaterialPageRoute(builder: (context)=>const AddFriendsPage());
  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();

}

class _AddFriendsPageState extends State<AddFriendsPage> {
  int _selectedIndex = 2;
  void routing()
  {
    if(_selectedIndex==0)
    {
      Navigator.pushAndRemoveUntil(context, Blogs.rout(), (route) => false);
    }
    if(_selectedIndex==1)
    {
      Navigator.pushAndRemoveUntil(context, FriendsRequestPage.rout(), (route) => false);
    }
  }
 List<UserModel> users=[];
  String myId="";
  List<int> addFriends=[];
  @override
  void initState(){
     myId=(context.read<UserCubit>().state as CubitLogin).user.id;
    context.read<FriendsBloc>().add(GetAllUsersEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        onTap:  (index){
          setState(() {
            _selectedIndex = index;
            routing();
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: AppPallete.whiteColor,
        elevation: 0,
        title: Container(
          width: 180,
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10),
            color: AppPallete.gradient2,
          ),
            child:Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.users,color: AppPallete.backgroundColor,),
                ),

            Text('Add Friends',style: GoogleFonts.lato(
              textStyle: const TextStyle(
              ),
              fontSize:20,
              fontWeight:FontWeight.w600,
              color:AppPallete.backgroundColor,
            ),textAlign: TextAlign.center,),
              ],
            )),
        centerTitle: true,
      ),

      body: BlocConsumer<FriendsBloc,FriendsState>(

        listener: (BuildContext context, FriendsState state)
        {
          if(state is FriendsFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (BuildContext context, FriendsState state)
        {
          if(state is FriendsLoading) {
            return const Loader();
          }
          if(state is UsersAchievedState)
          {

           users=state.models;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                    color: AppPallete.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lets",style: GoogleFonts.roboto(
                        fontSize:25,
                        fontWeight:FontWeight.w600,
                        color:AppPallete.backgroundColor,
                      ),),
                      const Row(
                        children: [
                          Text("Connect",
                              style: TextStyle(fontSize: 45, color: Colors.black)),
                          SizedBox(width: 10,),
                          FaIcon(FontAwesomeIcons.solidHandshake,color: AppPallete.backgroundColor,size: 40,),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                        width: 10,
                      ),
                      TextField(
                        onSubmitted: (value) {
                          setState(() {

                          });
                        },

                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(20),
                          fillColor: Color.fromRGBO(244, 243, 243, 1),
                          filled: true,
                          hintText: "Enter the name",
                          hintStyle: TextStyle(color: AppPallete.backgroundColor),
                          prefixIcon: Icon(Icons.search),

                        ),
                      ),

                    ],
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, int index) {

                        return ListTile(
                        title: Text(users[index].name),
                        iconColor: Colors.blueGrey,
                        leading: const Icon(Icons.account_circle,size: 40,),
                        subtitle: addFriends.contains(index)
                          ? Container(
                            height: 50,
                            width: 1,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green,
                            ),
                            child: const Text("Added",textAlign:( TextAlign.center),style: TextStyle(color: AppPallete.whiteColor),

                          ),)
                          : GestureDetector(
                        onTap: () {
                          addFriends.add(index);
                          context.read<FriendsBloc>().add(AddFriendsEvent(id1: myId.toString(), id2: users[index].id.toString()));
                          setState(() {
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 1,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                              color: AppPallete.whiteColor,
                            ),
                            child: const Text("Add",textAlign: TextAlign.center,style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                      );

                    },
                  ),
                )

              ],
            );
          }
          if(state is FriendsSuccess) {
            return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  color: AppPallete.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lets",style: GoogleFonts.roboto(
                      fontSize:25,
                      fontWeight:FontWeight.w600,
                      color:AppPallete.backgroundColor,
                    ),),
                    const Row(
                      children: [
                        Text("Connect",
                            style: TextStyle(fontSize: 45, color: Colors.black)),
                        SizedBox(width: 10,),
                        FaIcon(FontAwesomeIcons.solidHandshake,color: AppPallete.backgroundColor,size: 40,),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    TextField(
                      onSubmitted: (value) {
                        setState(() {

                        });
                      },

                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        fillColor: Color.fromRGBO(244, 243, 243, 1),
                        filled: true,
                        hintText: "Enter the name",
                        hintStyle: TextStyle(color: AppPallete.backgroundColor),
                        prefixIcon: Icon(Icons.search),

                      ),
                    ),

                  ],
                ),
              ),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: users.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, int index) {

                    return ListTile(
                      title: Text(users[index].name),
                      iconColor: Colors.blueGrey,
                      leading: const Icon(Icons.account_circle,size: 40,),
                      subtitle: addFriends.contains(index)
                          ? Container(
                        height: 50,
                        width: 1,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Text("Added",textAlign:( TextAlign.center),style: TextStyle(color: AppPallete.whiteColor),

                        ),)
                          : GestureDetector(
                        onTap: () {
                          addFriends.add(index);
                          context.read<FriendsBloc>().add(AddFriendsEvent(id1: myId.toString(), id2: users[index].id.toString()));
                          setState(() {
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 1,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppPallete.whiteColor,
                          ),
                          child: const Text("Add",textAlign: TextAlign.center,style: TextStyle(color: Colors.blueGrey),
                          ),
                        ),
                      ),
                      contentPadding: const EdgeInsets.all(15),
                    );

                  },
                ),
              )

            ],
          );
          }
          return const Text('No Users Yet');
        },
      ),
    );
  }
}
