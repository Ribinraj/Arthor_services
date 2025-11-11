import 'package:flutter/material.dart';

class ScreenAssignedpage extends StatefulWidget {
  const ScreenAssignedpage({super.key});

  @override
  State<ScreenAssignedpage> createState() => _ScreenAssignedpageState();
}

class _ScreenAssignedpageState extends State<ScreenAssignedpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('assigned'),
      ),
    );
  }
}