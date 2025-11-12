// import 'package:arthor/core/appconstants.dart';
// import 'package:arthor/core/colors.dart';
// import 'package:arthor/core/constants.dart';
// import 'package:arthor/widgets/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:arthor/core/responsiveutils.dart';



// // Dashboard Statistics Card Widget
// class DashboardCard extends StatelessWidget {
//   final String number;
//   final String label;
//   final Color backgroundColor;
//   final Color textColor;
//   final IconData? icon;
//   final bool showLogo;

//   const DashboardCard({
//     super.key,
//     required this.number,
//     required this.label,
//     this.backgroundColor = Colors.white,
//     this.textColor = Colors.black,
//     this.icon,
//     this.showLogo = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadiusStyles.kradius15(),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (showLogo)
//             Center(
//               child: 
//               // Use this for asset:
//               Image.asset(
//                 Appconstants.applogo,
//                 height: ResponsiveUtils.hp(12),
//               ),
//             )
//           else
//             Column(
//               children: [
//                 if (icon != null)
//                   Icon(
//                     icon,
//                     size: ResponsiveUtils.sp(8),
//                     color: textColor.withOpacity(0.7),
//                   ),
//                 if (icon != null) ResponsiveSizedBox.height10,
//                 ResponsiveText(
//                   number,
//                   sizeFactor: 2.0,
//                   weight: FontWeight.bold,
//                   color: textColor,
//                 ),
//                 ResponsiveSizedBox.height5,
//                 ResponsiveText(
//                   label,
//                   sizeFactor: 0.9,
//                   weight: FontWeight.w500,
//                   color: textColor.withOpacity(0.8),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }

// // Main Dashboard Page
// class ScreenDashboardpage extends StatefulWidget {
//   const ScreenDashboardpage({super.key});

//   @override
//   State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
// }

