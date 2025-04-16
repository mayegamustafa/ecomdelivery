import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class ShadowContainer extends ConsumerWidget {
  const ShadowContainer({
    super.key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.offset = const Offset(0, 5),
    this.padding,
    this.margin,
  });
  final Widget? child;
  final double? height;
  final double? width;
  final Color? color;
  final Offset offset;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
        color: color ?? context.colorTheme.surface,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: context.colorTheme.onSurface.withOpacity(.05),
            offset: offset,
          ),
        ],
      ),
      child: child,
    );
  }
}
