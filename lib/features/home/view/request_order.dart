import 'package:delivery_boy/features/home/view/local/new_order_timeline.dart';
import 'package:delivery_boy/features/home/view/local/reject_dialog.dart';
import 'package:delivery_boy/features/orders/controller/request_order_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class RequestOrderView extends ConsumerWidget {
  const RequestOrderView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestCtrl = ref.watch(requestOrderCtrlProvider);

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).requestOrder),
      ),
      body: requestCtrl.when(
        error: (e, s) => ErrorView(e, s, invalidate: requestOrderCtrlProvider),
        loading: Loader.list,
        data: (requestData) => ListView.builder(
          padding: Insets.padH,
          itemCount: requestData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final order = requestData[index];
            return RequestedOrderTile(order: order);
          },
        ),
      ),
    );
  }
}

class RequestedOrderTile extends ConsumerWidget {
  const RequestedOrderTile({
    super.key,
    required this.order,
  });

  final ProductOrder order;

  @override
  Widget build(BuildContext context, ref) {
    final defOrderStatus = ref.watch(
      localSettingsCtrlProvider.select((s) => s?.config.defaultOrderStatus),
    );
    final settingCtrl = ref.watch(localSettingsCtrlProvider);

    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: Corners.lgBorder,
            color: context.colorTheme.surface,
          ),
          padding: Insets.padAllContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TR.of(context).orderNumber,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorTheme.surfaceBright.withOpacity(.7),
                ),
              ),
              Text(
                order.orderId,
                style: context.textTheme.bodyLarge,
              ).copyable(),
              const Gap(Insets.xl),
              NewOrderTimeLine(
                orderStatus: order.orderStatus,
                defStatus: OrderStatuses.def(
                  defOrderStatus!,
                  order.humanReadableTime,
                ),
              ),
              const Gap(Insets.xl),
              Row(
                children: [
                  Expanded(
                    child: SubmitButton(
                      onPressed: (l) => context.push(
                        RoutePaths.orderDetails(order.orderId),
                      ),
                      child: Text(TR.of(context).viewOrder),
                    ),
                  ),
                  const Gap(Insets.med),
                  if (settingCtrl?.config.declineAssignRequest == true)
                    Expanded(
                      child: SubmitButton(
                        onPressed: (l) {
                          showDialog(
                            context: context,
                            builder: (context) => RejectDialog(
                              orderId: order.id.toString(),
                            ),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            context.colorTheme.primary,
                          ),
                        ),
                        child: Text(
                          TR.of(context).rejectOrder,
                          style: TextStyle(
                            color: context.colorTheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(TR.of(context).assignTime),
              Text(
                order.orderDeliveryInfo.createdAt,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
