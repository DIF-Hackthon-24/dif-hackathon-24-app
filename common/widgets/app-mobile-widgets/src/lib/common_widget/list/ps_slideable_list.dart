import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:widget_library/common_widget/list/ps_slidable_list_model.dart';

/// A wrapper for the [Slidable] widget.
/// Note that v1.0 of Slidable is in development and offers more customization
/// if required.
class PSSlidableList extends StatelessWidget {
  final Widget child;
  final List<PSSlidableListActionAttribute>? primaryActions;
  final List<PSSlidableListActionAttribute>? secondaryActions;
  final SlidableController? slidableController;

  PSSlidableList({
    Key? key,
    required this.child,
    this.primaryActions,
    this.secondaryActions,
    this.slidableController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: child,
    );
  }
}
