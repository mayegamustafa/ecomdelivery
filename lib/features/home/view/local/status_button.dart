import 'package:delivery_boy/_core/_core.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.title,
    required this.assetImg,
    required this.count,
    this.onTap,
  });
  final String title;
  final String assetImg;
  final String count;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(width: 0, color: context.colorTheme.errorContainer),
            borderRadius: Corners.smBorder,
            color: context.colorTheme.errorContainer.withOpacity(0.05),
          ),
          child: Padding(
            padding: Insets.padAll,
            child: Column(
              children: [
                Image.asset(
                  assetImg,
                  height: 50,
                ),
                const Gap(Insets.lg),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorTheme.errorContainer,
                  ),
                ),
                const Gap(Insets.med),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:
                          context.colorTheme.errorContainer.withOpacity(0.1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    child: Text(
                      count,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorTheme.errorContainer,
                      ),
                    ),
                  ),
                ),
                const Gap(Insets.med),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
