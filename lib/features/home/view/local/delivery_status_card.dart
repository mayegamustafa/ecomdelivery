import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class DeliveryStatusCard extends StatelessWidget {
  const DeliveryStatusCard({
    super.key,
    required this.status,
    required this.amount,
    required this.svg,
  });
  final String status;
  final String amount;
  final Widget svg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 105,
      decoration: BoxDecoration(
        borderRadius: Corners.lgBorder,
        color: context.colorTheme.surface,
      ),
      child: Padding(
        padding: Insets.padAllContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svg,
            const Gap(Insets.xl),
            Text(
              status,
              maxLines: 1,
              style: context.textTheme.bodyMedium,
            ),
            const Gap(Insets.med),
            Text(
              amount,
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
