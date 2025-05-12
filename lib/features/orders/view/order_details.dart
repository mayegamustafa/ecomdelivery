import 'package:collection/collection.dart';
import 'package:delivery_boy/features/home/view/local/reject_dialog.dart';
import 'package:delivery_boy/features/orders/controller/orders_ctrl.dart';
import 'package:delivery_boy/features/orders/view/local/accept_order_dialog.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../../settings/controller/settings_ctrl.dart';
import 'local/order_details_timeline.dart';

class OrderDetailsView extends HookConsumerWidget {
  const OrderDetailsView(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderCtrlProvider(id));
    final orderCtrl = useCallback(
      () => ref.read(orderCtrlProvider(id).notifier),
      [ref],
    );
    final settingsCtrl = ref.watch(localSettingsCtrlProvider);

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).orderDetails),
      ),
      body: orderData.when(
        error: (e, s) {
          return ErrorView(e, s, invalidate: orderCtrlProvider);
        },
        loading: Loader.list,
        data: (order) {
          RewardPointConfig? applicableRewardPoint() {
            return settingsCtrl?.config.rewardPointConfigurations
                .firstWhereOrNull(
              (e) => e.isBetween(order.orderAmount.toDouble()),
            );
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async =>
                      ref.refresh(orderCtrlProvider(id).notifier).reload(),
                  child: SingleChildScrollView(
                    padding: Insets.padAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: Corners.lgBorder,
                            color: context.colorTheme.surface,
                          ),
                          padding: Insets.padAllContainer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    TR.of(context).newOrders,
                                    style: context.textTheme.bodyLarge,
                                  ),
                                  if (settingsCtrl!.config.declineAssignRequest)
                                    GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => RejectDialog(
                                            orderId: order.id.toString(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: Corners.lgBorder,
                                          color: context.colorTheme.primary,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0,
                                            vertical: 5,
                                          ),
                                          child: Text(
                                            TR.of(context).rejectOrder,
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                              color:
                                                  context.colorTheme.onPrimary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              const Gap(Insets.med),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        TR.of(context).earnings,
                                        style: context.textTheme.bodyMedium,
                                      ),
                                      Text(
                                        order.orderDeliveryInfo.amount
                                            .formate(),
                                        style: context.textTheme.bodyLarge!
                                            .copyWith(
                                          color: context.colorTheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: Corners.lgBorder,
                                      color: order.paymentStatus == 'Unpaid'
                                          ? context.colorTheme.error.op(.05)
                                          : context.colorTheme.errorContainer
                                              .op(.05),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 5,
                                      ),
                                      child: Text(
                                        order.paymentStatus,
                                        style: context.textTheme.bodyMedium!
                                            .copyWith(
                                          color: order.paymentStatus == 'Unpaid'
                                              ? context.colorTheme.error
                                              : context
                                                  .colorTheme.errorContainer,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(Insets.sm),
                              const Divider(),
                              const Gap(Insets.med),
                              OrderDetailsTimeline(order: order),
                              const Gap(Insets.med),
                              SubmitButton(
                                onPressed: (l) async {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AcceptOrderDialog(
                                      title: TR
                                          .of(context)
                                          .areYouSureToAcceptThisOrder,
                                      onCancel: () => context.nPop(),
                                      onPressed: (note) async {
                                        await orderCtrl().requestOrder(
                                          id: order.id.toString(),
                                          status: '1',
                                          note: note,
                                        );

                                        if (context.mounted) {
                                          context.nPop();
                                          context.push(
                                            RoutePaths.acceptOrder(
                                              order.orderId,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                                child: Text(TR.of(context).acceptOrder),
                              ),
                            ],
                          ),
                        ),
                        const Gap(Insets.xl),
                        Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: Corners.lgBorder,
                                color: context.colorTheme.surface,
                              ),
                              child: Padding(
                                padding: Insets.padAllContainer,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      TR.of(context).orderInfo,
                                      style: context.textTheme.titleLarge,
                                    ),
                                    const Gap(Insets.xl),
                                    HText(
                                      title: TR.of(context).orderId,
                                      value: '#${order.orderId}',
                                    ),
                                    const Gap(Insets.med),
                                    HText(
                                      title: TR.of(context).orderDate,
                                      value: order.dateTime,
                                    ),
                                    const Gap(Insets.med),
                                    HText(
                                      title: TR.of(context).orderAmount,
                                      value: order.orderAmount.formate(),
                                    ),
                                    const Gap(Insets.med),
                                    if (order.billingAddress.isNotNullOrEmpty())
                                      HText(
                                        title: TR.of(context).billingAddress,
                                        value: order.billingAddress!.address,
                                      ),
                                    if (applicableRewardPoint() != null) ...[
                                      const Gap(Insets.med),
                                      HText(
                                        title: TR.of(context).point,
                                        value:
                                            '+${applicableRewardPoint()!.point}',
                                        color:
                                            context.colorTheme.errorContainer,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                            if (order.customer != null)
                              Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () => context.push(
                                    RoutePaths.chatDetails(
                                        '${order.customer?.id}'),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: context.colorTheme.primary,
                                    radius: 15,
                                    child: Assets.icon.chat.svg(height: 15),
                                  ),
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (settingsCtrl.config.orderAssign)
                Container(
                  color: context.colorTheme.surface,
                  child: Padding(
                    padding: Insets.padAll,
                    child: SubmitButton(
                      onPressed: (l) =>
                          context.push(RoutePaths.assignOrder(id)),
                      child: Text(TR.of(context).assignOrder),
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
