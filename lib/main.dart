import 'package:blog_app_vs/Core/Cubits/user_cubit.dart';
import 'package:blog_app_vs/feature/auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/Pages/Blogs_page.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/blog_bloc/blog_bloc.dart';
import 'package:blog_app_vs/feature/blog/Presentaion/blog_bloc/logout_bloc/logout_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Core/Theme/Theme.dart';
import 'depedency_injection.dart';
import 'feature/auth/Presentation/Pages/login.dart';
import 'feature/friends/presentation/Friendsbloc/Friends_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInit();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => resourcelocator<UserCubit>(),
      ),
      BlocProvider(
        create: (_) => resourcelocator<LogOutBloc>(),
      ),
      BlocProvider(
        create: (_) => resourcelocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => resourcelocator<BlogBloc>(),
      ),
      BlocProvider(
        create: (_) => resourcelocator<FriendsBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(BlocCurrentUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkBackground,
      home: BlocSelector<UserCubit, CubitState, bool>(
          selector: (CubitState state) {
        return state is CubitLogin;
      }, builder: (context, state) {
        if (state) {
          return const Scaffold(
            body: Blogs(),
          );
        }
        return const Login();
      }),
    );
  }
}
