import 'package:flutter/material.dart';
import 'package:responsive_design/responsive/desktopBody.dart';
import 'package:responsive_design/responsive/layout.dart';
import 'package:responsive_design/responsive/mobileBody.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color getBackgroundColor(double currentWidth) {
    if (currentWidth > 682) {
      return Colors.red;
    } else if (currentWidth < 150) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: getBackgroundColor(currentWidth),
      body: const Layout(
        mobileBody: MobileBody(),
        desktopBody: DesktopBody(),
      ),
    );
  }
}
