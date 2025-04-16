import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    this.onPressed,
    required this.child,
    this.margin,
    this.padding,
    this.iconColor,
  });
  SquareButton.backButton({
    super.key,
    this.onPressed,
    this.padding,
    this.iconColor,
    IconData? iconData,
  })  : child = Icon(iconData ?? Icons.arrow_back_ios_new_rounded),
        margin = const EdgeInsets.all(6).copyWith(left: 20);

  final Function()? onPressed;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.square(35),
          backgroundColor: context.colorTheme.surface,
          foregroundColor: iconColor ?? context.colorTheme.onSurface,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: padding ?? const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          textStyle: context.textTheme.bodyLarge,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
