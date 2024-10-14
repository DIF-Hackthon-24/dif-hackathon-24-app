import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/padding.dart';

EdgeInsets fromPSPadding(PSPadding padding) => EdgeInsets.only(
      left: padding.left,
      right: padding.right,
      top: padding.top,
      bottom: padding.bottom,
    );
