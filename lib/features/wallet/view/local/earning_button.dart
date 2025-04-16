import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class EarningButton extends StatelessWidget {
  const EarningButton({
    super.key,
    required this.title,
    required this.image,
    required this.count,
  });
  final String title;
  final String image;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width / 3.3,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0,
          color: context.colorTheme.primary,
        ),
        borderRadius: Corners.smBorder,
      ),
      child: Padding(
        padding: Insets.padAll,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 35,
            ),
            const Gap(Insets.med),
            Text(
              count,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
