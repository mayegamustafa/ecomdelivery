import 'dart:ui';

import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/redeem_points/view/local/redeem_cart.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class NotActive extends ConsumerWidget {
  const NotActive({
    super.key,
    required this.rewardPoint,
  });
  final RewardPoint rewardPoint;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeLocal = ref.watch(localHomeCtrlProvider);
    final myPoint = homeLocal?.deliveryMan.point;
    return Padding(
      padding: Insets.padH.copyWith(top: Insets.med),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: context.colorTheme.primary,
                        borderRadius: Corners.medBorder,
                      ),
                      child: Column(
                        children: [
                          const Gap(Insets.med),
                          Text(
                            TR.of(context).myPoint,
                            style: TextStyle(
                              color: context.colorTheme.onPrimary,
                            ),
                          ),
                          const Gap(Insets.sm),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.icon.coins.svg(),
                              const Gap(Insets.med),
                              Text(
                                TR.of(context).points,
                                style:
                                    context.textTheme.headlineSmall!.copyWith(
                                  color: context.colorTheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
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
                ClipRRect(
                  borderRadius: Corners.medBorder,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                    child: Container(
                      color: Colors.black.withOpacity(.05),
                      child: Padding(
                        padding: Insets.padAllContainer,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Assets.icon.lockReward.svg(),
                            const Gap(Insets.lg),
                            Text(
                              TR
                                  .of(context)
                                  .yourNeedToMorePointsToUnlockedThisRewardLevel,
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyLarge!.copyWith(
                                color: context.colorTheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(Insets.lg),
          RedeemCollect(
            rewardPoint: rewardPoint,
            myPoint: myPoint ?? 0,
          )
        ],
      ),
    );
  }
}
