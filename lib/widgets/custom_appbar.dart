

// import 'package:arthor/core/appconstants.dart';
// import 'package:arthor/core/colors.dart';
// import 'package:arthor/core/constants.dart';
// import 'package:arthor/core/responsiveutils.dart';
// import 'package:flutter/material.dart';

// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showLogout;
//   final VoidCallback? onLogoutPressed;

//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.showLogout = true,
//     this.onLogoutPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: preferredSize.height,
//       decoration: BoxDecoration(
//         color: Appcolors.kprimarycolor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: ResponsiveUtils.wp(4),
//             vertical: ResponsiveUtils.hp(1),
//           ),
//           child: Row(
//             children: [
//               // App Logo
//               Center(
//                 child:
               
//                 Image.asset(
//                   Appconstants.applogo,
//                   height: ResponsiveUtils.hp(6),
//                 ),
//               ),
//               ResponsiveSizedBox.width5,
//               // App Title
//               Expanded(
//                 child: ResponsiveText(
//                   title,
//                   sizeFactor: 1.2,
//                   weight: FontWeight.bold,
//                   color: Appcolors.kwhitecolor,
//                 ),
//               ),
//               // Logout Icon
//               if (showLogout)
//                 IconButton(
//                   onPressed: onLogoutPressed ?? () {},
//                   icon: Icon(
//                     Icons.logout_rounded,
//                     color: Appcolors.kwhitecolor,
//                     size: ResponsiveUtils.sp(6),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => Size.fromHeight(ResponsiveUtils.hp(16));
// }
import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/domain/repositories/logout_utils.dart';
import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLogout = true,
  });

  // -------------------------
  // LOGOUT DIALOG
  // -------------------------
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius15(),
          ),
          title: TextStyles.subheadline(
            text: 'Logout',
            color: Appcolors.kblackcolor,
          ),
          content: TextStyles.body(
            text: 'Are you sure you want to logout?',
            color: Colors.grey[700],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: TextStyles.body(
                text: 'Cancel',
                color: Colors.grey[600],
                weight: FontWeight.w600,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);   // Close the dialog
                AuthUtils.handleLogout(context); // Your logout logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyles.kradius10(),
                ),
              ),
              child: TextStyles.body(
                text: 'Logout',
                color: Appcolors.kwhitecolor,
                weight: FontWeight.w600,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: Appcolors.kprimarycolor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(4),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Row(
            children: [
              // Logo
              Center(
                child: Image.asset(
                  Appconstants.applogo,
                  height: ResponsiveUtils.hp(6),
                ),
              ),
              ResponsiveSizedBox.width5,

              // Title
              Expanded(
                child: ResponsiveText(
                  title,
                  sizeFactor: 1.2,
                  weight: FontWeight.bold,
                  color: Appcolors.kwhitecolor,
                ),
              ),

              // Logout Icon
              if (showLogout)
                IconButton(
                  onPressed: () => _showLogoutDialog(context),
                  icon: Icon(
                    Icons.logout_rounded,
                    color: Appcolors.kwhitecolor,
                    size: ResponsiveUtils.sp(6),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ResponsiveUtils.hp(16));
}
