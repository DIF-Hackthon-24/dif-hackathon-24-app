import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieBuilderAttributes {
  final String animationJsonPath;
  final bool? animationDisable;
  final bool? shouldRepeat;
  final double? height;
  final double? width;

  LottieBuilderAttributes({
    required this.animationJsonPath,
    this.animationDisable,
    this.shouldRepeat,
    this.height,
    this.width,
  });
}

class LottieBuilder extends StatefulWidget {
  final LottieBuilderAttributes attributes;
  const LottieBuilder({Key? key, required this.attributes}) : super(key: key);

  @override
  State<LottieBuilder> createState() => _LottieBuilderState();
}

class _LottieBuilderState extends State<LottieBuilder> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.attributes.height,
      width: widget.attributes.width,
      child: Lottie.asset(
        widget.attributes.animationJsonPath,
        animate: widget.attributes.animationDisable ?? true,
        repeat: widget.attributes.shouldRepeat ?? true,
        controller: _controller,
        onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
      ),
    );
  }
}
