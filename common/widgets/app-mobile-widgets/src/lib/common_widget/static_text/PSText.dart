import 'package:core/translation/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';

class _Constants {
  static const arabicKey = 'ar';
}

/// The possible button themes
enum PSTextStyleVariant {
  normal, // primary text - bodyText1
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  subtitle1,
  subtitle2,
  bodyText2,
  bodyText1,
  transactionRowAmountStrike,
  hints,
  amount,
  otp,
  caption,
  sectionHeader,
  rowTitle,
  rowSubtitle,
  transactionRowTitle,
  transactionRowSubTitle,
  transactionRowAmount,
  iconTitle,
  tag,
}

enum PSTextVerticalSpacing {
  normal,
  narrow,
  wide,
}

double _lineHeight(PSTextVerticalSpacing? verticalSpacing) {
  switch (verticalSpacing) {
    case PSTextVerticalSpacing.narrow:
      return 1.0;
    case PSTextVerticalSpacing.normal:
      return 1.2;
    case PSTextVerticalSpacing.wide:
      return 1.5;
    default:
      return 1.2;
  }
}

// ignore: long-method
TextStyle buildTextStyle({
  required BuildContext context,
  required PSTextStyleVariant variant,
  PSTextVerticalSpacing? verticalSpacing,
  bool? isUnderLinedText,
}) {
  final language = Localizations.localeOf(context).languageCode;
  final lineHeight =  language ==  _Constants.arabicKey ? 1.5 : _lineHeight(verticalSpacing);

  switch (variant) {
    case PSTextStyleVariant.headline1:
      return Theme.of(context).textTheme.displayLarge!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.displayLarge!.fontFamily}Arabic'
              : Theme.of(context).textTheme.displayLarge!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.headline2:
      return Theme.of(context).textTheme.displayMedium!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.displayMedium!.fontFamily}Arabic'
              : Theme.of(context).textTheme.displayMedium!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.headline3:
      return Theme.of(context).textTheme.displaySmall!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.displaySmall!.fontFamily}Arabic'
              : Theme.of(context).textTheme.displaySmall!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.headline4:
      return Theme.of(context).textTheme.headlineMedium!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.headlineMedium!.fontFamily}Arabic'
              : Theme.of(context).textTheme.headlineMedium!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.headline5:
      return Theme.of(context).textTheme.headlineSmall!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.headlineSmall!.fontFamily}Arabic'
              : Theme.of(context).textTheme.headlineSmall!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.headline6:
      return Theme.of(context).textTheme.titleLarge!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.titleLarge!.fontFamily}Arabic'
              : Theme.of(context).textTheme.titleLarge!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.hints:
      return Theme.of(context).inputDecorationTheme.hintStyle!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).inputDecorationTheme.hintStyle!.fontFamily}Arabic'
              : Theme.of(context).inputDecorationTheme.hintStyle!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.subtitle1:
      return Theme.of(context).textTheme.titleMedium!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.titleMedium!.fontFamily}Arabic'
              : Theme.of(context).textTheme.titleMedium!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.subtitle2:
      return Theme.of(context).textTheme.titleSmall!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.titleSmall!.fontFamily}Arabic'
              : Theme.of(context).textTheme.titleSmall!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.bodyText1:
      return Theme.of(context).textTheme.bodyLarge!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.bodyLarge!.fontFamily}Arabic'
              : Theme.of(context).textTheme.bodyLarge!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.bodyText2:
      return Theme.of(context).textTheme.bodyMedium!.copyWith(
          height: lineHeight,
          fontFamily: language == _Constants.arabicKey
              ? '${Theme.of(context).textTheme.bodyMedium!.fontFamily}Arabic'
              : Theme.of(context).textTheme.bodyMedium!.fontFamily,
          decoration: isUnderLinedText ?? false ? TextDecoration.underline : TextDecoration.none);

    case PSTextStyleVariant.amount:
      return Theme.of(context).textTheme.bodyMedium!.copyWith(
            height: lineHeight,
            fontFamily: language == _Constants.arabicKey
                ? '${Theme.of(context).textTheme.bodyMedium!.fontFamily}Arabic'
                : Theme.of(context).textTheme.bodyMedium!.fontFamily,
          );

    case PSTextStyleVariant.otp:
      return Theme.of(context).textTheme.displaySmall!.copyWith(
            height: lineHeight,
            fontFamily: language == _Constants.arabicKey
                ? '${Theme.of(context).textTheme.displaySmall!.fontFamily}Arabic'
                : Theme.of(context).textTheme.displaySmall!.fontFamily,
          );

    case PSTextStyleVariant.caption:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            height: lineHeight,
            fontFamily: language == _Constants.arabicKey
                ? '${Theme.of(context).textTheme.displayLarge!.fontFamily}Arabic'
                : Theme.of(context).textTheme.displayLarge!.fontFamily,
          );
    case PSTextStyleVariant.sectionHeader:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: 'ActivGrotesk',
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          );

    case PSTextStyleVariant.rowTitle:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: 'ActivGrotesk',
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          );
    case PSTextStyleVariant.rowSubtitle:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: 'ActivGrotesk',
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          );
    case PSTextStyleVariant.transactionRowTitle:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: 'ActivGrotesk',
            fontSize: 14.0,
            color: Theme.of(context).primaryColor,
          );

    case PSTextStyleVariant.transactionRowAmount:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontFamily: 'ActivGrotesk',
            fontSize: 18.0,
            color: Theme.of(context).primaryColor,
          );

    case PSTextStyleVariant.transactionRowAmountStrike:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            decoration: TextDecoration.lineThrough,
            fontSize: 18.0,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
          );
    case PSTextStyleVariant.transactionRowSubTitle:
      return Theme.of(context).textTheme.titleMedium!.copyWith(
            fontFamily: 'ActivGrotesk',
            fontSize: 12.0,
            color: Theme.of(context).disabledColor,
          );
    case PSTextStyleVariant.iconTitle:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 13.0,
            fontFamily: 'ActivGrotesk',
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hintColor,
          );
    case PSTextStyleVariant.tag:
      return Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 11.0,
            fontFamily: 'ActivGrotesk',
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hintColor,
          );
    default:
      return Theme.of(context).textTheme.bodyLarge!.copyWith(height: lineHeight);
  }
}

///
/// A variant of the [PSDockedButton] that wraps the [ElevatedButton] and
/// restyles it rather then extending the [ButtonStyleButton]
///
class PSText extends StatelessWidget {
  final TextUIDataModel text;

  final Padding? padding;
  final bool? isUnderLinedText;

  /// The variant controls the button colours and can be `primary`, the default,
  /// `secondary` and `tertiary`
  final PSTextVerticalSpacing? lineVerticalSpacing;

  PSText({
    Key? key,
    required this.text,
    this.padding,
    this.lineVerticalSpacing,
    this.isUnderLinedText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = buildTextStyle(
      context: context,
      variant: text.styleVariant ?? PSTextStyleVariant.normal,
      verticalSpacing: lineVerticalSpacing,
      isUnderLinedText: isUnderLinedText,
    );

    return Text(
      AppLocalizations.of(context)!.translate(text.text),
      key: Key('Text'),
      style: textStyle,
      overflow: text.overflow,
      textAlign: text.textAlign,
      maxLines: text.maxLines,
    );
  }
}

class PSTextSpan extends TextSpan {
  PSTextSpan({
    required BuildContext context,
    required TextUIDataModel text,
  }) : super(
          text: AppLocalizations.of(context)!.translate(text.text),
          style: buildTextStyle(
            context: context,
            variant: text.styleVariant ?? PSTextStyleVariant.normal,
          ),
        );
}
