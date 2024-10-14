// ignore_for_file: empty_catches

import 'dart:convert';

import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:json_annotation/json_annotation.dart';

part 'ps_theme.g.dart';

@JsonSerializable()
class PSColorPalette {
  String? primary;
  String? secondary;
  String? tertiary;
  String? quaternary;
  String? quinary;
  String? senary;
  String? septenary;
  String? octonary;
  String? nonary;
  String? denary;
  String? infoIcon;
  String? panelColorPrimary;
  String? panelColorSecondary;
  String? panelColorTertiary;

  PSColorPalette({
    this.primary,
    this.secondary,
    this.tertiary,
    this.quaternary,
    this.quinary,
    this.senary,
    this.septenary,
    this.octonary,
    this.nonary,
    this.denary,
    this.infoIcon,
    this.panelColorPrimary,
    this.panelColorSecondary,
    this.panelColorTertiary,
  });

  factory PSColorPalette.fromJson(Map<String, dynamic> json) => _$PSColorPaletteFromJson(json);
  Map<String, dynamic> toJson() => _$PSColorPaletteToJson(this);
}

@JsonSerializable()
class PSSliderThemeData {
  String? activeTrackColor;
  String? inactiveTrackColor;

  PSSliderThemeData({
    this.activeTrackColor,
    this.inactiveTrackColor,
  });

  factory PSSliderThemeData.fromJson(Map<String, dynamic> json) => _$PSSliderThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSSliderThemeDataToJson(this);
}

@JsonSerializable()
class PSCardThemeData {
  final String? color;
  final String? shadowColor;
  final double? elevation;
  PSCardThemeData({
    this.color,
    this.shadowColor,
    this.elevation,
  });

  factory PSCardThemeData.fromJson(Map<String, dynamic> json) => _$PSCardThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSCardThemeDataToJson(this);
}

@JsonSerializable()
class PSAppBarThemeData {
  String? foregroundColor;
  String? backgroundColor;
  PSStyleData? iconTheme;
  PSStyleData? actionIconsTheme;
  PSStyleData? titleTextStyle;

  @JsonKey(name: 'textTheme')
  PSTextThemeData? textThemeData;

  PSAppBarThemeData({
    this.foregroundColor,
    this.backgroundColor,
    this.iconTheme,
    this.actionIconsTheme,
    this.titleTextStyle,
    this.textThemeData,
  });

  factory PSAppBarThemeData.fromJson(Map<String, dynamic> json) => _$PSAppBarThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSAppBarThemeDataToJson(this);
}

@JsonSerializable()
class PSStyleData {
  String? color;
  String? fontFamily;
  double? fontSize;
  double? opacity;
  String? textColor;
  double? minimumSize;
  double? borderRadius;
  int? fontWeight;

  PSStyleData({
    this.color,
    this.fontFamily,
    this.fontSize,
    this.opacity,
    this.textColor,
    this.minimumSize,
    this.borderRadius,
    this.fontWeight,
  });

  factory PSStyleData.fromJson(Map<String, dynamic> json) => _$PSStyleDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSStyleDataToJson(this);
}

@JsonSerializable()
class PSTextThemeData {
  PSStyleData? headline1;
  PSStyleData? headline2;
  PSStyleData? headline3;
  PSStyleData? headline4;
  PSStyleData? headline5;
  PSStyleData? headline6;
  PSStyleData? subtitle1;
  PSStyleData? subtitle2;
  PSStyleData? bodyText1;
  PSStyleData? bodyText2;
  PSStyleData? caption;

  PSTextThemeData({
    this.headline1,
    this.headline2,
    this.headline3,
    this.headline4,
    this.headline5,
    this.headline6,
    this.subtitle1,
    this.subtitle2,
    this.bodyText1,
    this.bodyText2,
    this.caption,
  });

  factory PSTextThemeData.fromJson(Map<String, dynamic> json) => _$PSTextThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSTextThemeDataToJson(this);
}

@JsonSerializable()
class PSInputDecorationThemeData {
  PSStyleData? hintStyle;
  PSStyleData? errorStyle;
  PSStyleData? labelStyle;

