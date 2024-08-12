import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/features/authentication/auth_injection_container.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/pages/splashView/splash_screen.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/theme/theme.dart';
import 'package:login_token_app/features/feed/feed_injection_container.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:login_token_app/features/userManagement/bloc/user_maanagement_bloc.dart';

void main() async {
  final feedBloc = await createFeedBloc();
  final authBloc = await createAuthBloc();
  runApp(MyApp(
    feedBloc: feedBloc,
    authBloc: authBloc,
  ));
}

class MyApp extends StatelessWidget {
  final FeedBloc feedBloc;
  final AuthBloc authBloc;
  const MyApp({super.key, required this.feedBloc, required this.authBloc});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => authBloc
            ..add(
              const AppStartEvent(),
            ),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => feedBloc,
        ),
        BlocProvider<UserManagementBloc>(
          create: (context) => UserManagementBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            home: const SplashScreen(),
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme.copyWith(textTheme: instagramTextTheme),
          );
        },
      ),
    );
  }
}
