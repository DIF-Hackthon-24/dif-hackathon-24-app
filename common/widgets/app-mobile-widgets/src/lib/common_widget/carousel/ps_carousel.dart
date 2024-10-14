import 'package:flutter/widgets.dart';


class _Constants {
  static const rightPadding = 16.0;
}

/// Callback when the current widget is swiped
typedef OnCurrentPageChangedCallback = void Function(int currentItem);

/// Callback when widget is dismissed
typedef OnPageDismissedCallback = void Function(int dismissedItem, DismissDirection direction);

/// Widget that animates scanning through a list of other widgets
class PSCarousel extends StatefulWidget {
  /// ValueNotifier to interact with the PageController from outside.
  final ValueNotifier<PageController>? controllerValueNotifier;

  /// Called when current item is changed.
  final OnCurrentPageChangedCallback currentItemChangedCallback;

  /// If true, widgets in the list can be
  /// [dismissed](https://docs.flutter.io/flutter/widgets/Dismissible-class.html).
  /// If this is true, dismissedCallback must be specified to clean up any
  /// state that your itemBuilder, otherwise, you will likely get errors thrown about.
  final bool dismissibleItems;

  /// Called when an item has been dismissed.
  final OnPageDismissedCallback? dismissedCallback;

  /// Called to build a widget that will be animated to loop through.
  final IndexedWidgetBuilder itemBuilder;

  /// The number of items in this PSCarousel list. If specified, the PSCarousel
  /// view is a finite list that scrolls only to the last list. If this value is
  /// *not* specified, then PSCarousel is an infinite list that rebuilds the
  /// cards one the user scrolls past the last one.
  final int itemCount;

  /// The height in pixels of the largest possible size an animated item will be.
  final int height;

  /// The index of the first item to show. If specified, the PSCarousel will
  /// initially display the item at this index.
  final int startIndex;

  /// The fraction of the
  /// [viewport](https://docs.flutter.io/flutter/widgets/Viewport-class.html)
  /// that the animated items should cover.
  final double viewportFraction;

  /// The width in pixels of the largest possible size an animated item will be.
  final int width;

  const PSCarousel({
    Key? key,
    required this.itemBuilder,
    this.dismissibleItems = true,
    this.dismissedCallback,
    this.viewportFraction = .85,
    this.height = 320,
    this.width = 340,
    required this.itemCount,
    this.startIndex = 0,
    required this.currentItemChangedCallback,
    this.controllerValueNotifier,
  }) : super(key: key);

  @override
  _PSCarouselState createState() => _PSCarouselState();
}

class _PSCarouselState extends State<PSCarousel> {
  late PageController controller;
  late int currentPage;
  bool _pageHasChanged = false;

  @override
  void initState() {
    super.initState();
    currentPage = widget.startIndex;
    controller = PageController(
      viewportFraction: widget.viewportFraction,
      initialPage: currentPage,
    );
    if (widget.controllerValueNotifier != null) {
      widget.controllerValueNotifier?.value = controller;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    widget.controllerValueNotifier?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: (value) {
        setState(() {
          _pageHasChanged = true;
          currentPage = value;
          widget.currentItemChangedCallback(value);
        });
      },
      controller: controller,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) => builder(index),
    );
  }

  Widget builder(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, Widget? child) {
        final result = _pageHasChanged ? controller.page! : currentPage * 1.0;
        final value = (1 - ((result - index).abs() * .5)).clamp(0.0, 1.0);

        var actualWidget = Center(
          child: Padding(
            padding: const EdgeInsets.only(right: _Constants.rightPadding),
            child: SizedBox(
              height: Curves.easeOut.transform(value) * widget.height,
              width: Curves.easeOut.transform(value) * widget.width,
              child: child,
            ),
          ),
        );
        if (!widget.dismissibleItems) return actualWidget;

        return Dismissible(
          key: ObjectKey(child),
          direction: DismissDirection.vertical,
          onDismissed: (direction) {
            if (widget.dismissedCallback != null) {
              setState(
                () {
                  widget.dismissedCallback!(index, direction);
                  controller.animateToPage(currentPage, duration: Duration(seconds: 2), curve: Curves.easeOut);
                },
              );
            }
          },
          child: actualWidget,
        );
      },
      child: widget.itemBuilder(context, index),
    );
  }
}
