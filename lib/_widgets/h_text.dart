import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class HText extends StatelessWidget {
  const HText({
    super.key,
    required this.title,
    required this.value,
    this.color,
  });

  final String title;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.bodyLarge,
        ),
        const Gap(Insets.lg),
        Flexible(
          child: Text(
            value,
            style: context.textTheme.bodyLarge!.copyWith(
              color: color ?? context.colorTheme.surfaceBright.withOpacity(.7),
            ),
            textAlign: TextAlign.end,
          ).copyable(),
        ),
      ],
    );
  }
}
