part of 'bank_card.dart';

class _Constants {
  static const cardDesignWidth = 200.0; // figma width / height
  static const cardDesignHeight = 300.0;
  static const chipDesignWidth = 27.0;
  static const chipDesignHeight = 33.0;
  static const chipAspect = chipDesignWidth / chipDesignHeight;
  static const cardToChipScale = chipDesignHeight / cardDesignHeight;
  static const chipProportionalTopInset = 44.0 / cardDesignHeight;
  static const mainBorderRadius = 10.0;
  static const shadowBlurRadius = 64.0;
  static const shadowOffset = Offset(16.0, 5.0);
  static const frozenOpacity = 0.5;
  static const frozenBlurSigma = 0.0;
  static const cardHolderCompanyWidth = 100.0;
  static const virtualCardBorderRadius = 20.0;
  static const virtualIconSize = Size(13, 10);
  static const cardNumberBottomPadding = 94.0;
  static const defaultPadding = PSPadding(
    top: 20,
    right: 24,
    left: 20,
    bottom: 20,
  );
  static const cardHolderPadding = PSPadding(
    left: 8,
    bottom: 54,
  );
  static const virtualCardPadding = PSPadding(
    top: 20,
    right: 20,
    height: 30,
    width: 76,
  );
  static const virtualCardRowPadding = PSPadding(
    left: 9,
    right: 7,
    top: 3,
    bottom: 3,
  );
  static const cardChipIconUri = 'widget_library:assets/images/card_chip.svg';
  static const wioIconUri = 'widget_library:assets/images/wio.svg';
  static const visaIconUri = 'widget_library:assets/images/visa.svg';
  static const frozenLockUri = 'widget_library:assets/images/ic_big_lock.svg';
  static const virtualCardIconUri = 'widget_library:assets/images/ic_cloud.svg';
}

class _Colors {
  static const cardShadow = Color(0xCC546186);
  static const frozenTransparent = Color(0xCC546186);
}

class _CardNumber extends StatelessWidget {
  final String cardNumber;
  final bool isVirtual;

  const _CardNumber({
    Key? key,
    required this.cardNumber,
    required this.isVirtual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _Constants.defaultPadding.left,
      bottom: _Constants.cardNumberBottomPadding,
      child: PSText(
        key: Key('BankCard_cardNumber_PSText'),
        text: isVirtual
            ? TextUIDataModel(
                cardNumber,
                styleVariant: PSTextStyleVariant.subtitle2,
              )
            : TextUIDataModel(
                cardNumber,
                styleVariant: PSTextStyleVariant.headline3,
              ),
      ),
    );
  }
}

class _CardHolder extends StatelessWidget {
  final String cardHolder;
  final bool isCreateMode;
  final Function(String value)? onChanged;
  //final Function(bool)? onFocusChanged;
  final Color? cursorColor;
  final String? hintText;
  final bool isVirtual;
  final int? maxLength;
  final FocusNode? focusNode;

