import 'package:flutter/material.dart';

class CarouselContent extends StatelessWidget {
  final String text;
  final Widget? image;
  final Color color;
  final EdgeInsets? globalPadding;
  final Color? backgroundColor;

  const CarouselContent({
    Key? key,
    this.text = '',
    this.image,
    required this.color,
    this.globalPadding,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final theme = PSTheme.of(context).theme;
    return Container(
      key: Key('CarouselContent_Container'),
      color: backgroundColor ?? Theme.of(context).colorScheme.background,
      child: Column(
        key: Key('CarouselContent_Column'),
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .12),
          Container(
            key: Key('CarouselContent_ChildrenContainer'),
            margin: globalPadding ?? EdgeInsets.all(8.0),
            child: Text(
              text,
              key: Key('CarouselContent_Text'),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(color: color),
            ),
          ),
          Expanded(child: image ?? Container()),
        ],
      ),
    );
  }
}
