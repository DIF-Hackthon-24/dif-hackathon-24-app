import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';

import 'list_row_widget_model.dart';

class _Constants {
  static const Duration animationDuration = Duration(milliseconds: 250);
  static const double listHeight = 60;
  static const double padding = 8;
  static const thirtyPixels = 30.0;
  static const twentyEightPixels = 28.0;
  static const sixtyFour = 54.0;
  static const twentyPixels = 20.0;
  static const tenPixels = 10.0;
  static const zeroPixels = 0.0;
  static const twentyTwoPixels = 22.0;
  static const fourEighty = 480;
  static const twentyFivePixels = 25.0;
  static const zeroPointFive = 0.5;
  static const scaleFactor = 812;
  static const smallDeviceHeight = 700;
  static const String expand='expand';
  static const String collapse='collapse';
}

class ListRowWidget extends StatefulWidget {
  final ListRowAttribute attribute;

  const ListRowWidget({Key? key, required this.attribute}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ListRowState();
}

class _ListRowState extends State<ListRowWidget> with TickerProviderStateMixin {
  bool _isExpanded = false;
  bool _isSubMenuExpanded = false;
  AnimationController? animationController;
  AnimationController? animationControllerSubMenu;
 ScrollController? controller =ScrollController();
  bool get _hasDetails => widget.attribute.additionalDetailsRow != null;

