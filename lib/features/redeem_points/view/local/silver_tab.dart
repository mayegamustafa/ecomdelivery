import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:flutter/material.dart';
import '../../../../main.export.dart';
import 'local.dart';

class RedeemPointTab extends ConsumerWidget {
  const RedeemPointTab({
    super.key,
    required this.rewardPoint,
  });
  final RewardPoint rewardPoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeLocal = ref.watch(localHomeCtrlProvider);
    final need = rewardPoint.lessThanEq;
    final myPoint = homeLocal?.deliveryMan.point.toDouble() ?? 0;
    final nextLevel = (need - myPoint);

    return Padding(
      padding: Insets.padH.copyWith(top: Insets.med),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: context.colorTheme.primary,
                  borderRadius: Corners.medBorder,
                ),
                child: Padding(
                  padding: Insets.padAllContainer,
                  child: Column(
                    children: [
                      Text(
                        TR.of(context).yourPoints,
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colorTheme.onPrimary,
                        ),
                      ),
                      const Gap(Insets.med),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icon.coins.svg(),
                          const Gap(Insets.med),
                          Text(
                            '${homeLocal?.deliveryMan.point} ${TR.of(context).point}',
                            style: context.textTheme.headlineSmall!.copyWith(
                              color: context.colorTheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Gap(Insets.offset),
                      Text(
                        '${TR.of(context).collect} ${nextLevel.toInt()} ${TR.of(context).morePointsToGetNextLevel}',
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorTheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 10,
                child: Column(
                  children: [
                    CircleAvatar(
                      child: Assets.icon.star.svg(),
                    ),
                    const Gap(Insets.sm),
                    Text(
                      rewardPoint.name,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorTheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(Insets.lg),
          Text(
            TR.of(context).yourPointsReward,
            style: context.textTheme.titleLarge,
          ),
          const Gap(Insets.med),
          RedeemCollect(
            rewardPoint: rewardPoint,
            myPoint: myPoint.toInt(),
          ),
        ],
      ),
    );
  }
}
