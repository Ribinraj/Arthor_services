

// Enhanced Dashboard Card with Glassmorphism and Custom Paint
import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/fetch_dashboard_bloc/fetch_dashboard_bloc.dart';
import 'package:arthor/presentation/screens/screen_dashboardpage/widgets/loading_shimmer.dart';
import 'package:arthor/widgets/custom_appbar.dart';
import 'package:arthor/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Custom Painter for Glow Effect
class GlowPainter extends CustomPainter {
  final Color color;

  GlowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(15),
    );

    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Main Dashboard Page
class ScreenDashboardpage extends StatefulWidget {
  const ScreenDashboardpage({super.key});

  @override
  State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
}

class _ScreenDashboardpageState extends State<ScreenDashboardpage> {

  Future<void> _onRefresh() async {
    // Re-fetch dashboard data
    context
        .read<FetchDashboardBloc>()
        .add(FetchDashboardInitialFetchingEvent());
  }

  @override
  void initState() {
    super.initState();
    context
        .read<FetchDashboardBloc>()
        .add(FetchDashboardInitialFetchingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhitecolor,
      appBar: CustomAppBar(
        title: 'Arttherservice',
    
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: Appcolors.kredcolor,
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveSizedBox.height50,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ResponsiveText(
                              'Welcome Back!',
                              sizeFactor: 1.8,
                              weight: FontWeight.bold,
                              color: Appcolors.ksecondarycolor,
                            ),
                            ResponsiveSizedBox.height5,
                            ResponsiveText(
                              'Here\'s your service overview',
                              sizeFactor: 0.95,
                              weight: FontWeight.w500,
                              color: Appcolors.kgreyColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ResponsiveSizedBox.height40,

                  Image.asset(
                    Appconstants.applogo,
                    height: ResponsiveUtils.hp(20),
                  ),

                  ResponsiveSizedBox.height40,

                  // Dashboard cards area
                  BlocBuilder<FetchDashboardBloc, FetchDashboardState>(
                    builder: (context, state) {
                      if (state is FetchDashboardLoadingState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            EnhancedDashboardCardShimmer(),
                            EnhancedDashboardCardShimmer(),
                            EnhancedDashboardCardShimmer(),
                          ],
                        );
                      } else if (state is FetchDashboardSuccessState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                navigateToMainPage(context, 1);
                              },
                              child: EnhancedDashboardCard(
                                number: state
                                        .dashboard.dashboard!.newCases ??
                                    "",
                                label: 'New',
                                gradientColors: [
                                  const Color.fromARGB(255, 174, 134, 40),
                                  const Color.fromARGB(
                                      255, 235, 217, 134),
                                ],
                                icon: Icons.fiber_new_rounded,
                                glowColor: const Color.fromARGB(
                                    255, 116, 112, 226),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                navigateToMainPage(context, 2);
                              },
                              child: EnhancedDashboardCard(
                                number: state.dashboard.dashboard!
                                        .assignedCases ??
                                    "",
                                label: 'Assigned',
                                gradientColors: [
                                  const Color.fromARGB(255, 223, 44, 44),
                                  const Color.fromARGB(
                                      255, 195, 103, 103),
                                ],
                                icon: Icons
                                    .assignment_turned_in_rounded,
                                glowColor: const Color(0xFFf5576c),
                              ),
                            ),
                            EnhancedDashboardCard(
                              number: state.dashboard.dashboard!
                                      .completedCases ??
                                  "",
                              label: 'Completed',
                              gradientColors: [
                                const Color.fromARGB(255, 23, 131, 136),
                                const Color.fromARGB(
                                    255, 118, 194, 234),
                              ],
                              icon: Icons.check_circle_rounded,
                              glowColor: const Color(0xFF00f2fe),
                            ),
                          ],
                        );
                      } else if (state is FetchDashboardErrorState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 40,
                              color: Colors.red,
                            ),
                            ResponsiveSizedBox.height10,
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ResponsiveSizedBox.height10,
                            ElevatedButton.icon(
                              onPressed: () {
                                context
                                    .read<FetchDashboardBloc>()
                                    .add(
                                        FetchDashboardInitialFetchingEvent());
                              },
                              icon: const Icon(Icons.refresh),
                              label: const Text("Try again"),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),

                  ResponsiveSizedBox.height30,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EnhancedDashboardCard extends StatelessWidget {
  final String number;
  final String label;
  final List<Color> gradientColors;
  final IconData icon;
  final Color glowColor;

  const EnhancedDashboardCard({
    super.key,
    required this.number,
    required this.label,
    required this.gradientColors,
    required this.icon,
    required this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
      width: ResponsiveUtils.wp(27),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadiusStyles.kradius15(),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -10,
            right: -10,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon with animated glow
                Icon(icon, size: ResponsiveUtils.sp(8), color: Colors.white),
                ResponsiveSizedBox.height10,
                // Number with shadow
                ResponsiveText(
                  number,
                  sizeFactor: 1.9,
                  weight: FontWeight.bold,
                  color: Colors.white,
                ),
                ResponsiveSizedBox.height5,
                // Label
                ResponsiveText(
                  label,
                  sizeFactor: 0.9,
                  weight: FontWeight.w500,
                  color: Colors.white.withOpacity(0.9),
                ),
                ResponsiveSizedBox.height10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
