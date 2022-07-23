import 'package:facebook/layout/cubit/cubit.dart';
import 'package:facebook/layout/social_layout.dart';
import 'package:facebook/modules/login/login_screen.dart';
import 'package:facebook/modules/register/cubit/cubit.dart';
import 'package:facebook/shared/constants.dart';
import 'package:facebook/shared/network/local/cache_helper.dart';
import 'package:facebook/shared/network/remote/dio_helper.dart';
import 'package:facebook/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'modules/login/cubit/cubit.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var token = FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  var onBoarding = await CacheHelper.getData(key: 'onBoarding') ?? false;
  var isDark = CacheHelper.getData(key: 'isDark') ?? true;
  var themeMode = ThemeMode.dark;
  //print(isDark.toString());
  print('was dark: $isDark');
  uId = await CacheHelper.getData(key: 'uId');
  print(uId);
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = LoginScreen();
  }

  LoginCubit();
  SocialCubit();
  SocialCubit().getUserData();
  RegisterCubit();

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
    themeMode: themeMode,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isDark, this.startWidget, this.themeMode})
      : super(key: key);
  final bool? isDark;
  final Widget? startWidget;
  final ThemeMode? themeMode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SocialCubit>(
            create: (context) => SocialCubit()..getUserData()),
        BlocProvider<SocialCubit>(
          create: (context) => SocialCubit()..getUserData(),
        ),
        BlocProvider<SocialCubit>(
          create: (context) => SocialCubit.get(context)
            ..getPosts()
            ..getMyPosts()
            ..getUserData(),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: startWidget,
      ),
    );
  }
}
