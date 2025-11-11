import 'package:flutter/material.dart';

class ScreenNewcasespage extends StatefulWidget {
  const ScreenNewcasespage({super.key});

  @override
  State<ScreenNewcasespage> createState() => _ScreenNewcasespageState();
}

class _ScreenNewcasespageState extends State<ScreenNewcasespage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('new cases'),),
    );
  }
}