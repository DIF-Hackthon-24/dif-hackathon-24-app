// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ps_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PSColorPalette _$PSColorPaletteFromJson(Map<String, dynamic> json) =>
    PSColorPalette(
      primary: json['primary'] as String?,
      secondary: json['secondary'] as String?,
      tertiary: json['tertiary'] as String?,
      quaternary: json['quaternary'] as String?,
      quinary: json['quinary'] as String?,
      senary: json['senary'] as String?,
      septenary: json['septenary'] as String?,
      octonary: json['octonary'] as String?,
      nonary: json['nonary'] as String?,
      denary: json['denary'] as String?,
      infoIcon: json['infoIcon'] as String?,
      panelColorPrimary: json['panelColorPrimary'] as String?,
      panelColorSecondary: json['panelColorSecondary'] as String?,
      panelColorTertiary: json['panelColorTertiary'] as String?,
    );

Map<String, dynamic> _$PSColorPaletteToJson(PSColorPalette instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'secondary': instance.secondary,
      'tertiary': instance.tertiary,
      'quaternary': instance.quaternary,
      'quinary': instance.quinary,
      'senary': instance.senary,
      'septenary': instance.septenary,
      'octonary': instance.octonary,
      'nonary': instance.nonary,
      'denary': instance.denary,
      'infoIcon': instance.infoIcon,
      'panelColorPrimary': instance.panelColorPrimary,
      'panelColorSecondary': instance.panelColorSecondary,
      'panelColorTertiary': instance.panelColorTertiary,
    };

PSSliderThemeData _$PSSliderThemeDataFromJson(Map<String, dynamic> json) =>
    PSSliderThemeData(
      activeTrackColor: json['activeTrackColor'] as String?,
      inactiveTrackColor: json['inactiveTrackColor'] as String?,
    );

Map<String, dynamic> _$PSSliderThemeDataToJson(PSSliderThemeData instance) =>
    <String, dynamic>{
      'activeTrackColor': instance.activeTrackColor,
      'inactiveTrackColor': instance.inactiveTrackColor,
    };

