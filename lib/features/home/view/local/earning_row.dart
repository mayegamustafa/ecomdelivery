import 'package:delivery_boy/_core/_core.dart';
import 'package:flutter/material.dart';

class EarningRow extends StatelessWidget {
  const EarningRow({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.smBorder,
        border: Border.all(
          color: context.colorTheme.onPrimary,
          width: 0,
        ),
      ),
      width: 90,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.colorTheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorTheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
