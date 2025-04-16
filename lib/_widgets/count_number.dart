import 'package:delivery_boy/_core/_core.dart';
import 'package:flutter/material.dart';

class CountNumber extends StatelessWidget {
  const CountNumber({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
  });

  final String count;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor ??
            context.colorTheme.errorContainer.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 2,
        ),
        child: Text(
          count,
          style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor ?? context.colorTheme.errorContainer,
          ),
        ),
      ),
    );
  }
}
