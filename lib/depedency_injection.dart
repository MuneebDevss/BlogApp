import 'package:blog_app/Core/Cubits/user_cubit.dart';
import 'package:blog_app/Core/network/connection_checker.dart';
import 'package:blog_app/feature/auth/Domain/auth_repository/auth_repository.dart';
import 'package:blog_app/feature/auth/Domain/auth_use_cases/Sign_in_use_Case.dart';
import 'package:blog_app/feature/auth/Domain/auth_use_cases/current_user_use_case.dart';
import 'package:blog_app/feature/blog/Domain/UseCase/log_out_use_case.dart';
import 'package:blog_app/feature/auth/Domain/auth_use_cases/sign_up_usecase.dart';
import 'package:blog_app/feature/auth/Presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/auth/data/Repository/repository_impl.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/blog/Domain/UseCase/blog_upload_use_case.dart';
import 'package:blog_app/feature/blog/Domain/UseCase/get_blogs_use_case.dart';
import 'package:blog_app/feature/blog/Domain/repository/blog_respository.dart';
import 'package:blog_app/feature/blog/Presentaion/blog_bloc/blog_bloc.dart';
import 'package:blog_app/feature/blog/data/blog_rep_impl/blog_rep_imp.dart';
import 'package:blog_app/feature/blog/data/data_source/blog_remote_data_source.dart';
import 'package:blog_app/feature/friends/data/data_source/friends_remote_data_source.dart';
import 'package:blog_app/feature/friends/data/firends_rep_implementation/friends_repository_impl.dart';
import 'package:blog_app/feature/friends/domain/FriendsUseCase/add_friends_use_case.dart';
import 'package:blog_app/feature/friends/domain/FriendsUseCase/get_all_Users.dart';
import 'package:blog_app/feature/friends/domain/freinds_repository/friends_repository.dart';
import 'package:blog_app/feature/friends/presentation/Friendsbloc/Friends_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:blog_app/Core/Secrets/secrets.dart';

import 'feature/blog/Domain/UseCase/update_likes_use_case.dart';
import 'feature/friends/domain/FriendsUseCase/aor_use_case.dart';
import 'feature/friends/domain/FriendsUseCase/get_Friend_Requests.dart';

final resourcelocator = GetIt.instance;

Future<void> dependencyInit() async {
  final Supabase supabaseClient = await Supabase.initialize(
    url: secrets.supabaseUrl,
    anonKey: secrets.anonkey,
  );
  resourcelocator.registerSingleton(supabaseClient.client);
  resourcelocator.registerSingleton(UserCubit());
  authInit();
  blogInit();
  friendsInit();
}
void blogInit()
{

  resourcelocator.registerFactory<BlogRespository>(() => BlogRepImpl(impl: BlogRemoteDataSourceImpl(client: resourcelocator())));
  resourcelocator.registerFactory(() => BlogUploadUseCase(rep: resourcelocator()));
  resourcelocator.registerFactory(() => GetBlogsUseCase(impl: resourcelocator()));
  resourcelocator.registerFactory(() => LogOutUseCase(impl: resourcelocator()));
  resourcelocator.registerFactory(() => UpdateLikesUseCase(rep: resourcelocator()));
  resourcelocator.registerSingleton(BlogBloc(blogUploadUseCase: resourcelocator(), getBlogsUseCase: resourcelocator(), logOutUseCase: resourcelocator(), updateLikesUseCase: resourcelocator(),));
}
void friendsInit()
{

  resourcelocator.registerFactory(() => FriendsDataSourceImplementation(client:resourcelocator() ));
  resourcelocator.registerFactory<FriendsRepository>(() => FriendsRepositoryImpl(impl: resourcelocator()));
  resourcelocator.registerFactory(() => AddFriendsUseCase(rep: resourcelocator()));
  resourcelocator.registerFactory(() => GetAllUsersUseCase(rep: resourcelocator()));
  resourcelocator.registerFactory(() => AcceptOrRejectUseCase(rep: resourcelocator()));
  resourcelocator.registerFactory(() => GetFriendsRequestUseCase(rep: resourcelocator()));

  resourcelocator.registerSingleton(FriendsBloc(resourcelocator(),resourcelocator(),resourcelocator(),resourcelocator()));
}
void authInit() {
  resourcelocator.registerSingleton(InternetConnection());
  resourcelocator.registerFactory<ConnectionChecker>(()=>ConnectionImpl(internetConnection: resourcelocator()));
  resourcelocator.registerFactory<AuthRepository>(() => RepositoryImpl(data: Auth(supabaseClient: resourcelocator()), checker: resourcelocator()));
  resourcelocator.registerFactory(() => SignUpUseCase(rep: resourcelocator()));
  resourcelocator.registerFactory(() => SignInUseCase(rep: resourcelocator()));

  resourcelocator.registerFactory(() => CurrentUserUseCase(repositoryImpl: resourcelocator()));
  resourcelocator.registerSingleton(AuthBloc(resourcelocator(),resourcelocator(),resourcelocator(),resourcelocator()));
}

