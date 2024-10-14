import 'package:flutter/material.dart';
import 'ps_bottom_navigation_tab_widget_attributes.dart';

class _Constants {
  static const borderRadius = 32.0;
  static const shadowRadius = 20.0;
  static const bottomTabHeight = 92.0;
}

class PSBottomNavigationBarContanerWidget extends StatefulWidget {
  final PSBottomNavigationAttributes attributes;
  final Function(int) onTap;
  final int selectedTabIndex;

  PSBottomNavigationBarContanerWidget({
    Key? key,
    required this.attributes,
    required this.onTap,
    this.selectedTabIndex = 0,
  }) : super(key: key);

  @override
  _PSBottomNavigationBarContanerWidgetState createState() => _PSBottomNavigationBarContanerWidgetState();
}

class _PSBottomNavigationBarContanerWidgetState extends State<PSBottomNavigationBarContanerWidget> {
  late int _selectedTabIndex;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = widget.selectedTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('PSBottomNavigationBarContanerWidget_Container'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            _Constants.borderRadius,
          ),
          topLeft: Radius.circular(
            _Constants.borderRadius,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(244, 244, 240, 0.5),
            spreadRadius: 0,
            blurRadius: _Constants.shadowRadius,
          ),
        ],
      ),
      child: ClipRRect(
        key: Key('PSBottomNavigationBarContanerWidget_ClipRect'),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(_Constants.borderRadius),
          topRight: Radius.circular(_Constants.borderRadius),
        ),
        child: SizedBox(
          key: Key('PSBottomNavigationBarContanerWidget_SizedBox'),
          height: _Constants.bottomTabHeight,
          child: BottomNavigationBar(
            key: Key('PSBottomNavigationBarContanerWidget_BottomNavigationBar'),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: widget.attributes.tabBackgroundColor,
            // selectedItemColor: (widget.attributes.selectedItemColor != null)
            //     ? widget.attributes.selectedItemColor
            //     : PSTheme.of(context).theme.colorStyles.buttonColors.primary.normal.color,
            // unselectedItemColor: (widget.attributes.unselectedItemColor != null)
            //     ? widget.attributes.unselectedItemColor
            //     : PSTheme.of(context).theme.colorStyles.buttonColors.primary.disabled.color,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedTabIndex,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
              widget.onTap(index);
            },
            items: widget.attributes.bottomNavigation,
          ),
        ),
      ),
    );
  }
}
