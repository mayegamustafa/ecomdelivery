import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'local/local.dart';

class RedeemPointsView extends HookConsumerWidget {
  const RedeemPointsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingCtrl = ref.watch(appSettingsCtrlProvider);
    final homeLocal = ref.watch(localHomeCtrlProvider);
    double currentAmount = homeLocal!.deliveryMan.point.toDouble();

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).redeemPoints),
      ),
      body: settingCtrl.when(
        loading: Loader.list,
        error: (e, s) => ErrorView(e, s, invalidate: appSettingsCtrlProvider),
        data: (redeem) {
          final length = redeem.config.rewardAmountConfigurations.length;

          int initialIndex = 0;
          for (int i = 0;
              i < redeem.config.rewardAmountConfigurations.length;
              i++) {
            double minAmount =
                redeem.config.rewardAmountConfigurations[i].minAmount;
            double maxAmount =
                redeem.config.rewardAmountConfigurations[i].lessThanEq;

            bool isEnabled =
                currentAmount >= minAmount && currentAmount <= maxAmount;

            if (isEnabled) {
              initialIndex = i;
              break;
            }
          }

          final rewardTabs =
              redeem.config.rewardAmountConfigurations.map<Widget>((config) {
            return Tab(
              text: config.name,
            );
          }).toList();

          final rewardWidget =
              redeem.config.rewardAmountConfigurations.map<Widget>(
            (config) {
              double minAmount = config.minAmount;
              double maxAmount = config.lessThanEq;
              bool isEnabled =
                  currentAmount >= minAmount && currentAmount <= maxAmount;
              final isPassed = currentAmount > maxAmount;
              if (isEnabled || isPassed) {
                return RedeemPointTab(rewardPoint: config);
              }
              return NotActive(rewardPoint: config);
            },
          ).toList();

          return Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: length,
                  initialIndex: initialIndex,
                  child: Column(
                    children: [
                      ButtonsTabBar(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 30),
                        buttonMargin: Insets.padH.copyWith(top: 10),
                        unselectedLabelStyle: TextStyle(
                          color: context.colorTheme.surfaceBright,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorTheme.surfaceBright,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        radius: 100,
                        labelStyle: TextStyle(
                          color: context.colorTheme.surface,
                        ),
                        unselectedDecoration: BoxDecoration(
                          color: context.colorTheme.surface,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        tabs: rewardTabs,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: rewardWidget,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
