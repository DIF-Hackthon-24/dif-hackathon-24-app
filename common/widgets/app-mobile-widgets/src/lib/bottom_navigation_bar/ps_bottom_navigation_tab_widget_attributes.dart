import 'package:flutter/material.dart';

class PSBottomNavigationAttributes {
  int tabIndex;
  final List<Widget> tabScreens;
  final Color? tabBackgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final List<BottomNavigationBarItem> bottomNavigation;
  final Function(int) onTap;
  final Function? goBack;
  final bool? isDrawerOpen;
  final String themeName;
  final String? snackBarText;

  PSBottomNavigationAttributes({
    required this.themeName,
    required this.tabIndex,
    required this.tabScreens,
    required this.bottomNavigation,
    required this.onTap,
    this.isDrawerOpen,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.tabBackgroundColor,
    this.snackBarText,
    this.goBack,
  });
}