// class _ScreenDashboardpageState extends State<ScreenDashboardpage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.kwhitecolor,
//       appBar: CustomAppBar(
//         title: 'Arttherservice',
//         onLogoutPressed: () {
//           // Handle logout
//           print('Logout pressed');
//         },
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ResponsiveSizedBox.height20,
//                        Container(
//                   padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Appcolors.kprimarycolor.withOpacity(0.08),
//                         Appcolors.ksecondarycolor.withOpacity(0.05),
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadiusStyles.kradius15(),
//                     border: Border.all(
//                       color: Appcolors.kprimarycolor.withOpacity(0.1),
//                       width: 1,
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             ResponsiveText(
//                               'Welcome Back!',
//                               sizeFactor: 1.8,
//                               weight: FontWeight.bold,
//                               color: Appcolors.ksecondarycolor,
//                             ),
//                             ResponsiveSizedBox.height5,
//                             ResponsiveText(
//                               'Here\'s your service overview',
//                               sizeFactor: 0.95,
//                               weight: FontWeight.w500,
//                               color: Appcolors.kgreyColor,
//                             ),
//                           ],
//                         ),
//                       ),
            
//                     ],
//                   ),
//                 ),
     
//               ResponsiveSizedBox.height40,
              
//               // First Row - New Orders and Logo
//               Row(
//                 children: [
//                   Expanded(
//                     child: DashboardCard(
//                       number: '24',
//                       label: 'New',
//                       backgroundColor:Appcolors.kbackgroundcolor,
//                       textColor: Appcolors.kprimarycolor,
//                       icon: Icons.fiber_new_rounded,
//                     ),
//                   ),
//                   ResponsiveSizedBox.width20,
//                   Expanded(
//                     child:    Image.asset(
//                         Appconstants.applogo,
//                         height: ResponsiveUtils.hp(18),
//                       ),
//                   ),
//                 ],
//               ),
              
//               ResponsiveSizedBox.height20,
              
//               // Second Row - Assigned and Completed
//               Row(
//                 children: [
//                   Expanded(
//                     child: DashboardCard(
//                       number: '18',
//                       label: 'Assigned',
//                       backgroundColor: const Color.fromARGB(255, 240, 120, 120),
//                       textColor: Appcolors.kwhitecolor,
//                       icon: Icons.assignment_turned_in_rounded,
//                     ),
//                   ),
//                   ResponsiveSizedBox.width20,
//                   Expanded(
//                     child: DashboardCard(
//                       number: '42',
//                       label: 'Completed',
//                       backgroundColor: const Color.fromARGB(255, 103, 191, 100),
//                       textColor: Appcolors.kwhitecolor,
//                       icon: Icons.check_circle_rounded,
//                     ),
//                   ),
//                 ],
//               ),
              
//               ResponsiveSizedBox.height30,
              
      
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:ui';
// // import 'package:arthor/core/appconstants.dart';
// // import 'package:arthor/core/colors.dart';
// // import 'package:arthor/core/constants.dart';
// // import 'package:flutter/material.dart';
// // import 'package:arthor/core/responsiveutils.dart';

// // // Custom Reusable AppBar Widget
// // class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
// //   final String title;
// //   final bool showLogout;
// //   final VoidCallback? onLogoutPressed;

// //   const CustomAppBar({
// //     super.key,
// //     required this.title,
// //     this.showLogout = true,
// //     this.onLogoutPressed,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: preferredSize.height,
// //       decoration: BoxDecoration(
// //         color: Appcolors.kprimarycolor,
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.1),
// //             blurRadius: 4,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: SafeArea(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(
// //             horizontal: ResponsiveUtils.wp(4),
// //             vertical: ResponsiveUtils.hp(1),
// //           ),
// //           child: Row(
// //             children: [
// //               // App Logo
// //               Center(
// //                 child: Image.asset(
// //                   Appconstants.applogo,
// //                   height: ResponsiveUtils.hp(6),
// //                 ),
// //               ),
// //               ResponsiveSizedBox.width5,
// //               // App Title
// //               Expanded(
// //                 child: ResponsiveText(
// //                   title,
// //                   sizeFactor: 1.2,
// //                   weight: FontWeight.bold,
// //                   color: Appcolors.kwhitecolor,
// //                 ),
// //               ),
// //               // Logout Icon
// //               if (showLogout)
// //                 IconButton(
// //                   onPressed: onLogoutPressed ?? () {},
// //                   icon: Icon(
// //                     Icons.logout_rounded,
// //                     color: Appcolors.kwhitecolor,
// //                     size: ResponsiveUtils.sp(6),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Size get preferredSize => Size.fromHeight(ResponsiveUtils.hp(17));
// // }

// Enhanced Dashboard Card with Glassmorphism and Custom Paint
import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';



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

// // // Main Dashboard Page
// // class ScreenDashboardpage extends StatefulWidget {
// //   const ScreenDashboardpage({super.key});

// //   @override
// //   State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
// // }

