import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:arthor/presentation/screens/screen_assignedpage/screen_assignedpage.dart';
import 'package:arthor/presentation/screens/screen_dashboardpage/screen_dashboardpage.dart';
import 'package:arthor/presentation/screens/screen_mainpage/widgets/customnav.dart';
import 'package:arthor/presentation/screens/screen_newcasespage/screen_newcasespage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ScreenMainPage extends StatefulWidget {
  const ScreenMainPage({super.key});

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  final List<Widget> _pages = [
ScreenDashboardpage(),
ScreenNewcasespage(),
ScreenAssignedpage()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        return 
         Scaffold(
            //backgroundColor: const Color.fromARGB(255, 248, 232, 227),
            body: _pages[state.currentPageIndex],
            bottomNavigationBar: BottomNavigationWidget(
              onTap: (index) {
                context.read<BottomNavigationBloc>().add(
                  NavigateToPageEvent(pageIndex: index),
                );
              },
            ),
          );
        
      },
    );
  }
}
