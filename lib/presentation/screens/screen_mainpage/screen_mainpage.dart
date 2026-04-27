import 'package:arthor/presentation/blocs/bottom_navigation_bloc/bottom_navigation_bloc.dart';
import 'package:arthor/presentation/screens/assigned_cases/assigned_casespage.dart';
import 'package:arthor/presentation/screens/screen_assignedpage/screen_assignedpage.dart';
import 'package:arthor/presentation/screens/screen_dashboardpage/screen_dashboardpage.dart';
import 'package:arthor/presentation/screens/screen_mainpage/widgets/customnav.dart';
import 'package:arthor/presentation/screens/screen_newcasespage/screen_newcasespage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenMainPage extends StatefulWidget {
  const ScreenMainPage({super.key});

  @override
  State<ScreenMainPage> createState() => _ScreenMainPageState();
}

class _ScreenMainPageState extends State<ScreenMainPage> {
  String _userRole = '';

  final List<Widget> _defaultPages = const [
    ScreenDashboardpage(),
    ScreenNewcasespage(),
    ScreenAssignedpage(),
  ];

  final List<Widget> _leadExecutivePages = const [
    ScreenDashboardpage(),
    ScreenNewcasespage(),
    ScreenAssignedpage(),
    ScreenAssignedCasespage(),
  ];

  bool get _isLeadExecutive => _userRole == 'LEAD_EXECUTIVE';

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final preferences = await SharedPreferences.getInstance();
    final storedRole = preferences.getString('USER_ROLE') ?? '';

    if (!mounted) return;

    setState(() {
      _userRole = storedRole;
    });

    final currentIndex =
        context.read<BottomNavigationBloc>().state.currentPageIndex;
    final currentPages = _isLeadExecutive ? _leadExecutivePages : _defaultPages;

    if (currentIndex >= currentPages.length) {
      context.read<BottomNavigationBloc>().add(
        NavigateToPageEvent(pageIndex: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = _isLeadExecutive ? _leadExecutivePages : _defaultPages;

    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        final safeIndex = state.currentPageIndex >= pages.length
            ? 0
            : state.currentPageIndex;

        return Scaffold(
          body: pages[safeIndex],
          bottomNavigationBar: BottomNavigationWidget(
            isLeadExecutive: _isLeadExecutive,
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
