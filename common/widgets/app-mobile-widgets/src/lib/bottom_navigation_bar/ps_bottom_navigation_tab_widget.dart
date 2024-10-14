import 'package:flutter/material.dart';
import 'package:widget_library/bottom_navigation_bar/ps_bottom_navigation_tab_widget_attributes.dart';

class _Constants {
  static const borderRadius = 32.0;
  static const double selectedUnselectedPadding = 0;
}

class PSBottomNavigationTabWidget extends StatefulWidget {
  PSBottomNavigationTabWidget({
    Key? key,
    required this.attributes,
  }) : super(key: key);

  final PSBottomNavigationAttributes attributes;

  @override
  _PSBottomNavigationTabWidgetState createState() => _PSBottomNavigationTabWidgetState();
}

class _PSBottomNavigationTabWidgetState extends State<PSBottomNavigationTabWidget> {
  final radius = Radius.circular(_Constants.borderRadius);
  DateTime currentBackPressTime = DateTime.now();
  var backButtonPressed = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        onWillPop(context);
      },
      child: buildBottomBar(context),
    );
  }

  Future<bool> onWillPop(BuildContext context) {
   backButtonPressed = backButtonPressed +1;
    if (widget.attributes.tabIndex == 0) {
      if (widget.attributes.isDrawerOpen == true) {
        widget.attributes.goBack?.call();
        return Future.value(true);
      } else {
        if (DateTime.now().difference(currentBackPressTime).inSeconds > 2) {
          currentBackPressTime = DateTime.now();
          _showSnackBar(context);
          backButtonPressed = backButtonPressed +1;
          return Future.value(false);
        } else if(backButtonPressed >= 2){
          return Future.value(true);
        } else {
          backButtonPressed = 0;
          return Future.value(false);
        }
      }
    } else {
      if (widget.attributes.isDrawerOpen == true) {
        widget.attributes.goBack?.call();
        return Future.value(true);
      }
      widget.attributes.goBack?.call();
      return Future.value(false);
    }
  }

  void _showSnackBar(BuildContext context) {
    final showMessage = ScaffoldMessenger.of(context);
    showMessage.showSnackBar(
      SnackBar(
        key: Key('PSBottomNavigationTabWidget_SnackBar'),
        content: Text(widget.attributes.snackBarText ?? '', key: Key('Text')),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget buildBottomBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child:BottomNavigationBar(

      selectedFontSize: _Constants.selectedUnselectedPadding,
      unselectedFontSize: _Constants.selectedUnselectedPadding,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: widget.attributes.tabBackgroundColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.attributes.tabIndex,
      onTap: (int index) {
        widget.attributes.onTap(index);
      },
      items: widget.attributes.bottomNavigation,),
    );
  }
}
