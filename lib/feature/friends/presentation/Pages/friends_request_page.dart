import 'package:blog_app/Core/Cubits/user_cubit.dart';
import 'package:blog_app/Core/Theme/Palatte.dart';
import 'package:blog_app/Core/Utils/snack_bar.dart';
import 'package:blog_app/Core/Widgets/badges.dart';
import 'package:blog_app/Core/Widgets/loading.dart';
import 'package:blog_app/feature/blog/Presentaion/Pages/Blogs_page.dart';
import 'package:blog_app/feature/friends/domain/Entities/friend_requests.dart';
import 'package:blog_app/feature/friends/presentation/Friendsbloc/Friends_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'add_freinds_page.dart';

class FriendsRequestPage extends StatefulWidget {
  const FriendsRequestPage({super.key});
  static rout() =>
      MaterialPageRoute(builder: (context) => const FriendsRequestPage());
  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
  int _selectedIndex = 1;
  void routing() {
    if (_selectedIndex == 0) {
      Navigator.pushAndRemoveUntil(context, Blogs.rout(), (route) => false);
    }
    if (_selectedIndex == 2) {
      Navigator.pushAndRemoveUntil(
          context, AddFriendsPage.rout(), (route) => false);
    }
  }

  List<FriendRequest> users = [];
  String myId = "";
  List<int> addFriends = [];

  @override
  void initState() {
    myId = (context.read<UserCubit>().state as CubitLogin).user.id;
    context.read<FriendsBloc>().add(GetFriendsRequestEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            routing();
          });
        },
      ),
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        title: Container(
            width: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppPallete.gradient2,
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FaIcon(
                    FontAwesomeIcons.users,
                    color: AppPallete.backgroundColor,
                  ),
                ),
                Text(
                  'Friend Requests',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.backgroundColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
        centerTitle: true,
      ),
      body: BlocConsumer<FriendsBloc, FriendsState>(
        listener: (BuildContext context, FriendsState state) {
          if (state is FriendsFailure) {
            showSnackBar(context, state.message);
          }
          if (state is FriendsRequestSuccess) {
            users = state.fr; // Update users list only when new data arrives
            setState(() {});
          }
        },
        builder: (BuildContext context, FriendsState state) {
          if (state is FriendsLoading) {
            return const Loader();
          }
          if (state is FriendsRequestSuccess) {
            if (users.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: users.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(users[index].name),
                          iconColor: Colors.blueGrey,
                          leading: const Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          subtitle: Row(
                            children: [
                              addFriends.contains(index)
                                  ? Container(
                                      height: 40,
                                      width: 150,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: const Text(
                                        "Added",
                                        textAlign: (TextAlign.center),
                                        style: TextStyle(
                                            color: AppPallete.whiteColor),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        addFriends.add(index);
                                        context.read<FriendsBloc>().add(
                                            AcceptOrRejectEvent(
                                                id2: users[index].firstId,
                                                Status: true));
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 130,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppPallete.whiteColor,
                                        ),
                                        child: const Text(
                                          "Accept",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              addFriends.contains(index)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        context.read<FriendsBloc>().add(
                                            AcceptOrRejectEvent(
                                                id2: users[index].firstId,
                                                Status: false));
                                        setState(() {
                                          users.remove(users[index]);
                                          showSnackBar(
                                              context, "Request cancelled");
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 130,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueGrey,
                                        ),
                                        child: const Text(
                                          "Cancel",
                                          textAlign: (TextAlign.center),
                                          style: TextStyle(
                                              color: AppPallete.whiteColor),
                                        ),
                                      ))
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(15),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No requests Yet'));
            }
          }
          if (state is FriendsSuccess) {
            if (users.isNotEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: users.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, int index) {
                        return ListTile(
                          title: Text(users[index].name),
                          iconColor: Colors.blueGrey,
                          leading: const Icon(
                            Icons.account_circle,
                            size: 40,
                          ),
                          subtitle: Row(
                            children: [
                              addFriends.contains(index)
                                  ? Container(
                                      height: 40,
                                      width: 150,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.green,
                                      ),
                                      child: const Text(
                                        "Added",
                                        textAlign: (TextAlign.center),
                                        style: TextStyle(
                                            color: AppPallete.whiteColor),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        addFriends.add(index);
                                        context.read<FriendsBloc>().add(
                                            AcceptOrRejectEvent(
                                                id2: users[index].firstId,
                                                Status: true));
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 130,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppPallete.whiteColor,
                                        ),
                                        child: const Text(
                                          "Accept",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.blueGrey),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                width: 10,
                              ),
                              addFriends.contains(index)
                                  ? const SizedBox()
                                  : GestureDetector(
                                      onTap: () {
                                        context.read<FriendsBloc>().add(
                                            AcceptOrRejectEvent(
                                                id2: users[index].firstId,
                                                Status: false));
                                        setState(() {
                                          users.remove(users[index]);
                                          showSnackBar(
                                              context, "Request cancelled");
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 130,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.blueGrey,
                                        ),
                                        child: const Text(
                                          "Cancel",
                                          textAlign: (TextAlign.center),
                                          style: TextStyle(
                                              color: AppPallete.whiteColor),
                                        ),
                                      ))
                            ],
                          ),
                          contentPadding: const EdgeInsets.all(15),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No requests Yet'));
            }
          }
          return const Center(child: Text('No requests Yet'));
        },
      ),
    );
  }
}
