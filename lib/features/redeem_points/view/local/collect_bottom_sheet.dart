import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../../controller/redeem_points_ctrl.dart';

class RedeemButtomSheet extends HookConsumerWidget {
  const RedeemButtomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedBottomSheet(
      child: Column(
        children: [
          Text(
            TR.of(context).doYouWantToGetThisReward,
            style: context.textTheme.titleLarge,
          ),
          const Gap(Insets.offset),
          Assets.icon.reward.svg(),
          const Gap(Insets.offset),
          Text(
            TR.of(context).forUsePointClickYes,
            style: context.textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor:
                        context.colorTheme.surfaceBright.withOpacity(.1),
                  ),
                  onPressed: () => context.pop(),
                  child: Text(
                    TR.of(context).no,
                    style: TextStyle(
                      color: context.colorTheme.surfaceBright,
                    ),
                  ),
                ),
              ),
              const Gap(Insets.lg),
              SizedBox(
                width: 100,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: context.colorTheme.primary,
                  ),
                  onPressed: () {
                    ref.read(redeemPointsCtrlProvider.notifier).redeemPoint();
                    context.pop();
                  },
                  child: Text(TR.of(context).yes),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
