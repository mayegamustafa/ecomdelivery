import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class RewordDetails extends ConsumerWidget {
  const RewordDetails({
    super.key,
    required this.rewardData,
  });
  final RewardLogs rewardData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: context.height / 3,
      child: Padding(
        padding: Insets.padH,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Gap(Insets.lg),
            HText(
              title: TR.of(context).time,
              value: rewardData.humanReadableTime,
            ),
            HText(
              title: TR.of(context).point,
              value: rewardData.point.toString(),
            ),
            HText(
              title: TR.of(context).postPoint,
              value: rewardData.postPoint.toString(),
            ),
            HText(
              title: TR.of(context).details,
              value: rewardData.details,
            ),
            const Gap(Insets.offset),
          ],
        ),
      ),
    );
  }
}
