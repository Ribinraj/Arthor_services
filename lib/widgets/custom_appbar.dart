

import 'package:arthor/core/appconstants.dart';
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/constants.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showLogout;
  final VoidCallback? onLogoutPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showLogout = true,
    this.onLogoutPressed,
  });

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
              // App Logo
              Center(
                child:
               
                Image.asset(
                  Appconstants.applogo,
                  height: ResponsiveUtils.hp(6),
                ),
              ),
              ResponsiveSizedBox.width5,
              // App Title
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
                  onPressed: onLogoutPressed ?? () {},
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