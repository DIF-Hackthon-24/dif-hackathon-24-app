import 'package:flutter/material.dart';

class PSBreadCrumbWidgetAttribute {
  final String label;
  final Color? backgroundColor;
  final Function()? onCrossTap;
  PSBreadCrumbWidgetAttribute({
    required this.label,
    this.backgroundColor,
    this.onCrossTap,
  });
}
