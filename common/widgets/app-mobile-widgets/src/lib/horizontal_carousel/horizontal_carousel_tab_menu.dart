import 'package:flutter/material.dart';

class _Constants {
  static const double tenPixels = 10;
  static const double minContentHeight = 50;
  static const double zero = 0;
  static const double one = 1;
  static const double five = 5;
  static const double eight = 8;
}

typedef IndexedSelectionWidgetBuilder = Widget Function(
  BuildContext context,
  int index,
  bool isSelected,
);

/// this is the parent custom with scroll and selection
class HorizontalCarouselTabMenu extends StatefulWidget {
  final double contentHeight;
  final double contentPadding;

  /// list can have any type of list so its generic
  final List dataList;
  final Function(int) onTapAction;
  final IndexedSelectionWidgetBuilder itemBuilder;
  final bool multiSelection;

  const HorizontalCarouselTabMenu({
    Key? key,
    required this.dataList,
    required this.onTapAction,
    required this.itemBuilder,
    this.contentHeight = _Constants.zero,
    this.contentPadding = _Constants.tenPixels,
    this.multiSelection = false,
  }) : super(key: key);

  @override
  State<HorizontalCarouselTabMenu> createState() => _HorizontalCarouselTabMenuState();
}

class _HorizontalCarouselTabMenuState extends State<HorizontalCarouselTabMenu> {
  int? selectedIndex;
  List<int> selectedIndexArray = [];

  void _handleSelection(int index) {
    setState(() {
      if (widget.multiSelection) {
        if (selectedIndexArray.isNotEmpty && selectedIndexArray.contains(index)) {
          selectedIndexArray.remove(index);
        } else {
          selectedIndexArray.add(index);
        }
      } else {
        selectedIndex = selectedIndex == index ? null : index;
      }
    });
  }

  bool _checkIndexIsSelected(int index) {
    var isSelected = false;
    if (widget.multiSelection && selectedIndexArray.isNotEmpty) {
      isSelected = selectedIndexArray.contains(index);
    } else {
      isSelected = selectedIndex == index;
    }
    return isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.contentHeight > _Constants.minContentHeight
          ? widget.contentHeight + _Constants.five
          : _Constants.minContentHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(),
        itemCount: widget.dataList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              /// selection logic is handled here
              _handleSelection(index);

              /// further handling can be handled in parent view
              widget.onTapAction(index);
            },
            child: Row(
              children: [
                if (index == _Constants.zero)
                  const SizedBox(
                    width: _Constants.eight,
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: _Constants.eight,
                    top: _Constants.five,
                  ),
                  child: widget.itemBuilder(
                    context,
                    index,
                    _checkIndexIsSelected(index),
                  ),

                  /// item builder can have any widget so it is generic
                ),
                if (index == widget.dataList.length - _Constants.one)
                  const SizedBox(
                    width: _Constants.eight,
                  ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: widget.contentPadding,
          );
        },
      ),
    );
  }
}
