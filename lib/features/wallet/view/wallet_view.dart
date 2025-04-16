import 'package:collection/collection.dart';
import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/wallet/controller/wallet_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import 'local/local.dart';
import 'local/withdraw_details.dart';

class WalletView extends HookConsumerWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawCtrl =
        useCallback(() => ref.read(withDrawListCtrlProvider.notifier));
    final homeData = ref.watch(homeCtrlProvider);

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).myWallet),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(homeCtrlProvider);
          return withdrawCtrl().reload();
        },
        child: homeData.when(
          error: (e, s) => ErrorView(e, s, invalidate: homeCtrlProvider),
          loading: () => const WalletLoader(),
          data: (homeData) => SingleChildScrollView(
            physics: kDefaultScrollPhysics,
            padding: Insets.padH,
            child: Column(
              children: [
                Stack(
                  children: [
                    Assets.svg.walletBg.svg(
                      width: context.width,
                    ),
                    Positioned(
                      top: 20,
                      bottom: 20,
                      left: 10,
                      right: 10,
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(Insets.lg),
                            Text(
                              TR.of(context).walletBalance,
                              style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colorTheme.onPrimary,
                              ),
                            ),
                            Text(
                              homeData.deliveryMan.balance.formate(),
                              style: context.textTheme.headlineSmall!.copyWith(
                                color: context.colorTheme.onPrimary,
                              ),
                            ),
                            const Gap(Insets.lg),
                            GestureDetector(
                              onTap: () => context.push(RoutePaths.withdraw),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: context.colorTheme.onPrimary,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 18,
                                        backgroundColor:
                                            context.colorTheme.primary,
                                        child: Assets.icon.arrowUp.svg(
                                          colorFilter: ColorFilter.mode(
                                            context.colorTheme.onPrimary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        TR.of(context).withdraw,
                                        style: context.textTheme.titleLarge!
                                            .copyWith(
                                          color: context.colorTheme.primary,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.med),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OverviewCard(
                        title: TR.of(context).totalWithdraw,
                        count: homeData.overview.totalSuccessWithdraw.formate(),
                      ),
                      const Gap(Insets.med),
                      OverviewCard(
                        title: TR.of(context).pendingWithdraw,
                        count: homeData.overview.totalPendingWithdraw.formate(),
                      ),
                      const Gap(Insets.med),
                      OverviewCard(
                        title: TR.of(context).rejectedWithdraw,
                        count:
                            homeData.overview.totalRejectedWithdraw.formate(),
                      ),
                    ],
                  ),
                ),
                const Gap(Insets.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TR.of(context).transactionHistory,
                      style: context.textTheme.titleLarge,
                    ),
                    TextButton(
                      onPressed: () => context.go(RoutePaths.report),
                      child: Text(TR.of(context).seeAll),
                    ),
                  ],
                ),
                const Gap(Insets.med),
                const TransactionListCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransactionListCard extends ConsumerWidget {
  const TransactionListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawData = ref.watch(withDrawListCtrlProvider);

    return withdrawData.when(
      loading: Loader.list,
      error: (e, s) => ErrorView(e, s, invalidate: withdrawMethodsProvider),
      data: (data) => ListView.builder(
        itemCount: data.listData.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final withdrawData = data.listData[index];
          return GestureDetector(
            onTap: () {
              final tapped = data.listData
                  .firstWhereOrNull((e) => e.trxNo == withdrawData.trxNo);
              if (tapped == null) return;
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                builder: (context) {
                  return WithdrawDetails(withdrawData: tapped);
                },
              );
            },
            child: KListTile(
              leading: CircleAvatar(
                backgroundColor:
                    context.colorTheme.surfaceBright.withOpacity(.1),
                child: Assets.icon.arrowDown.svg(),
              ),
              title: Text(withdrawData.trxNo).copyable(),
              subtitle: Text(
                withdrawData.readableTime,
                style: context.textTheme.bodyMedium!.textColor(
                  context.colorTheme.surfaceBright.withOpacity(.7),
                ),
              ),
              trailing: Text(
                '-${withdrawData.amount.formate()}',
                style: context.textTheme.bodyLarge!.copyWith(
                  color: context.colorTheme.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
    required this.title,
    required this.count,
  });

  final String title;
  final String count;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: Corners.medBorder,
      ),
      child: Padding(
        padding: Insets.padAllContainer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyMedium,
            ),
            Text(
              count,
              style: context.textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}

class WalletTransaction extends StatelessWidget {
  const WalletTransaction({
    super.key,
    required this.withdrawData,
  });
  final WithdrawData withdrawData;

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
              backgroundColor: context.colorTheme.surfaceBright.withOpacity(.1),
              child: Assets.icon.arrowDown.svg(),
            ),
            const Gap(Insets.med),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  withdrawData.trxNo,
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  withdrawData.readableTime,
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: context.colorTheme.surfaceBright.withOpacity(.7),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              '-${withdrawData.amount.formate()}',
              style: context.textTheme.bodyLarge!.copyWith(
                color: context.colorTheme.error,
              ),
            )
          ],
        ),
      ),
    );
  }
}
