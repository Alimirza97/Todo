import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global/custom_thema_data_model.dart';

class _ElevatedButtonWidget extends StatelessWidget {
  _ElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    this.child,
    this.primary,
    this.onPrimary,
    this.onSurface,
    this.shadowColor,
    this.borderColor = Colors.black,
    this.borderWidth = 1,
    this.elevation,
    this.textFontSize,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.border = false,
    this.borderRadius,
  }) : super(key: key);

  final void Function() onPressed;
  final Widget? child;
  final Color? primary;
  final Color? onPrimary;
  final Color? onSurface;
  final Color? shadowColor;
  final Color borderColor;
  final double borderWidth;
  final double? elevation;
  final double? textFontSize;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool border;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: primary,
          onPrimary: onPrimary,
          onSurface: onSurface,
          shadowColor: shadowColor,
          elevation: elevation,
          textStyle:
              TextStyle(fontSize: textFontSize, fontStyle: FontStyle.italic),
          alignment: Alignment.center,
          side: border
              ? BorderSide(
                  width: borderWidth,
                  color: borderColor,
                  style: BorderStyle.solid,
                )
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(4),
          ),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class MyElevatedButton extends StatelessWidget {
  MyElevatedButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.primary,
    this.onPrimary,
    this.onSurface,
    this.shadowColor,
    this.borderColor,
    this.borderWidth,
    this.elevation,
    this.textFontSize,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.border = true,
    this.borderRadius,
  }) : super(key: key);
  final void Function() onPressed;
  final Widget? child;
  final Color? primary;
  final Color? onPrimary;
  final Color? onSurface;
  final Color? shadowColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? elevation;
  final double? textFontSize;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final bool border;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return _ElevatedButtonWidget(
      child: child,
      margin: margin ?? EdgeInsets.all(10),
      padding: padding,
      width: width,
      height: height,
      elevation: elevation ?? 10.0,
      primary: primary,
      onPrimary: onPrimary == null
          ? context.watch<CustomThemaData>().getIsDark
              ? Color(0xFF0CECDD)
              : Colors.white
          : onPrimary,
      onSurface: onSurface,
      shadowColor: shadowColor == null
          ? context.watch<CustomThemaData>().getIsDark
              ? Color(0xFF0CECDD)
              : Colors.deepPurpleAccent
          : shadowColor,
      borderColor: borderColor == null
          ? context.watch<CustomThemaData>().getIsDark
              ? Color(0xFF0CECDD)
              : Colors.deepPurpleAccent
          : borderColor!,
      borderWidth: borderWidth ?? 2,
      border: border,
      textFontSize: textFontSize,
      borderRadius: borderRadius == null ? BorderRadius.circular(60) : borderRadius,
      onPressed: onPressed,
    );
  }
}
