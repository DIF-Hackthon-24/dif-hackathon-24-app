import 'package:flutter/material.dart';

class CarouselPageSelector extends StatelessWidget {
  final TabController? controller;
  final Size? indicatorSize;
  final Color? selectedColorDark;
  final Color? selectedColorLight;
  final Color? backgroundColor;
  final BorderRadius borderRadius;

  const CarouselPageSelector({
    Key? key,
    this.controller,
    this.indicatorSize = const Size(8, 8),
    this.selectedColorDark,
    this.selectedColorLight,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor,
  }) : super(key: key);

  Widget _buildTabIndicator(
    int tabIndex,
    TabController tabController,
  ) {
    final selectedColor = getSelectedColor(tabController, tabIndex);
    final selectedColorTween = ColorTween(
      begin: backgroundColor ?? Colors.transparent,
      end: selectedColor,
    );
    final previousColorTween = ColorTween(begin: selectedColor, end: backgroundColor);
    Color? resultColor;
    if (tabController.indexIsChanging) {
      final t = 1.0 - _indexChangeProgress(tabController);
      if (tabController.index == tabIndex) {
        resultColor = selectedColorTween.lerp(t);
      } else if (tabController.previousIndex == tabIndex) {
        resultColor = previousColorTween.lerp(t);
      } else {
        resultColor = selectedColorTween.begin;
      }
    } else {
      final offset = tabController.offset;
      if (tabController.index == tabIndex) {
        resultColor = selectedColorTween.lerp(1.0 - offset.abs());
      } else if (tabController.index == tabIndex - 1 && offset > 0.0) {
        resultColor = selectedColorTween.lerp(offset);
      } else if (tabController.index == tabIndex + 1 && offset < 0.0) {
        resultColor = selectedColorTween.lerp(-offset);
      } else {
        resultColor = selectedColorTween.begin;
      }
    }

    final widget = Container(
      key: Key('CarouselPageSelector_buildTabIndicator_Container'),
      width: indicatorSize?.width ?? 8,
      height: indicatorSize?.height ?? 8,
      decoration: BoxDecoration(color: resultColor, borderRadius: borderRadius),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: widget,
    );
  }

  // ignore: code-metrics
  Color getSelectedColor(TabController tabController, int tabIndex) {
    var currentSelectedColor = (tabIndex % 2 == 0) ? selectedColorDark : selectedColorLight;
    return currentSelectedColor ?? Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    final tabController = (controller ?? DefaultTabController.of(context));
    final Animation<double> animation = CurvedAnimation(
      parent: tabController.animation!,
      curve: Curves.decelerate,
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Row(
          key: Key('CarouselPageSelector_getSelectedColorBuilderRow'),
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(tabController.length, (int tabIndex) {
            return _buildTabIndicator(tabIndex, tabController);
          }).toList(),
        );
      },
    );
  }

  double _indexChangeProgress(TabController controller) {
    final controllerValue = controller.animation?.value ?? 0;
    final previousIndex = controller.previousIndex.toDouble();
    final currentIndex = controller.index.toDouble();
    if (!controller.indexIsChanging) {
      return (currentIndex - controllerValue).abs().clamp(0.0, 1.0);
    }
    return (controllerValue - currentIndex).abs() / (currentIndex - previousIndex).abs();
  }
}
