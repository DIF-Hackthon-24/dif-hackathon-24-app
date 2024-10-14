import 'package:flutter/material.dart';

class _Constants {
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const double zero = 0;
  static const double eight = 8;
  static const double fifteen = 15;
}

class HorizontalCarouselTabTile extends StatelessWidget {
  final Widget? leading;
  final Widget trailing;
  final bool isSelected;
  final double borderWidth;
  final double borderRadius;
  final double shadowRadius;
  final double offsetDx;
  final double offsetDy;
  final double paddingOfContent;
  final Color borderColor;
  final Color selectionColor;
  final Color deSelectionColor;
  final Color shadowColor;

  const HorizontalCarouselTabTile({
    Key? key,
    required this.isSelected,
    this.leading,
    required this.trailing,
    this.borderColor = _Constants.white,
    this.borderWidth = _Constants.zero,
    this.selectionColor = _Constants.black,
    this.deSelectionColor = _Constants.white,
    this.shadowColor = _Constants.white,
    this.shadowRadius = _Constants.zero,
    this.offsetDx = _Constants.zero,
    this.offsetDy = _Constants.zero,
    this.paddingOfContent = _Constants.eight,
    this.borderRadius = _Constants.zero,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        color: isSelected ? selectionColor : deSelectionColor,
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            blurRadius: shadowRadius,
            offset: Offset(offsetDx, offsetDy),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(_Constants.eight),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// generic widgets can be provided
            SizedBox(
                width: _Constants.fifteen,
              ),
            if (leading != null) leading!,
            if (leading != null)
              SizedBox(
                width: paddingOfContent,
              ),

            /// these are widgets so this is generic
            trailing,
            SizedBox(
                width: _Constants.fifteen,
              ),
          ],
        ),
      ),
    );
  }
}
