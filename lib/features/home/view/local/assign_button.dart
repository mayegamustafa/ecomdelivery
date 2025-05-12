import 'package:delivery_boy/_core/_core.dart';
import 'package:delivery_boy/_widgets/count_number.dart';
import 'package:flutter/material.dart';

class AssignButton extends StatelessWidget {
  const AssignButton({
    super.key,
    required this.title,
    required this.count,
    this.onTap,
    required this.image,
  });
  final String title;
  final String count;
  final Function()? onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: context.colorTheme.primary,
                borderRadius: Corners.smBorder,
              ),
              child: Padding(
                padding: Insets.padAll,
                child: SizedBox(
                  width: context.width,
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: context.colorTheme.onPrimary,
                        ),
                      ),
                      CountNumber(
                        count: count,
                        backgroundColor:
                            context.colorTheme.onPrimary.withOpacity(0.2),
                        textColor: context.colorTheme.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                image,
                height: 40,
                color: context.colorTheme.onPrimary.withOpacity(0.3),
              ),
            )
          ],
        ),
      ),
    );
  }
}
