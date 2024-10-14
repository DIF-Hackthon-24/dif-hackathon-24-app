import 'navigation_break_point.dart';

abstract class BreakPointManager {
  /// Store a breakpoint to retrieve later.
  /// Based on the View you can provide optional parameters like pageView index
  /// If you want to store map of navigation arguments, set it in extraArguments[NavigationBreakPoint.navigationArguments]
  Future<void> storeBreakPoint({
    required String navigationPackage,
    String? routeName,
    Map<String, dynamic>? extraArguments,
  });

  Future<NavigationBreakPoint?> getLastBreakPoint({bool showLoader = true});

  /// navigate to the latest stored breakpoint
  Future<void> restoreFromLastBreakPoint({required bool isUserAuthenticated});

  /// verify if has previously stored a breakpoint
  Future<bool> hasBreakPoint();

  /// Clear the last breakpoint if there are any stored
  Future<void> clearBreakPoint();
}
