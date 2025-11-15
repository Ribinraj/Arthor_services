import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/domain/repositories/apprepo.dart';
import 'package:arthor/domain/repositories/loginrepo.dart';
import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:arthor/presentation/blocs/case_accept_decline_bloc/case_accept_decline_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_assignedcases_bloc/fetch_assignedcases_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:arthor/presentation/blocs/fetch_newcases_bloc/fetch_newcases_bloc.dart';
import 'package:arthor/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:arthor/presentation/blocs/send_otp_bloc.dart/send_otp_bloc.dart';
import 'package:arthor/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:arthor/presentation/screens/screen_splashpage/screen_splashpage.dart';
import 'package:arthor/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
