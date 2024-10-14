import 'package:flutter/material.dart';

class SquarePanelDetailBackgroundWidget extends StatelessWidget {
  final double? size;
  final Widget child;
  final Color? color;

  const SquarePanelDetailBackgroundWidget({Key? key, this.size, required this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = size ?? MediaQuery.of(context).size.width * .86;
    return Container(
      key: Key('SquarePanelDetailBackgroundWidget_Container'),
      width: _size,
      height: _size,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: color ?? Colors.grey),
      child: child,
    );
  }
}
