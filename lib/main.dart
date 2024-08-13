import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_token_app/core/theme/app_pallet.dart';
import 'package:login_token_app/features/authentication/auth_injection_container.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:login_token_app/features/authentication/presentation/bloc/auth_event.dart';
import 'package:login_token_app/features/authentication/presentation/pages/splashView/splash_screen.dart';
import 'package:login_token_app/core/theme/text_thme.dart';
import 'package:login_token_app/core/theme/theme.dart';
import 'package:login_token_app/features/feed/feed_injection_container.dart';
import 'package:login_token_app/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:login_token_app/features/userManagement/bloc/user_maanagement_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  final feedBloc = await createFeedBloc();
  final authBloc = await createAuthBloc();
  runApp(MyApp(
    feedBloc: feedBloc,
    authBloc: authBloc,
  ));
}

class MyApp extends StatefulWidget {
  final FeedBloc feedBloc;
  final AuthBloc authBloc;
  const MyApp({super.key, required this.feedBloc, required this.authBloc});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Set the status bar color and icon brightness
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make the status bar transparent
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for light background
      statusBarBrightness: Brightness.light, // Light status bar (for iOS)
    ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => widget.authBloc
            ..add(
              const AppStartEvent(),
            ),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => widget.feedBloc,
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

            navigatorKey: navigatorKey,

            debugShowCheckedModeBanner: false,

            home: const SplashScreen(),
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
