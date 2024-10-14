import 'package:flutter/widgets.dart';

class _Constants {
  static const mobileHeight = 1024;
  static const mobileWidth = 1366;
}

class PSMediaQuery {
  static late MediaQueryData mediaQueryData;

  static bool get isPad =>screenWidth > 480;

  static double get screenWidth => mediaQueryData.size.width;

  static double get screenHeight => mediaQueryData.size.height;

  static double get blockSizeHorizontal => screenWidth / 100;

  static double get blockSizeVertical => screenHeight / 100;

  static bool get isTablet => screenWidth > 480;

  static double get aspectRatio => mediaQueryData.size.aspectRatio;

  static EdgeInsets get padding => mediaQueryData.padding;
  static double get scaleFactorHeight => screenHeight/_Constants.mobileHeight;
  static double get scaleFactorWidth => screenWidth/_Constants.mobileWidth;


  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    _safeAreaHorizontal = mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical = mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
