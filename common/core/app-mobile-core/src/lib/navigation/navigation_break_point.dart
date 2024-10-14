import 'package:core/navigation/navigation_manager.dart';

class NavigationBreakPoint {
  final String lastRouteName;
  final String previousRouteName;
  Map<String, dynamic> extraNavigationInfo = {};

  static const String lastRouteNameKey = 'lastRouteName';
  static const String previousRouteNameKey = 'previousRouteName';
  static const String extraNavigationInfoKey = 'extraNavigationInfo';
  static const String navigationTypeKey = 'navigationType';
  static const String authenticationRequired = 'authenticationRequired';
  static const String pageViewerIndexKey = 'pageViewerIndex';
  static const String onboardingStageSuccess = 'onboardingStageSuccess';
  static const String navigationArguments = 'navigationArguments';

  static String onboardingStepsKyc = 'onboardingStageKYC';
  static String onboardingIsFastTrack = 'onboardingIsFastTrack';

  NavigationBreakPoint({
    required this.lastRouteName,
    required this.previousRouteName,
  });

  bool get isAuthenticationRequired => true == (extraNavigationInfo[authenticationRequired] ?? false);

  Map<String, dynamic> toMap() => {
        lastRouteNameKey: lastRouteName,
        previousRouteNameKey: previousRouteName,
        extraNavigationInfoKey: extraNavigationInfo,
      };

  factory NavigationBreakPoint.fromMap(Map<String, dynamic> map) {
    final object = NavigationBreakPoint(
      lastRouteName: map[lastRouteNameKey] as String,
      previousRouteName: map[previousRouteNameKey] as String,
    );
    object.extraNavigationInfo = map[extraNavigationInfoKey] as Map<String, dynamic>;
    return object;
  }

  void setNavigationType(NavigationType navigationType) {
    setExtraArgument(navigationTypeKey, navigationType);
  }

  void setExtraArgument(String key, dynamic value) {
    extraNavigationInfo[key] = value;
  }

  dynamic getExtraArgument(String key) {
    return extraNavigationInfo[key];
  }

  void setPageViewerIndex(int index) {
    setExtraArgument(pageViewerIndexKey, index);
  }

  int getPageViewerIndex() {
    return extraNavigationInfo[pageViewerIndexKey] as int? ?? 0;
  }

  Map<String, dynamic>? getNavigationArguments() => extraNavigationInfo[navigationArguments] as Map<String, dynamic>?;
}