  PSInputDecorationThemeData({
    this.hintStyle,
    this.errorStyle,
    this.labelStyle,
  });

  factory PSInputDecorationThemeData.fromJson(Map<String, dynamic> json) => _$PSInputDecorationThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSInputDecorationThemeDataToJson(this);
}

@JsonSerializable()
class PSScreenThemeData {
  String screenName;
  String? highlightTextColor;
  String? actionButtonIconColor;
  String? textFieldBackgroundColor;
  String? primaryColor;
  String? primaryColorDark;
  String? primaryColorLight;
  String? splashColor;
  String? scaffoldBackgroundColor;
  String? backgroundColor;
  String? errorColor;
  String? bottomAppBarColor;
  String? toggleableActiveColor;
  String? dividerColor;
  String? shadowColor;
  String? midNightTint;
  PSStyleData? iconTheme;
  PSAppBarThemeData? appBarTheme;
  PSCardThemeData? cardTheme;
  PSTextThemeData? textTheme;
  PSStyleData? elevatedButtonTheme;
  PSStyleData? textButtonTheme;
  PSStyleData? textSelectionTheme;
  PSInputDecorationThemeData? inputDecorationTheme;
  PSStyleData? checkboxThemeData;
  PSStyleData? segmentedThemeData;
  PSSliderThemeData? sliderTheme;

  PSScreenThemeData({
    required this.screenName,
    this.primaryColor,
    this.primaryColorDark,
    this.primaryColorLight,
    this.splashColor,
    this.scaffoldBackgroundColor,
    this.backgroundColor,
    this.errorColor,
    this.bottomAppBarColor,
    this.toggleableActiveColor,
    this.dividerColor,
    this.highlightTextColor,
    this.textFieldBackgroundColor,
    this.actionButtonIconColor,
    this.iconTheme,
    this.appBarTheme,
    this.cardTheme,
    this.textTheme,
    this.elevatedButtonTheme,
    this.textButtonTheme,
    this.textSelectionTheme,
    this.inputDecorationTheme,
    this.checkboxThemeData,
    this.segmentedThemeData,
    this.sliderTheme,
    this.shadowColor,
    this.midNightTint,
  });

  factory PSScreenThemeData.fromJson(Map<String, dynamic> json) => _$PSScreenThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSScreenThemeDataToJson(this);
}

@JsonSerializable()
class PSThemeData {
  @JsonKey(name: 'colors')
  PSColorPalette? colorPalette;

  List<PSScreenThemeData> screens;

  PSThemeData({
    this.colorPalette,
    required this.screens,
  });

  factory PSThemeData.fromJson(Map<String, dynamic> json) => _$PSThemeDataFromJson(json);
  Map<String, dynamic> toJson() => _$PSThemeDataToJson(this);
}

class PSTheme {
  ThemeData? defaultTheme;
  // late ThemeData currentTheme;

  late PSThemeData themeData;
  late PSScreenThemeData defaultThemeData;

  static final PSTheme _singleton = PSTheme._internal();

  factory PSTheme() {
    return _singleton;
  }

  PSTheme._internal();

  TextStyle? _buildTextStyle(PSStyleData? styleData) {
    if (styleData != null) {
      var fontWeightIndex = 3; // default font weight index
      if (styleData.fontWeight != null && styleData.fontWeight! >= 0 && styleData.fontWeight! <= 8) {
        fontWeightIndex = styleData.fontWeight!;
      }
      return TextStyle(
        color: styleData.color?.toColorWithOpacity(styleData.opacity ?? 1.0),
        fontFamily: styleData.fontFamily,
        fontSize: styleData.fontSize,
        fontWeight: FontWeight.values[fontWeightIndex],
      );
    }

    return null;
  }

  TextStyle? _buildTextStyleForButton(PSStyleData? styleData) {
    if (styleData != null) {
      var fontWeightIndex = 3; // default font weight index
      if (styleData.fontWeight != null && styleData.fontWeight! >= 0 && styleData.fontWeight! <= 8) {
        fontWeightIndex = styleData.fontWeight!;
      }
      return TextStyle(
        color: styleData.textColor?.toColorWithOpacity(styleData.opacity ?? 1.0),
        fontFamily: styleData.fontFamily,
        fontSize: styleData.fontSize,
        fontWeight: FontWeight.values[fontWeightIndex],
      );
    }

    return null;
  }

