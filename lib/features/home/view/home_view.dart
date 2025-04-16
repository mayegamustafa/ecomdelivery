import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/home/view/local/delivery_status_card.dart';
import 'package:delivery_boy/features/home/view/local/order_history_card.dart';
import 'package:delivery_boy/features/home/view/local/requested_order_list.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import 'home_init_page.dart';
import 'local/local.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeData = ref.watch(homeCtrlProvider);

    return HomeInitPage(
      child: SafeArea(
        child: homeData.when(
          error: (error, stackTrace) => ErrorView(error, stackTrace),
          loading: () => const HomeLoader(),
          data: (homeData) {
            return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size(double.infinity, 150),
                child: HomeAppbar(deliveryMan: homeData.deliveryMan),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  ref.read(homeCtrlProvider.notifier).reload();
                  ref.read(appSettingsCtrlProvider.notifier).reload();
                },
                child: SingleChildScrollView(
                  padding: Insets.padH.copyWith(top: 10),
                  physics: kDefaultScrollPhysics,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //! summaries
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          itemCount: homeData.overview.deliveryData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final data = homeData.overview.deliveryData[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: DeliveryStatusCard(
                                amount: data.count.toString(),
                                status: data.title,
                                svg: data.svg.svg(),
                              ),
                            );
                          },
                        ),
                      ),

                      //! newOrders
                      if (homeData.requestedOrders.isNotEmpty) ...[
                        const Gap(Insets.xl),
                        RequestedOrderList(
                          requestedOrders: homeData.requestedOrders,
                        ),
                      ],
                      if (homeData.latestOrders.isNotEmpty) ...[
                        const Gap(Insets.lg),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              TR.of(context).orderHistory,
                              style: context.textTheme.titleLarge,
                            ),
                            TextButton(
                              onPressed: () => context.push(RoutePaths.orders),
                              child: Text(
                                TR.of(context).seeAll,
                                style: TextStyle(
                                  color: context.colorTheme.surfaceBright
                                      .withOpacity(.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(Insets.med),
                        ListView.builder(
                          itemCount: homeData.latestOrders.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final data = homeData.latestOrders[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: OrderHistoryCard(
                                orderData: data,
                                svg: Assets.icon.orderBox.svg(),
                                onTap: () => context.push(
                                  RoutePaths.acceptOrder(data.orderId),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                      if (homeData.overview.canShowPieChart()) ...[
                        const Gap(Insets.lg),
                        Text(
                          TR.of(context).withdrawChart,
                          style: context.textTheme.titleLarge,
                        ),
                        const Gap(Insets.med),
                        SizedBox(
                          height: 300,
                          child: DoughnutChartView(homeData.overview),
                        ),
                      ],

                      const Gap(Insets.lg),
                      Text(
                        TR.of(context).earningChart,
                        style: context.textTheme.titleLarge,
                      ),
                      const Gap(Insets.med),
                      SizedBox(
                        height: 250,
                        child: EarningChart(homeData.overview),
                      ),
                      const Gap(Insets.lg),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
