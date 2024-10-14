import 'dart:ui';

import 'package:core/utils/extensions/object_extensions.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/input_field/ps_text_field.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/padding.dart';

part 'bank_card_widgets.dart';

class BankCard extends StatelessWidget {
  final bool frozen;
  final bool hideChip;
  final bool hideOverlay;
  final bool isVirtual;
  final Color? backgroundColor;
  final String cardNumber;
  final String cardHolder;
  final String? cardHolderCompany;
  final String? providerLogoUri;
  final Color? providerLogoColor;
  final String? brandLogoUri;
  final Function()? cardOnPressed;
  final bool isCreateMode;
  final Function(String value)? onCardHolderNameChanged;
  final Color? cursorColor;
  final String? cardHolderHintText;
  final bool shadowEnabled;
  final int? maxLength;
  final FocusNode? cardHolderFocusNode;

  const BankCard({
    Key? key,
    this.hideChip = false,
    this.hideOverlay = true,
    this.backgroundColor,
    required this.cardNumber,
    required this.cardHolder,
    this.cardHolderCompany,
    this.providerLogoUri,
    this.providerLogoColor,
    this.brandLogoUri,
    this.frozen = false,
    this.cardOnPressed,
    this.isVirtual = false,
    this.isCreateMode = false,
    this.onCardHolderNameChanged,
    this.cursorColor,
    this.cardHolderHintText,
    this.shadowEnabled = true,
    this.maxLength,
    this.cardHolderFocusNode,
  }) : super(key: key);

  const BankCard.virtual({
    Key? key,
    this.hideChip = true,
    this.hideOverlay = true,
    this.frozen = false,
    this.backgroundColor,
    required this.cardNumber,
    required this.cardHolder,
    this.cardHolderCompany,
    this.providerLogoUri,
    this.providerLogoColor,
    this.brandLogoUri,
    this.cardOnPressed,
    this.isVirtual = true,
    this.isCreateMode = false,
    this.onCardHolderNameChanged,
    this.cursorColor,
    this.cardHolderHintText,
    this.shadowEnabled = true,
    this.maxLength,
    this.cardHolderFocusNode,
  }) : super(key: key);

  /*

   */
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _Constants.cardDesignWidth,
      height: _Constants.cardDesignHeight,
      child: GestureDetector(
        onTap: cardOnPressed,
        child: frozen
            ? ClipRRect(
                borderRadius: BorderRadius.circular(_Constants.mainBorderRadius),
                child: ImageFiltered(
                  key: Key('BankCard_cardComposition_ImageFiltered'),
                  imageFilter: ImageFilter.blur(
                    sigmaX: _Constants.frozenBlurSigma,
                    sigmaY: _Constants.frozenBlurSigma,
                  ),
                  child: body(),
                ))
            : body(),
      ),
    );
  }

  Widget body() {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: _BackgroundLayer(
            isVirtual: isVirtual,
            backgroundColor: backgroundColor,
            brandLogoUri: brandLogoUri,
            hideOverlay: hideOverlay,
            shadowEnabled: shadowEnabled,
          ),
        ),
        if (!hideChip) const _Chip(),
        if (frozen) const _FrozenLayer(),
        _CardNumber(
          cardNumber: cardNumber,
          isVirtual: isVirtual,
        ),
        _CardHolder(
          cardHolder: cardHolder,
          isCreateMode: isCreateMode,
          onChanged: onCardHolderNameChanged,
          cursorColor: cursorColor,
          hintText: cardHolderHintText,
          isVirtual: isVirtual,
          maxLength: maxLength,
          focusNode: cardHolderFocusNode,
        ),
        _CardHolderCompany(cardHolderCompanyName: cardHolderCompany),
        _CardProviderLogo(
          providerLogoUri: providerLogoUri,
          providerLogoColor: providerLogoColor,
        ),
      ],
    );
  }
}
