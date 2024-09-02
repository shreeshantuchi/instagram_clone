import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:login_token_app/features/feed/presentation/image_state.dart';
import 'package:login_token_app/features/followUser/follow_injection_contatier.dart';
import 'package:login_token_app/features/followUser/presentation/bloc/follow_bloc.dart';
import 'package:login_token_app/features/messenging/message_injectin_container.dart';
import 'package:login_token_app/features/messenging/presentation/bloc/messageBloc/message_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_bloc.dart';
import 'package:login_token_app/features/userManagement/presentation/bloc/user_maanagement_event.dart';
import 'package:login_token_app/features/userManagement/user_injection_container.dart';
import 'package:login_token_app/firebase_options.dart';
import 'package:login_token_app/shared/mediaManagementBloc/media_management_bloc.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final feedBloc = await createFeedBloc();
  final userManagementBloc = await createUserManagementBloc();
  final authBloc = await createAuthBloc();
  final followBloc = await createFollowBloc();
  final messageBloc = await createMessageBloc();

  runApp(MyApp(
    messageBloc: messageBloc,
    feedBloc: feedBloc,
    authBloc: authBloc,
    userManagementBloc: userManagementBloc,
    followBloc: followBloc,
  ));
}

class MyApp extends StatefulWidget {
  final FeedBloc feedBloc;
  final AuthBloc authBloc;
  final UserManagementBloc userManagementBloc;
  final FollowBloc followBloc;
  final MessageBloc messageBloc;
  const MyApp(
      {super.key,
      required this.feedBloc,
      required this.authBloc,
      required this.userManagementBloc,
      required this.followBloc,
      required this.messageBloc});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Set the status bar color and icon brightness
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Make the status bar transparent
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for light background
      statusBarBrightness: Brightness.light, // Light status bar (for iOS)
    ));
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageState(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => widget.authBloc
            ..add(
              const AppStartEvent(),
            ),
        ),
        BlocProvider<FeedBloc>(
          create: (context) => widget.feedBloc,
        ),
        BlocProvider<FollowBloc>(
          create: (context) => widget.followBloc,
        ),
        BlocProvider<MediaManagementBloc>(
          create: (context) => MediaManagementBloc(),
        ),
        BlocProvider<MessageBloc>(
          create: (context) => widget.messageBloc,
        ),
        BlocProvider<UserManagementBloc>(
          create: (context) => widget.userManagementBloc,
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
