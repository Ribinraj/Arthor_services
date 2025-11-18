import 'dart:io';

import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/domain/pushnotification_controller.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:arthor/domain/repositories/loginrepo.dart';
import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:arthor/presentation/blocs/case_accept_decline_bloc/case_accept_decline_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_assignedcases_bloc/fetch_assignedcases_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_atributes_bloc/fetch_atributes_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_newcases_bloc/fetch_newcases_bloc.dart';
import 'package:arthor/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:arthor/presentation/blocs/send_otp_bloc.dart/send_otp_bloc.dart';
import 'package:arthor/presentation/blocs/untreceable_reasons_bloc/untreceable_reasons_bloc.dart';
import 'package:arthor/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:arthor/presentation/screens/screen_splashpage/screen_splashpage.dart';
import 'package:arthor/widgets/custom_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Optional: initialize firebase here if you need (only if you use Firebase in background)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotifications.backgroundMessageHandler(message);
}

// Global navigator key so we can navigate from notification handlers
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main()async {
      WidgetsFlutterBinding.ensureInitialized();
      // Initialize Firebase
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register FCM background handler BEFORE runApp
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize PushNotifications helper (this will request permissions, create channel, etc.)
  // It's okay to await this so notifications are ready by the time the app runs.
  await PushNotifications.instance.init();

  // Optional: request permissions again for iOS if you want explicit control here
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    final loginrepo=Loginrepo();
    final apprepo=Apprepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavigationBloc()),
        BlocProvider(create: (context) => SendOtpBloc(repository: loginrepo)),
         BlocProvider(create: (context) => VerifyOtpBloc(repository: loginrepo)),
          BlocProvider(create: (context) => ResendOtpBloc(repository: loginrepo)),
           BlocProvider(create: (context) => FetchDashboardBloc(repository: apprepo)),
            BlocProvider(create: (context) => FetchNewcasesBloc(repository: apprepo)),
             BlocProvider(create: (context) => CaseAcceptDeclineBloc(repository: apprepo)),
              BlocProvider(create: (context) => FetchAssignedcasesBloc(repository: apprepo)),
              BlocProvider(create: (context) => UntreceableReasonsBloc(repository: apprepo)),
              BlocProvider(create: (context) => FetchAtributesBloc(repository: apprepo)),
        
      ],
      child: MaterialApp(
        title: 'Arthor Services',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService().navigatorKey,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
          fontFamily: 'Helvetica',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Appcolors.kwhitecolor,
        ),
        home: ScreenSplashpage(),
      ),
    );
  }
}
