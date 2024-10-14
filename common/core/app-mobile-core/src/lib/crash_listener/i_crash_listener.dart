// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/foundation.dart';

abstract class ICrashListener {
  ///logs common events names with properties
  // void logEvent({required String eventName, Map<String, dynamic>? properties});

  /// Initializes the analytics tool with the api and/or project token
  /// defined in the .env.(current environment) file.
  ///
  /// e.g. MixPanelAnalytics does not require an explicit initialization
  /// as it initialzes the tool when first logEvent is executed.
  void initialize();

  void recordCrashes({required bool record});

  void updateUserDetails(String userId);
  void updateEnvironemnt(String environment);

  void unhandledErrors(FlutterErrorDetails details);
  void unhandledExceptions(Object error, StackTrace? trace);
}
