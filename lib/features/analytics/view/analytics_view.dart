import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

import '../controller/analytics_ctrl.dart';
import 'local/local.dart';

class AnalyticsView extends ConsumerWidget {
  const AnalyticsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticCtrl = ref.watch(analyticsCtrlProvider);
    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).analytics),
      ),
      body: analyticCtrl.when(
        loading: Loader.list,
        error: (e, s) => ErrorView(e, s, invalidate: analyticsCtrlProvider),
        data: (analytics) => SingleChildScrollView(
          child: Padding(
            padding: Insets.padH.copyWith(top: Insets.med),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  TR.of(context).totalOrders,
                  style: context.textTheme.titleLarge,
                ),
                const Gap(Insets.lg),
                TotalOrderChart(analytics: analytics),
                const Gap(Insets.lg),
                Row(
                  children: [
                    Expanded(
                      child: PrecentedOverviewCard(
                        icon: Assets.icon.goal.svg(
                          height: 25,
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                        iconColor: context.colorTheme.primary,
                        percentValue: analytics.overview.deliveredPercentage,
                        title: TR.of(context).successRates,
                        subtitle:
                            '${TR.of(context).delivery} ${analytics.overview.totalDelivered.toString()}',
                      ),
                    ),
                    const Gap(Insets.med),
                    Expanded(
                      child: PrecentedOverviewCard(
                        icon: Assets.icon.office.svg(
                          height: 25,
                          colorFilter: ColorFilter.mode(
                            context.colorTheme.errorContainer,
                            BlendMode.srcIn,
                          ),
                        ),
                        iconColor: context.colorTheme.errorContainer,
                        percentValue: analytics.overview.pendingPercentage,
                        title: TR.of(context).pendingRates,
                        subtitle:
                            '${TR.of(context).pending} ${analytics.overview.pendingOrder.toString()}',
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.lg),
                Text(
                  TR.of(context).earningsHistory,
                  style: context.textTheme.titleLarge,
                ),
                const Gap(Insets.lg),
                EarningHistoryChart(earningLog: analytics.overview.earningLog),
                const Gap(Insets.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PrecentedOverviewCard extends StatelessWidget {
  const PrecentedOverviewCard({
    super.key,
    required this.icon,
    required this.percentValue,
    required this.title,
    required this.subtitle,
    required this.iconColor,
  });

  final Widget icon;
  final double percentValue;
  final String title;
  final String subtitle;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
        color: context.colorTheme.surface,
      ),
      padding: Insets.padAllContainer,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.square(
                dimension: 50,
                child: CircularProgressIndicator(
                  color: iconColor,
                  value: percentValue / 100,
                  backgroundColor: iconColor.withOpacity(.1),
                ),
              ),
              Positioned(child: icon),
            ],
          ),
          const Gap(Insets.med),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${percentValue.toStringAsFixed(1)}%'),
                Text(title).fit,
                Text(subtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