  bool get _hasSubAdditionalDetails => widget.attribute.subAdditionalDetailsRow != null;
  GlobalKey glSubDetailKey = GlobalKey();
  var subDetailY = 0.0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: _Constants.animationDuration,
    );
    animationControllerSubMenu = AnimationController(
      vsync: this,
      duration: _Constants.animationDuration,
    );
  }

  @override
  void dispose() {
    animationController?.stop(canceled: true);
    animationControllerSubMenu?.stop(canceled: true);
    animationControllerSubMenu?.dispose();
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var lableForExpandedOrNotMainMenu=_Constants.expand;
    return GestureDetector(
      onTap: _hasDetails
          ? () {
              _isExpanded ? animationController!.reverse() : animationController!.forward();
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          : widget.attribute.dataModel.onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        GestureDetector(
          onTap: _hasDetails
              ? () {
                  _isExpanded ? animationController!.reverse() : animationController!.forward();
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                }
              : widget.attribute.dataModel.onTap,
          child: ListTile(
            minLeadingWidth: _Constants.twentyTwoPixels,
            tileColor: widget.attribute.color,
            leading: PSImage(
              PSImageModel(
                iconPath: widget.attribute.dataModel.imageUrl ?? '',
                color: widget.attribute.imageColor,
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: _Constants.twentyTwoPixels,
              right: _Constants.twentyTwoPixels,
            ),
            trailing: _hasDetails
                ? IconButton(
                    icon: RotationTransition(
                      turns: Tween(
                        begin: _Constants.zeroPixels,
                        end: _Constants.zeroPointFive,
                      ).animate(animationController!),
                      child:  Semantics(
                        label: lableForExpandedOrNotMainMenu,
                        focusable: true,
                        child: PSImage(
                          PSImageModel(
                            iconPath: widget.attribute.backgroundImage,
                            color: Colors.black,
                            height: _Constants.twentyPixels,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      _isExpanded ? animationController!.reverse() : animationController!.forward();
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  )
                : null,
            title: PSText(
              text: widget.attribute.dataModel.title.copyWith(
                styleVariant: widget.attribute.dataModel.title.styleVariant ?? PSTextStyleVariant.bodyText2,
              ),
            ),
          ),
        ),
        if (_hasDetails) _buildDetails(),
        ],
      ),
    );
  }

  var lableForExpandedOrNot=_Constants.expand;
  // ignore: long-method
  Widget _buildDetails() {
    final totalHeight = MediaQuery.of(context).size.height;
    final scaleheightFactor = totalHeight / _Constants.scaleFactor;

    return AnimatedContainer(
      duration: _Constants.animationDuration,
      height: buildHeight() * scaleheightFactor -
          (_isSmallDeviceHeightCheck(totalHeight) &&
                  _isSubMenuExpanded && _isExpanded ? 40 : 0),
      child: InkWell(
        onTap: _hasSubAdditionalDetails
            ? () {
                _isSubMenuExpanded ? animationControllerSubMenu!.reverse() : animationControllerSubMenu!.forward();
                setState(() {
                  _isSubMenuExpanded = !_isSubMenuExpanded;
                });
              }
            : widget.attribute.dataModel.onTap,
       child: ListView.separated(
        controller: controller,
        shrinkWrap: true,
          padding: EdgeInsets.only(
            left: widget.attribute.isRTL! ? _Constants.zeroPixels : _Constants.sixtyFour,
            right: widget.attribute.isRTL! ? _Constants.sixtyFour : _Constants.zeroPixels,
          ),
          itemCount: widget.attribute.additionalDetailsRow!.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: _Constants.padding),
            child: Column(
              key: ValueKey('PayeeListRowWidget_Details_$index'),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: GestureDetector(
                    onTap: () {
                      _isSubMenuExpanded
                          ? animationControllerSubMenu!.reverse()
                          : animationControllerSubMenu!.forward();
                      setState(() {
                        _setSubDetailYPosition();
                        _isSubMenuExpanded = !_isSubMenuExpanded;
                      });
                    },
                    child: PSText(
                      text: widget.attribute.additionalDetailsRow![index].title,
                    ),
                  ),
                  onTap: () {
                    if (widget.attribute.additionalDetailsRow![index].onTap != null) {
                      widget.attribute.additionalDetailsRow![index].onTap!();
                    }
                  },
                  trailing: _hasSubAdditionalDetails
                      ? IconButton(
                          icon: RotationTransition(
                            turns: Tween(
                              begin: _Constants.zeroPixels,
                              end: _Constants.zeroPointFive,
                            ).animate(animationControllerSubMenu!),
                            child: Semantics(
                              label: lableForExpandedOrNot,
                              focusable: true,
                              child: PSImage(
                                PSImageModel(
                                  iconPath: widget.attribute.backgroundImage,
                                  color: Colors.black,
                                  height: _Constants.twentyPixels,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            _isSubMenuExpanded
                                ? animationControllerSubMenu!.reverse()
                                : animationControllerSubMenu!.forward();
                            setState(() {
                              _setSubDetailYPosition();
                              _isSubMenuExpanded = !_isSubMenuExpanded;
                              _isSubMenuExpanded?lableForExpandedOrNot=_Constants.expand:lableForExpandedOrNot=_Constants.collapse;
                            });
                          },
                        )
                      : null,
                ),
                if (_hasSubAdditionalDetails) _buildSubAdditionalDetails(),
              ],
            ),
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: _Constants.thirtyPixels * scaleheightFactor,
          ),
        ),
      ),
    );
  }

  void _setSubDetailYPosition() {
    RenderBox box = glSubDetailKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero);
    subDetailY = position.dy;
    }

  bool _isSmallDeviceHeightCheck(double totalHeight) => totalHeight < _Constants.smallDeviceHeight && subDetailY != 0.0;


  Widget _buildSubAdditionalDetails() {
    // final totalHeight = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      key: glSubDetailKey,
      padding: EdgeInsets.only(bottom : _Constants.twentyPixels),
      duration: _Constants.animationDuration,
      child: GestureDetector(
        onTap: () {
          _hasSubAdditionalDetails
              ? () {
                  _isSubMenuExpanded ? animationControllerSubMenu!.reverse() : animationControllerSubMenu!.forward();
                  setState(() {
                    _isSubMenuExpanded = !_isSubMenuExpanded;
                    _isSubMenuExpanded?lableForExpandedOrNot=_Constants.expand:lableForExpandedOrNot=_Constants.collapse;
                  });
                }
              : widget.attribute.dataModel.onTap;
        },
            child: ListView.separated(
                  controller: controller,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    top: _Constants.tenPixels,
                    left: widget.attribute.isRTL! ? _Constants.zeroPixels : _Constants.twentyFivePixels,
                    right: widget.attribute.isRTL! ? _Constants.twentyFivePixels : _Constants.zeroPixels,
                  ),
                  itemCount: widget.attribute.subAdditionalDetailsRow!.length,
                  itemBuilder: (context, index) =>  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: _Constants.padding),
                    child: InkWell(
                      onTap: () {
                        if (widget.attribute.subAdditionalDetailsRow![index].onTap != null) {
                          widget.attribute.subAdditionalDetailsRow![index].onTap!();
                        }
                      },
                      child: PSText(
                        text: widget.attribute.subAdditionalDetailsRow![index].title,
                      ),
                    ),

                  ),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: _Constants.twentyEightPixels,
                  ),

              ),
          ),

    );
  }

  double buildHeight() {
    final isTablet = MediaQuery.of(context).size.width > _Constants.fourEighty;
    if (_isExpanded && !_isSubMenuExpanded) {
      return (widget.attribute.additionalDetailsRow!.length) * _Constants.listHeight;
    } else if (_isSubMenuExpanded && _isExpanded) {
       return isTablet ?  (widget.attribute.additionalDetailsRow!.length + (widget.attribute.subAdditionalDetailsRow!.length * 0.55) ) *
           _Constants.listHeight :
       min(MediaQuery.of(context).size.height * 0.5, (widget.attribute.additionalDetailsRow!.length + (widget.attribute.subAdditionalDetailsRow!.length * 0.82) ) *
          _Constants.listHeight,);
    } else {
      return _Constants.zeroPixels;
    }
  }
}
