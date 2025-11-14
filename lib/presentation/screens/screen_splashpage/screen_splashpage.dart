import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/presentation/screens/screen_loginpage/screen_loginpage.dart';
import 'package:arthor/presentation/screens/screen_mainpage/screen_mainpage.dart'; // <-- add this
import 'package:arthor/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- add this

class ScreenSplashpage extends StatefulWidget {
  const ScreenSplashpage({super.key});

  @override
  State<ScreenSplashpage> createState() => _ScreenSplashpageState();
}

class _ScreenSplashpageState extends State<ScreenSplashpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    // start the token check + navigation flow
    _handleSplashNavigation();
  }

  Future<String> getUserToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString('USER_TOKEN') ?? '';
  }

  Future<void> _handleSplashNavigation() async {
    // optional: keep the 3-second splash delay
    await Future.delayed(const Duration(seconds: 3));

    final token = await getUserToken();

    if (!mounted) return;

    if (token.isNotEmpty) {
      // User is logged in → go to main page
      CustomNavigation.pushReplaceWithTransition(
        context,
        const ScreenMainPage(),
      );
    } else {
      // No token → go to send-OTP / login page
      CustomNavigation.pushReplaceWithTransition(
        context,
        const ScreenLoginpage(),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Appcolors.kbackgroundcolor,
              Appcolors.kbackgroundcolor.withAlpha(88),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with scale and fade animation
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Appcolors.kwhitecolor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.kprimarycolor.withAlpha(70),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      Appconstants.applogo,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // App name with slide and fade animation
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'Arthor Services',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Appcolors.kprimarycolor,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Your Trusted Service Partner',
                        style: TextStyle(
                          fontSize: 14,
                          color: Appcolors.ksecondarycolor,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ResponsiveSizedBox.height20,

              // Loading indicator
              FadeTransition(
                opacity: _fadeAnimation,
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: SpinKitCircle(
                    color: Appcolors.kprimarycolor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
