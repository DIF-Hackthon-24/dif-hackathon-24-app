import 'package:flutter/cupertino.dart';

class PSSafeScrollContainer extends SingleChildScrollView {
  PSSafeScrollContainer({
    required Widget child,
    required BoxConstraints constraint,
  }) : super(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: child,
            ),
          ),
        );
}