// // class _ScreenDashboardpageState extends State<ScreenDashboardpage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Appcolors.kwhitecolor,
// //       appBar: CustomAppBar(
// //         title: 'Arttherservice',
// //         onLogoutPressed: () {
// //           print('Logout pressed');
// //         },
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               ResponsiveSizedBox.height20,
// //               // Welcome Container
// //               Container(
// //                 padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [
// //                       Appcolors.kprimarycolor.withOpacity(0.08),
// //                       Appcolors.ksecondarycolor.withOpacity(0.05),
// //                     ],
// //                     begin: Alignment.topLeft,
// //                     end: Alignment.bottomRight,
// //                   ),
// //                   borderRadius: BorderRadiusStyles.kradius15(),
// //                   border: Border.all(
// //                     color: Appcolors.kprimarycolor.withOpacity(0.1),
// //                     width: 1,
// //                   ),
// //                 ),
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       child: Column(
// //                         crossAxisAlignment: CrossAxisAlignment.center,
// //                         children: [
// //                           ResponsiveText(
// //                             'Welcome Back!',
// //                             sizeFactor: 1.8,
// //                             weight: FontWeight.bold,
// //                             color: Appcolors.ksecondarycolor,
// //                           ),
// //                           ResponsiveSizedBox.height5,
// //                           ResponsiveText(
// //                             'Here\'s your service overview',
// //                             sizeFactor: 0.95,
// //                             weight: FontWeight.w500,
// //                             color: Appcolors.kgreyColor,
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               ResponsiveSizedBox.height40,
              
// //               // First Row - New Orders and Logo
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: EnhancedDashboardCard(
// //                       number: '24',
// //                       label: 'New',
// //                       gradientColors: [
// //                         const Color(0xFF667eea),
// //                         const Color(0xFF764ba2),
// //                       ],
// //                       icon: Icons.fiber_new_rounded,
// //                       glowColor: const Color(0xFF667eea),
// //                     ),
// //                   ),
// //                   ResponsiveSizedBox.width20,
// //                   Expanded(
// //                     child: Image.asset(
// //                       Appconstants.applogo,
// //                       height: ResponsiveUtils.hp(18),
// //                     ),
// //                   ),
// //                 ],
// //               ),
              
// //               ResponsiveSizedBox.height20,
              
// //               // Second Row - Assigned and Completed
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: EnhancedDashboardCard(
// //                       number: '18',
// //                       label: 'Assigned',
// //                       gradientColors: [
// //                         const Color.fromARGB(255, 185, 71, 97),
// //                         const Color.fromARGB(255, 134, 51, 62),
// //                       ],
// //                       icon: Icons.assignment_turned_in_rounded,
// //                       glowColor: const Color(0xFFf5576c),
// //                     ),
// //                   ),
// //                   ResponsiveSizedBox.width20,
// //                   Expanded(
// //                     child: EnhancedDashboardCard(
// //                       number: '42',
// //                       label: 'Completed',
// //                       gradientColors: [
// //                         const Color.fromARGB(255, 35, 88, 135),
// //                         const Color.fromARGB(255, 39, 109, 113),
// //                       ],
// //                       icon: Icons.check_circle_rounded,
// //                       glowColor: const Color(0xFF00f2fe),
// //                     ),
// //                   ),
// //                 ],
// //               ),
              
// //               ResponsiveSizedBox.height30,
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }




// Main Dashboard Page
class ScreenDashboardpage extends StatefulWidget {
  const ScreenDashboardpage({super.key});

  @override
  State<ScreenDashboardpage> createState() => _ScreenDashboardpageState();
}

class _ScreenDashboardpageState extends State<ScreenDashboardpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhitecolor,
      appBar: CustomAppBar(
        title: 'Arttherservice',
        onLogoutPressed: () {
          // Handle logout
          print('Logout pressed');
        },
      ),
      body: SafeArea(
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
              
              // Second Row - Assigned and Completed
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   EnhancedDashboardCard(
                     number: '24',
                     label: 'New',
                     gradientColors: [
                       const Color.fromARGB(255, 174, 134, 40),
                       const Color.fromARGB(255, 235, 217, 134),
                     ],
                     icon: Icons.fiber_new_rounded,
                     glowColor: const Color.fromARGB(255, 116, 112, 226),
                   ),
                               EnhancedDashboardCard(
                      number: '18',
                      label: 'Assigned',
                      gradientColors: [
                       const Color.fromARGB(255, 223, 44, 44),
                       const Color.fromARGB(255, 195, 103, 103),
                     ],
                      icon: Icons.assignment_turned_in_rounded,
                      glowColor: const Color(0xFFf5576c),
                               ),
                               EnhancedDashboardCard(
                                            number: '42',
                      label: 'Completed',
                          gradientColors: [
                       const Color.fromARGB(255, 23, 131, 136),
                       const Color.fromARGB(255, 118, 194, 234),
                     ],
                      icon: Icons.check_circle_rounded,
                      glowColor: const Color(0xFF00f2fe),
                               ),
                ],
              ),
              
              ResponsiveSizedBox.height30,
              
      
            ],
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
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
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
                Icon(
                  icon,
                  size: ResponsiveUtils.sp(8),
                  color: Colors.white,
                ),
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
                ResponsiveSizedBox.height10
              ],
            ),
          ),
        ],
      ),
    );
  }
}