import 'package:flutter/material.dart';

class SwipeContainer {

  SwipeContainer(this.swipeWidget);

  Widget Function({
    required Widget child,
    required String text,
    VoidCallback? onSwipeUp,
  })? swipeWidget;
}
