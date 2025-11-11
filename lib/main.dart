import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:arthor/presentation/screens/screen_splashpage/screen_splashpage.dart';
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
    return BlocProvider(
      create: (context) => BottomNavigationBloc(),
      child: MaterialApp(
        title: 'Arthor Services',
        debugShowCheckedModeBanner: false,
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