  Future<void> initialize() async {
    final serialisedJson = await rootBundle.loadString(
      'assets/styles/theme_data.json',
    );

    // Pull out the themes object and iterate over the themes
    final json = jsonDecode(serialisedJson) as Map<String, dynamic>;
    themeData = PSThemeData.fromJson(json);

    defaultTheme = _buildTheme(
      'default',
    );

    try {
      defaultThemeData =
          themeData.screens.firstWhere((element) => element.screenName.toLowerCase().compareTo('default') == 0);
    } on StateError {}
  }

  ElevatedButtonThemeData _buildElevatedButtonTheme(PSStyleData? elevatedButtonTheme) {
    var style = ElevatedButton.styleFrom(
      backgroundColor: elevatedButtonTheme?.color?.toColor(),
      foregroundColor: elevatedButtonTheme?.textColor?.toColor(),
      textStyle: _buildTextStyleForButton(elevatedButtonTheme),
      minimumSize:
          (elevatedButtonTheme?.minimumSize != null) ? Size.fromHeight(elevatedButtonTheme!.minimumSize!) : null,
      shape: (elevatedButtonTheme?.borderRadius != null)
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(elevatedButtonTheme!.borderRadius!),
            )
          : null,
    );
    return ElevatedButtonThemeData(
      style: style,
    );
  }

    TextTheme _buildTextTheme(
    PSTextThemeData? textTheme, {
    TextTheme? defaulTextTheme,
  }) {
    return TextTheme(
      displayLarge: (textTheme?.headline1 != null)
          ? _buildTextStyle(textTheme?.headline1)
          : defaulTextTheme?.displayLarge,
      displayMedium: (textTheme?.headline2 != null)
          ? _buildTextStyle(textTheme?.headline2)
          : defaulTextTheme?.displayMedium,
      displaySmall: (textTheme?.headline3 != null)
          ? _buildTextStyle(textTheme?.headline3)
          : defaulTextTheme?.displaySmall,
      headlineMedium: (textTheme?.headline4 != null)
          ? _buildTextStyle(textTheme?.headline4)
          : defaulTextTheme?.headlineMedium,
      headlineSmall: (textTheme?.headline5 != null)
          ? _buildTextStyle(textTheme?.headline5)
          : defaulTextTheme?.headlineSmall,
      titleLarge: (textTheme?.headline6 != null)
          ? _buildTextStyle(textTheme?.headline6)
          : defaultTheme?.textTheme.titleLarge,
      titleMedium: (textTheme?.subtitle1 != null)
          ? _buildTextStyle(textTheme?.subtitle1)
          : defaultTheme?.textTheme.titleMedium,
      titleSmall: (textTheme?.subtitle2 != null)
          ? _buildTextStyle(textTheme?.subtitle2)
          : defaultTheme?.textTheme.titleSmall,
      bodyLarge: (textTheme?.bodyText1 != null)
          ? _buildTextStyle(textTheme?.bodyText1)
          : defaultTheme?.textTheme.bodyLarge,
      bodyMedium: (textTheme?.bodyText2 != null)
          ? _buildTextStyle(textTheme?.bodyText2)
          : defaultTheme?.textTheme.bodyMedium,
      bodySmall: (textTheme?.caption != null)
          ? _buildTextStyle(textTheme?.caption)
          : defaultTheme?.textTheme.bodySmall,
    );
  }

  SliderThemeData? _buildSliderTheme(
    PSSliderThemeData? slideThemeData,
    SliderThemeData? defaultSlideThemeData,
  ) {
    final slider = slideThemeData != null
        ? SliderThemeData(
            activeTrackColor: slideThemeData.activeTrackColor.toColor(),
            inactiveTrackColor: slideThemeData.inactiveTrackColor.toColor(),
          )
        : defaultSlideThemeData;

    return slider;
  }

  ThemeData _buildTheme(
    String? screenName, {
    ThemeData? defaultThemeData,
  }) {
    if (screenName.isBlank()) {
      return defaultThemeData!;
    }
    PSScreenThemeData? screenThemeData;
    try {
      screenThemeData = themeData.screens.firstWhere((element) =>
          element.screenName
              .toLowerCase()
              .compareTo(screenName!.toLowerCase()) ==
          0);
    } on StateError {}

    return ThemeData(
      primaryColor: screenThemeData?.primaryColor?.toColor() ??
          defaultThemeData?.primaryColor,
      primaryColorDark: screenThemeData?.primaryColorDark?.toColor() ??
          defaultThemeData?.primaryColorDark,
      primaryColorLight: screenThemeData?.primaryColorLight?.toColor() ??
          defaultThemeData?.primaryColorLight,
      splashColor: screenThemeData?.splashColor?.toColor() ??
          defaultThemeData?.splashColor,
      scaffoldBackgroundColor:
          screenThemeData?.scaffoldBackgroundColor?.toColor() ??
              defaultThemeData?.scaffoldBackgroundColor,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: screenThemeData?.primaryColor?.toColor() ??
            defaultThemeData?.primaryColor ??
            Colors.black,
        onPrimary: screenThemeData?.primaryColor?.toColor() ??
            defaultThemeData?.primaryColor ??
            Colors.black,
        secondary: screenThemeData?.primaryColor?.toColor() ??
            defaultThemeData?.primaryColor ??
            Colors.black,
        onSecondary: screenThemeData?.primaryColor?.toColor() ??
            defaultThemeData?.primaryColor ??
            Colors.black,
        error: screenThemeData?.errorColor?.toColor() ??
            defaultThemeData?.colorScheme.error ??
            Colors.black,
        onError: screenThemeData?.errorColor?.toColor() ??
            defaultThemeData?.colorScheme.error ??
            Colors.black,
        background: screenThemeData?.backgroundColor?.toColor() ??
            defaultThemeData?.colorScheme.background ??
            Colors.black,
        onBackground: screenThemeData?.backgroundColor?.toColor() ??
            defaultThemeData?.colorScheme.background ??
            Colors.black,
        surface: Colors.yellow,
        onSurface: Colors.yellow,
      ),
      //backgroundColor: screenThemeData?.backgroundColor?.toColor() ?? defaultThemeData?.backgroundColor,
      //errorColor: screenThemeData?.errorColor?.toColor() ?? defaultThemeData?.errorColor,
      bottomAppBarTheme: BottomAppBarTheme(
        color: screenThemeData?.bottomAppBarColor?.toColor() ??
            defaultThemeData?.bottomAppBarTheme.color,
      ),
      //bottomAppBarColor: screenThemeData?.bottomAppBarColor?.toColor() ?? defaultThemeData?.bottomAppBarColor,
     /* toggleableActiveColor:
          screenThemeData?.toggleableActiveColor?.toColor() ??
              defaultThemeData?.toggleableActiveColor,*/
      dividerColor: screenThemeData?.dividerColor?.toColor() ??
          defaultThemeData?.dividerColor,
      sliderTheme: _buildSliderTheme(
        screenThemeData?.sliderTheme,
        defaultThemeData?.sliderTheme,
      ),
      iconTheme: IconThemeData(
        color: screenThemeData?.iconTheme?.color?.toColor() ??
            defaultThemeData?.iconTheme.color,
        size: screenThemeData?.iconTheme?.minimumSize ??
            defaultThemeData?.iconTheme.size,
      ),
      appBarTheme: AppBarTheme(
        foregroundColor:
            screenThemeData?.appBarTheme?.foregroundColor?.toColor() ??
                defaultThemeData?.appBarTheme.foregroundColor,
        backgroundColor:
            screenThemeData?.appBarTheme?.backgroundColor?.toColor() ??
                defaultThemeData?.appBarTheme.backgroundColor,
        iconTheme: IconThemeData(
          color: screenThemeData?.appBarTheme?.iconTheme?.color?.toColor() ??
              defaultThemeData?.appBarTheme.iconTheme?.color,
          size: screenThemeData?.appBarTheme?.iconTheme?.minimumSize ??
              defaultThemeData?.appBarTheme.iconTheme?.size,
        ),
        actionsIconTheme:
            (screenThemeData?.appBarTheme?.actionIconsTheme != null)
                ? IconThemeData(
                    color: screenThemeData?.appBarTheme?.actionIconsTheme?.color
                        ?.toColor())
                : defaultTheme?.appBarTheme.actionsIconTheme,
        titleTextStyle:
            _buildTextStyle(screenThemeData?.appBarTheme?.titleTextStyle) ??
                defaultThemeData?.appBarTheme.titleTextStyle,
        /* textTheme: _buildTextTheme(
          screenThemeData?.appBarTheme?.textThemeData,
        ), */
      ),
      cardTheme: CardTheme(
        color: screenThemeData?.cardTheme?.color?.toColor() ??
            defaultThemeData?.cardTheme.color,
        shadowColor: screenThemeData?.cardTheme?.shadowColor?.toColor() ??
            defaultThemeData?.cardTheme.shadowColor,
        elevation: screenThemeData?.cardTheme?.elevation ??
            defaultThemeData?.cardTheme.elevation,
      ),
      textTheme: _buildTextTheme(
        screenThemeData?.textTheme,
        defaulTextTheme: defaultTheme?.textTheme,
      ),
      elevatedButtonTheme: (screenThemeData?.elevatedButtonTheme != null)
          ? _buildElevatedButtonTheme(
              screenThemeData?.elevatedButtonTheme,
            )
          : defaultThemeData?.elevatedButtonTheme,
      textButtonTheme: (screenThemeData?.textButtonTheme != null)
          ? TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor:
                    screenThemeData?.textButtonTheme?.color?.toColor(),
                textStyle: _buildTextStyle(screenThemeData?.textButtonTheme),
              ),
            )
          : defaultThemeData?.textButtonTheme,
      textSelectionTheme: (screenThemeData?.textSelectionTheme != null)
          ? TextSelectionThemeData(
              cursorColor:
                  screenThemeData?.textSelectionTheme?.color?.toColor(),
            )
          : defaultThemeData?.textSelectionTheme,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: (screenThemeData?.inputDecorationTheme?.hintStyle != null)
            ? _buildTextStyle(
                screenThemeData?.inputDecorationTheme?.hintStyle,
              )
            : defaultThemeData?.inputDecorationTheme.hintStyle,
        errorStyle: (screenThemeData?.inputDecorationTheme?.errorStyle != null)
            ? _buildTextStyle(
                screenThemeData?.inputDecorationTheme?.errorStyle,
              )
            : defaultThemeData?.inputDecorationTheme.errorStyle,
        labelStyle: (screenThemeData?.inputDecorationTheme?.labelStyle != null)
            ? _buildTextStyle(
                screenThemeData?.inputDecorationTheme?.labelStyle,
              )
            : defaultThemeData?.inputDecorationTheme.labelStyle,
      ),
      checkboxTheme: (screenThemeData?.checkboxThemeData != null)
          ? CheckboxThemeData(
              checkColor: _CheckBoxThemeData(
                selected:
                    screenThemeData?.checkboxThemeData!.textColor.toColor(),
                disabled: screenThemeData?.checkboxThemeData!.color.toColor(),
              ),
            )
          : defaultTheme?.checkboxTheme,
      shadowColor: screenThemeData?.shadowColor?.toColor(),
    );
  }

  ThemeData themeFor(String? screenName) {
    if (screenName.isBlank()) {
      return defaultTheme!;
    } else {
      return _buildTheme(
        screenName,
        defaultThemeData: defaultTheme,
      );
    }
  }
}

@immutable
class _CheckBoxThemeData extends MaterialStateProperty<Color?> with Diagnosticable {
  _CheckBoxThemeData({
    this.selected,
    this.disabled,
  });

  final Color? selected;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.selected)) {
      return selected;
    }

    return disabled;
  }
}