PSCardThemeData _$PSCardThemeDataFromJson(Map<String, dynamic> json) =>
    PSCardThemeData(
      color: json['color'] as String?,
      shadowColor: json['shadowColor'] as String?,
      elevation: (json['elevation'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PSCardThemeDataToJson(PSCardThemeData instance) =>
    <String, dynamic>{
      'color': instance.color,
      'shadowColor': instance.shadowColor,
      'elevation': instance.elevation,
    };

PSAppBarThemeData _$PSAppBarThemeDataFromJson(Map<String, dynamic> json) =>
    PSAppBarThemeData(
      foregroundColor: json['foregroundColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      iconTheme: json['iconTheme'] == null
          ? null
          : PSStyleData.fromJson(json['iconTheme'] as Map<String, dynamic>),
      actionIconsTheme: json['actionIconsTheme'] == null
          ? null
          : PSStyleData.fromJson(
              json['actionIconsTheme'] as Map<String, dynamic>),
      titleTextStyle: json['titleTextStyle'] == null
          ? null
          : PSStyleData.fromJson(
              json['titleTextStyle'] as Map<String, dynamic>),
      textThemeData: json['textTheme'] == null
          ? null
          : PSTextThemeData.fromJson(json['textTheme'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSAppBarThemeDataToJson(PSAppBarThemeData instance) =>
    <String, dynamic>{
      'foregroundColor': instance.foregroundColor,
      'backgroundColor': instance.backgroundColor,
      'iconTheme': instance.iconTheme,
      'actionIconsTheme': instance.actionIconsTheme,
      'titleTextStyle': instance.titleTextStyle,
      'textTheme': instance.textThemeData,
    };

PSStyleData _$PSStyleDataFromJson(Map<String, dynamic> json) => PSStyleData(
      color: json['color'] as String?,
      fontFamily: json['fontFamily'] as String?,
      fontSize: (json['fontSize'] as num?)?.toDouble(),
      opacity: (json['opacity'] as num?)?.toDouble(),
      textColor: json['textColor'] as String?,
      minimumSize: (json['minimumSize'] as num?)?.toDouble(),
      borderRadius: (json['borderRadius'] as num?)?.toDouble(),
      fontWeight: json['fontWeight'] as int?,
    );

Map<String, dynamic> _$PSStyleDataToJson(PSStyleData instance) =>
    <String, dynamic>{
      'color': instance.color,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'opacity': instance.opacity,
      'textColor': instance.textColor,
      'minimumSize': instance.minimumSize,
      'borderRadius': instance.borderRadius,
      'fontWeight': instance.fontWeight,
    };

PSTextThemeData _$PSTextThemeDataFromJson(Map<String, dynamic> json) =>
    PSTextThemeData(
      headline1: json['headline1'] == null
          ? null
          : PSStyleData.fromJson(json['headline1'] as Map<String, dynamic>),
      headline2: json['headline2'] == null
          ? null
          : PSStyleData.fromJson(json['headline2'] as Map<String, dynamic>),
      headline3: json['headline3'] == null
          ? null
          : PSStyleData.fromJson(json['headline3'] as Map<String, dynamic>),
      headline4: json['headline4'] == null
          ? null
          : PSStyleData.fromJson(json['headline4'] as Map<String, dynamic>),
      headline5: json['headline5'] == null
          ? null
          : PSStyleData.fromJson(json['headline5'] as Map<String, dynamic>),
      headline6: json['headline6'] == null
          ? null
          : PSStyleData.fromJson(json['headline6'] as Map<String, dynamic>),
      subtitle1: json['subtitle1'] == null
          ? null
          : PSStyleData.fromJson(json['subtitle1'] as Map<String, dynamic>),
      subtitle2: json['subtitle2'] == null
          ? null
          : PSStyleData.fromJson(json['subtitle2'] as Map<String, dynamic>),
      bodyText1: json['bodyText1'] == null
          ? null
          : PSStyleData.fromJson(json['bodyText1'] as Map<String, dynamic>),
      bodyText2: json['bodyText2'] == null
          ? null
          : PSStyleData.fromJson(json['bodyText2'] as Map<String, dynamic>),
      caption: json['caption'] == null
          ? null
          : PSStyleData.fromJson(json['caption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSTextThemeDataToJson(PSTextThemeData instance) =>
    <String, dynamic>{
      'headline1': instance.headline1,
      'headline2': instance.headline2,
      'headline3': instance.headline3,
      'headline4': instance.headline4,
      'headline5': instance.headline5,
      'headline6': instance.headline6,
      'subtitle1': instance.subtitle1,
      'subtitle2': instance.subtitle2,
      'bodyText1': instance.bodyText1,
      'bodyText2': instance.bodyText2,
      'caption': instance.caption,
    };

PSInputDecorationThemeData _$PSInputDecorationThemeDataFromJson(
        Map<String, dynamic> json) =>
    PSInputDecorationThemeData(
      hintStyle: json['hintStyle'] == null
          ? null
          : PSStyleData.fromJson(json['hintStyle'] as Map<String, dynamic>),
      errorStyle: json['errorStyle'] == null
          ? null
          : PSStyleData.fromJson(json['errorStyle'] as Map<String, dynamic>),
      labelStyle: json['labelStyle'] == null
          ? null
          : PSStyleData.fromJson(json['labelStyle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PSInputDecorationThemeDataToJson(
        PSInputDecorationThemeData instance) =>
    <String, dynamic>{
      'hintStyle': instance.hintStyle,
      'errorStyle': instance.errorStyle,
      'labelStyle': instance.labelStyle,
    };

PSScreenThemeData _$PSScreenThemeDataFromJson(Map<String, dynamic> json) =>
    PSScreenThemeData(
      screenName: json['screenName'] as String,
      primaryColor: json['primaryColor'] as String?,
      primaryColorDark: json['primaryColorDark'] as String?,
      primaryColorLight: json['primaryColorLight'] as String?,
      splashColor: json['splashColor'] as String?,
      scaffoldBackgroundColor: json['scaffoldBackgroundColor'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      errorColor: json['errorColor'] as String?,
      bottomAppBarColor: json['bottomAppBarColor'] as String?,
      toggleableActiveColor: json['toggleableActiveColor'] as String?,
      dividerColor: json['dividerColor'] as String?,
      highlightTextColor: json['highlightTextColor'] as String?,
      textFieldBackgroundColor: json['textFieldBackgroundColor'] as String?,
      actionButtonIconColor: json['actionButtonIconColor'] as String?,
      iconTheme: json['iconTheme'] == null
          ? null
          : PSStyleData.fromJson(json['iconTheme'] as Map<String, dynamic>),
      appBarTheme: json['appBarTheme'] == null
          ? null
          : PSAppBarThemeData.fromJson(
              json['appBarTheme'] as Map<String, dynamic>),
      cardTheme: json['cardTheme'] == null
          ? null
          : PSCardThemeData.fromJson(json['cardTheme'] as Map<String, dynamic>),
      textTheme: json['textTheme'] == null
          ? null
          : PSTextThemeData.fromJson(json['textTheme'] as Map<String, dynamic>),
      elevatedButtonTheme: json['elevatedButtonTheme'] == null
          ? null
          : PSStyleData.fromJson(
              json['elevatedButtonTheme'] as Map<String, dynamic>),
      textButtonTheme: json['textButtonTheme'] == null
          ? null
          : PSStyleData.fromJson(
              json['textButtonTheme'] as Map<String, dynamic>),
      textSelectionTheme: json['textSelectionTheme'] == null
          ? null
          : PSStyleData.fromJson(
              json['textSelectionTheme'] as Map<String, dynamic>),
      inputDecorationTheme: json['inputDecorationTheme'] == null
          ? null
          : PSInputDecorationThemeData.fromJson(
              json['inputDecorationTheme'] as Map<String, dynamic>),
      checkboxThemeData: json['checkboxThemeData'] == null
          ? null
          : PSStyleData.fromJson(
              json['checkboxThemeData'] as Map<String, dynamic>),
      segmentedThemeData: json['segmentedThemeData'] == null
          ? null
          : PSStyleData.fromJson(
              json['segmentedThemeData'] as Map<String, dynamic>),
      sliderTheme: json['sliderTheme'] == null
          ? null
          : PSSliderThemeData.fromJson(
              json['sliderTheme'] as Map<String, dynamic>),
      shadowColor: json['shadowColor'] as String?,
      midNightTint: json['midNightTint'] as String?,
    );

Map<String, dynamic> _$PSScreenThemeDataToJson(PSScreenThemeData instance) =>
    <String, dynamic>{
      'screenName': instance.screenName,
      'highlightTextColor': instance.highlightTextColor,
      'actionButtonIconColor': instance.actionButtonIconColor,
      'textFieldBackgroundColor': instance.textFieldBackgroundColor,
      'primaryColor': instance.primaryColor,
      'primaryColorDark': instance.primaryColorDark,
      'primaryColorLight': instance.primaryColorLight,
      'splashColor': instance.splashColor,
      'scaffoldBackgroundColor': instance.scaffoldBackgroundColor,
      'backgroundColor': instance.backgroundColor,
      'errorColor': instance.errorColor,
      'bottomAppBarColor': instance.bottomAppBarColor,
      'toggleableActiveColor': instance.toggleableActiveColor,
      'dividerColor': instance.dividerColor,
      'shadowColor': instance.shadowColor,
      'midNightTint': instance.midNightTint,
      'iconTheme': instance.iconTheme,
      'appBarTheme': instance.appBarTheme,
      'cardTheme': instance.cardTheme,
      'textTheme': instance.textTheme,
      'elevatedButtonTheme': instance.elevatedButtonTheme,
      'textButtonTheme': instance.textButtonTheme,
      'textSelectionTheme': instance.textSelectionTheme,
      'inputDecorationTheme': instance.inputDecorationTheme,
      'checkboxThemeData': instance.checkboxThemeData,
      'segmentedThemeData': instance.segmentedThemeData,
      'sliderTheme': instance.sliderTheme,
    };

PSThemeData _$PSThemeDataFromJson(Map<String, dynamic> json) => PSThemeData(
      colorPalette: json['colors'] == null
          ? null
          : PSColorPalette.fromJson(json['colors'] as Map<String, dynamic>),
      screens: (json['screens'] as List<dynamic>)
          .map((e) => PSScreenThemeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PSThemeDataToJson(PSThemeData instance) =>
    <String, dynamic>{
      'colors': instance.colorPalette,
      'screens': instance.screens,
    };
