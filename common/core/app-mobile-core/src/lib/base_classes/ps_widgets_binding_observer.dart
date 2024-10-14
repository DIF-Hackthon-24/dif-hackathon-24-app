import 'package:flutter/widgets.dart';

mixin PSWidgetsBindingObserver {
  /// Called when the system puts the app in the background or returns
  /// the app to the foreground.
  ///
  /// An example of implementing this method is provided in the class-level
  /// documentation for the [WidgetsBindingObserver] class.
  ///
  /// This method exposes notifications from [SystemChannels.lifecycle].
  void psDidChangeAppLifecycleState(AppLifecycleState state) { }
}