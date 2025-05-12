import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

import 'local.dart';

class RedeemCollect extends StatelessWidget {
  const RedeemCollect({
    super.key,
    required this.rewardPoint,
    required this.myPoint,
  });
  final RewardPoint rewardPoint;
  final int myPoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: Corners.medBorder,
      ),
      child: Padding(
        padding: Insets.padAllContainer,
        child: Row(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor:
                  context.colorTheme.surfaceBright.withOpacity(.05),
              child: Assets.icon.star.svg(),
            ),
            const Gap(Insets.med),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rewardPoint.name,
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  '+${rewardPoint.amount.formate(calculateRate: true)}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorTheme.errorContainer,
                  ),
                ),
              ],
            ),
            const Spacer(),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: myPoint > rewardPoint.minAmount &&
                        myPoint < rewardPoint.lessThanEq
                    ? context.colorTheme.primary
                    : Colors.grey,
              ),
              onPressed: myPoint > rewardPoint.minAmount &&
                      myPoint < rewardPoint.lessThanEq
                  ? () => showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        enableDrag: true,
                        builder: (BuildContext context) {
                          return const RedeemButtomSheet();
                        },
                      )
                  : () {
                      Toaster.showInfo(
                          TR.of(context).youAreNotAbleToCollectPoints);
                    },
              child: Text(TR.of(context).get),
            ),
          ],
        ),
      ),
    );
  }
}
