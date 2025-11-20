
import 'package:arthor/core/colors.dart';
import 'package:arthor/core/responsiveutils.dart';
import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// class BottomNavigationWidget extends StatelessWidget {
//   final void Function(int)? onTap;
//   const BottomNavigationWidget({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//       builder: (context, state) {
//         return BottomNavigationBar(
//           currentIndex: state.currentPageIndex,
//           onTap: onTap,

//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Appcolors.kprimarycolor,
//           selectedItemColor: Appcolors.kblackcolor,
//           unselectedItemColor: Appcolors.kwhitecolor,
//           // selectedIconTheme: const IconThemeData(color: Appcolors.kblackcolor),
//           unselectedIconTheme: IconThemeData(
//             color: const Color.fromARGB(255, 245, 146, 113),
//           ),
//           selectedLabelStyle: const TextStyle(fontSize: 13),
//           unselectedLabelStyle: const TextStyle(fontSize: 12),
//           items: [
//             BottomNavigationBarItem(
//               activeIcon: Icon(
//                 Icons.home_outlined,
//                 color: Appcolors.kblackcolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               icon: Icon(Icons.home, size: ResponsiveUtils.wp(7),color: Appcolors.kwhitecolor,),
//               label: "Dashboard",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.add, size: ResponsiveUtils.wp(7),color: Appcolors.kwhitecolor),
//               activeIcon: Icon(
//                 Icons.add_circle_outline,
//                 color: Appcolors.kblackcolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               label: "New Cases",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.list_rounded, size: ResponsiveUtils.wp(7),color: Appcolors.kwhitecolor),
//               activeIcon: Icon(
//                 Icons.list_rounded,
//                 color: Appcolors.kblackcolor,
//                 size: ResponsiveUtils.wp(7),
//               ),
//               label: "Assigned",
//             ),

//           ],
//         );
//       },
//     );
//   }
// }
// class BottomNavigationWidget extends StatelessWidget {
//   final void Function(int)? onTap;
//   const BottomNavigationWidget({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
//       builder: (context, state) {
//         return Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: Appcolors.kblackcolor.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: const Offset(0, -2),
//               ),
//             ],
//           ),
//           child: BottomNavigationBar(
//             currentIndex: state.currentPageIndex,
//             onTap: onTap,
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Appcolors.kwhitecolor,
//             selectedItemColor: Appcolors.kprimarycolor,
//             unselectedItemColor: Appcolors.kgreyColor,
//             selectedLabelStyle: const TextStyle(
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//             elevation: 0,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: state.currentPageIndex == 0
//                         ? Appcolors.kprimarycolor.withOpacity(0.1)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     state.currentPageIndex == 0
//                         ? Icons.dashboard_rounded
//                         : Icons.dashboard_outlined,
//                     size: ResponsiveUtils.wp(6.5),
//                     color: state.currentPageIndex == 0
//                         ? Appcolors.kprimarycolor
//                         : Appcolors.kgreyColor,
//                   ),
//                 ),
//                 label: "Dashboard",
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: state.currentPageIndex == 1
//                         ? Appcolors.ksecondarycolor.withOpacity(0.15)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     state.currentPageIndex == 1
//                         ? Icons.note_add_rounded
//                         : Icons.note_add_outlined,
//                     size: ResponsiveUtils.wp(6.5),
//                     color: state.currentPageIndex == 1
//                         ? Appcolors.ksecondarycolor
//                         : Appcolors.kgreyColor,
//                   ),
//                 ),
//                 label: "New Cases",
//               ),
//               BottomNavigationBarItem(
//                 icon: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: state.currentPageIndex == 2
//                         ? Appcolors.kprimarycolor.withOpacity(0.1)
//                         : Colors.transparent,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     state.currentPageIndex == 2
//                         ? Icons.assignment_rounded
//                         : Icons.assignment_outlined,
//                     size: ResponsiveUtils.wp(6.5),
//                     color: state.currentPageIndex == 2
//                         ? Appcolors.kprimarycolor
//                         : Appcolors.kgreyColor,
//                   ),
//                 ),
//                 label: "Assigned",
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
class BottomNavigationWidget extends StatelessWidget {
  final void Function(int)? onTap;
  const BottomNavigationWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            boxShadow: [
              BoxShadow(
                color: Appcolors.kprimarycolor.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: state.currentPageIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Appcolors.kwhitecolor,
            selectedItemColor: Appcolors.kprimarycolor,
            unselectedItemColor: Appcolors.kgreyColor.withOpacity(0.6),
            selectedLabelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard_outlined,
                  size: ResponsiveUtils.wp(7),
                ),
                activeIcon: Icon(
                  Icons.dashboard_rounded,
                  size: ResponsiveUtils.wp(7),
                ),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.note_add_outlined,
                  size: ResponsiveUtils.wp(7),
                ),
                activeIcon: Icon(
                  Icons.note_add_rounded,
                  size: ResponsiveUtils.wp(7),
                ),
                label: "New Cases",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment_outlined,
                  size: ResponsiveUtils.wp(7),
                ),
                activeIcon: Icon(
                  Icons.assignment_rounded,
                  size: ResponsiveUtils.wp(7),
                ),
                label: "Assigned",
              ),
            ],
          ),
        );
      },
    );
  }
}