  const _CardHolder({
    Key? key,
    required this.cardHolder,
    this.isCreateMode = false,
    this.onChanged,
    // this.onFocusChanged,
    this.cursorColor,
    this.hintText,
    this.maxLength,
    required this.isVirtual,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: isCreateMode
          ? _Constants.cardHolderPadding.left
          : _Constants.defaultPadding.left,
      bottom: isCreateMode
          ? _Constants.cardHolderPadding.bottom
          : _Constants.cardHolderPadding.bottom +
              _Constants.defaultPadding.bottom,
      child: isCreateMode
          ? SizedBox(
              key: Key('BankCard_cardHolder_SizedBox'),
              width: (MediaQuery.of(context).size.width -
                      _Constants.defaultPadding.right * 2) /
                  2,
              child: PSTextField(
                key: Key('BankCard_cardHolder_PSTextField'),
                attributes: PSTextFieldAttributes(
                  focusNode: focusNode,
                  autoFocus: false,
                  autocorrect: false,
                  backgroundColor: Colors.transparent,
                  enableSuggestions: false,
                  onChanged: onChanged,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  cursorColor: cursorColor,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  hint: hintText,
                  maxLength: maxLength,
                ),
              ),
            )
          : SizedBox(
              key: Key('BankCard_cardHolder_SizedBoxPSText'),
              width: (MediaQuery.of(context).size.width -
                      _Constants.defaultPadding.right * 2) /
                  2,
              child: PSText(
                key: Key('BankCard_cardHolder_PSText'),
                text: isVirtual
                    ? TextUIDataModel(
                        cardHolder,
                        styleVariant: PSTextStyleVariant.subtitle2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : TextUIDataModel(
                        cardHolder,
                        styleVariant: PSTextStyleVariant.headline3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
    );
  }
}

class _CardHolderCompany extends StatelessWidget {
  final String? cardHolderCompanyName;

  const _CardHolderCompany({
    Key? key,
    this.cardHolderCompanyName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cardHolderCompanyName.isNotEmptyOrNull) {
      return Positioned(
        width: _Constants.cardHolderCompanyWidth,
        left: _Constants.defaultPadding.left,
        bottom: _Constants.defaultPadding.bottom,
        child: PSText(
          key: Key('BankCard_cardHolderCompany_PSText'),
          text: TextUIDataModel(
            cardHolderCompanyName!,
            styleVariant: PSTextStyleVariant.headline5,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    return Container();
  }
}

class _CardProviderLogo extends StatelessWidget {
  final String? providerLogoUri;
  final Color? providerLogoColor;

  const _CardProviderLogo({
    Key? key,
    this.providerLogoUri,
    this.providerLogoColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (providerLogoUri.isNotEmptyOrNull) {
      return Positioned(
        key: Key('BankCard_cardProviderLogo_Positioned'),
        right: _Constants.defaultPadding.right,
        bottom: _Constants.defaultPadding.bottom,
        /* child: getSvg(
          providerLogoUri ?? _Constants.visaIconUri,
          color: providerLogoColor ?? Colors.black,
        ), */
        child: PSImage(
          PSImageModel(
            iconPath: providerLogoUri ?? _Constants.visaIconUri,
            color: providerLogoColor ?? Colors.black,
          ),
        ),
      );
    }
    return Container();
  }
}

class _BrandLogo extends StatelessWidget {
  final String? brandLogoUri;
  final Color? backgroundColor;
  final bool isVirtual;

  const _BrandLogo({
    Key? key,
    this.brandLogoUri,
    this.backgroundColor,
    required this.isVirtual,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (brandLogoUri.isNotEmptyOrNull) {
      return _LinearGradientMask(
        gradientTop: isVirtual ? backgroundColor : Colors.white,
        gradientBottom: isVirtual ? Colors.white : backgroundColor,
        /* child: getSvg(
          _Constants.wioIconUri,
          color: isVirtual ? backgroundColor : Colors.white70,
        ), */
        child: PSImage(
          PSImageModel(
            iconPath: _Constants.wioIconUri,
            color: isVirtual ? backgroundColor : Colors.white70,
          ),
        ),
      );
    }
    return Container();
  }
}

class _GradientOverlayBackground extends StatelessWidget {
  final Color? backgroundColor;

  const _GradientOverlayBackground({
    Key? key,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('BankCard_gradientOverlayBackground_Container'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(_Constants.virtualCardBorderRadius),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            // backgroundColor,
          ],
        ),
      ),
    );
  }
}

class _LinearGradientMask extends StatelessWidget {
  _LinearGradientMask({
    required this.child,
    this.gradientTop,
    this.gradientBottom,
  });

  final Widget child;
  final Color? gradientTop;
  final Color? gradientBottom;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      key: Key('BankCard_linearGradientMask_ShaderMask'),
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.40, 0.65],
          colors: [
            gradientTop ?? Colors.black,
            gradientBottom ?? Colors.yellow,
          ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}

class _VirtualCardLogo extends StatelessWidget {
  // final Color? backgroundColor;

  const _VirtualCardLogo();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('BankCard_virtualCardLogo_Container'),
      decoration: BoxDecoration(
        color: Colors.white70.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(_Constants.virtualCardBorderRadius),
        ),
      ),
      child: Padding(
        key: Key('BankCard_virtualCardLogo_Padding'),
        padding: EdgeInsets.only(
          left: _Constants.virtualCardRowPadding.left,
          right: _Constants.virtualCardRowPadding.right,
          top: _Constants.virtualCardRowPadding.top,
          bottom: _Constants.virtualCardRowPadding.bottom,
        ),
        child: Row(
          key: Key('BankCard_virtualCardLogo_Row'),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /* getSvg(
              _Constants.virtualCardIconUri,
              width: _Constants.virtualIconSize.width,
              height: _Constants.virtualIconSize.height,
            ), */
            PSImage(
              PSImageModel(
                iconPath: _Constants.virtualCardIconUri,
                width: _Constants.virtualIconSize.width,
                height: _Constants.virtualIconSize.height,
              ),
            ),
            PSText(
              key: Key('BankCard_virtualCardLogo_PSText'),
              text: TextUIDataModel('Virtual'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: Key('BankCard_chipLayer_LayoutBuilder'),
      builder: (context, constraints) {
        return Padding(
          key: Key('BankCard_chipLayer_Padding'),
          padding: EdgeInsets.only(
            top: constraints.maxHeight * _Constants.chipProportionalTopInset,
          ),
          child: Align(
            key: Key('BankCard_chipLayer_Align'),
            alignment: Alignment.topCenter,
            child: Container(
              key: Key('BankCard_chipLayer_Container'),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: SizedBox(
                key: Key('BankCard_chipLayer_SizedBox'),
                width: constraints.maxWidth * _Constants.cardToChipScale,
                child: AspectRatio(
                  key: Key('BankCard_chipLayer_AspectRatio'),
                  aspectRatio: _Constants.chipAspect,
                  //child: getSvg(_Constants.cardChipIconUri),
                  child: PSImage(
                    PSImageModel(
                      iconPath: _Constants.cardChipIconUri,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BackgroundLayer extends StatelessWidget {
  final bool isVirtual;
  final Color? backgroundColor;
  final String? brandLogoUri;
  final bool hideOverlay;
  final bool shadowEnabled;

  const _BackgroundLayer({
    Key? key,
    required this.isVirtual,
    this.backgroundColor,
    this.brandLogoUri,
    required this.hideOverlay,
    this.shadowEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('BankCard_backgroundLayer_Container'),
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          if (shadowEnabled)
            BoxShadow(
              offset: _Constants.shadowOffset,
              color: isVirtual
                  ? _Colors.cardShadow.withOpacity(0.4)
                  : _Colors.cardShadow,
              blurRadius: _Constants.shadowBlurRadius,
            ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(_Constants.mainBorderRadius),
        ),
      ),
      child: Stack(
        key: Key('BankCard_backgroundLayer_Stack'),
        fit: StackFit.expand,
        children: [
          if (isVirtual)
            Positioned(
              key: Key('BankCard_backgroundLayer_Positioned'),
              top: _Constants.virtualCardPadding.top,
              right: _Constants.virtualCardPadding.right,
              height: _Constants.virtualCardPadding.height,
              width: _Constants.virtualCardPadding.width,
              child: _VirtualCardLogo(
                  // backgroundColor: backgroundColor,
                  ),
            ),
          if (brandLogoUri.isNotEmptyOrNull)
            _BrandLogo(
              key: Key('BankCard_backgroundLayer_BrandLogo'),
              brandLogoUri: brandLogoUri,
              backgroundColor: backgroundColor,
              isVirtual: isVirtual,
            ),
          if (!hideOverlay)
            _GradientOverlayBackground(backgroundColor: backgroundColor),
        ],
      ),
    );
  }
}

class _FrozenLayer extends StatelessWidget {
  const _FrozenLayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('BankCard_FrozenLayer_Container'),
      color: _Colors.frozenTransparent.withOpacity(
        _Constants.frozenOpacity,
      ),
      child: Center(
        key: Key('BankCard_FrozenLayer_Center'),
        /* child: getSvg(
          _Constants.frozenLockUri,
        ), */
        child: PSImage(
          PSImageModel(
            iconPath: _Constants.frozenLockUri,
          ),
        ),
      ),
    );
  }
}
