
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class BottomNavigationWidget extends StatelessWidget {
  final void Function(int)? onTap;
  const BottomNavigationWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentPageIndex,
          onTap: onTap,

          type: BottomNavigationBarType.fixed,
          backgroundColor: Appcolors.kprimarycolor,
          selectedItemColor: Appcolors.ksecondarycolor,
          unselectedItemColor: Appcolors.kwhitecolor,
          // selectedIconTheme: const IconThemeData(color: Appcolors.kblackcolor),
          unselectedIconTheme: IconThemeData(
            color: const Color.fromARGB(255, 245, 146, 113),
          ),
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedLabelStyle: const TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.home,
                color: Appcolors.ksecondarycolor,
                size: ResponsiveUtils.wp(7),
              ),
              icon: Icon(Icons.home_outlined, size: ResponsiveUtils.wp(7),color: Appcolors.kwhitecolor,),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add, size: ResponsiveUtils.wp(7),color: Appcolors.kwhitecolor),
              activeIcon: Icon(
                Icons.add_circle_outline,
                color: Appcolors.ksecondarycolor,
                size: ResponsiveUtils.wp(7),
              ),
              label: "New Cases",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded, size: ResponsiveUtils.wp(7),color: Appcolors.kwhitecolor),
              activeIcon: Icon(
                Icons.list_rounded,
                color: Appcolors.ksecondarycolor,
                size: ResponsiveUtils.wp(7),
              ),
              label: "Assigned",
            ),

          ],
        );
      },
    );
  }
}
