import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class LeadFilledButton extends StatelessWidget {
  const LeadFilledButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final Widget icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: context.colorTheme.onPrimary,
          ),
          child: Row(
            children: [
              const Gap(Insets.sm),
              CircleAvatar(
                backgroundColor: context.colorTheme.primary,
                child: icon,
              ),
              const Gap(Insets.med),
              Text(
                title,
                style: context.textTheme.titleLarge!.copyWith(
                  color: context.colorTheme.onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
