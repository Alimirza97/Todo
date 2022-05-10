import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLottieWidget extends StatelessWidget {
  final String fileName;
  final Animation<double>? controller;
  final bool? animate;
  final FrameRate? frameRate;
  final bool? repeat;
  final bool? reverse;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment? alignment;
  final String? package;
  final bool? addRepaintBoundary;
  final void Function(LottieComposition)? onLoaded;
  const CustomLottieWidget({
    Key? key,
    required this.fileName,
    this.controller,
    this.animate,
    this.frameRate,
    this.repeat,
    this.reverse,
    this.width,
    this.height,
    this.fit,
    this.alignment,
    this.package,
    this.addRepaintBoundary,
    this.onLoaded
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/lottie/$fileName",
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      onLoaded: onLoaded,
    );
  }
}
