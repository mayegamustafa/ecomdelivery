import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/orders/controller/orders_ctrl.dart';
import 'package:delivery_boy/features/orders/view/local/order_info_head.dart';
import 'package:delivery_boy/features/orders/view/local/order_payment_info.dart';
import 'package:delivery_boy/features/orders/view/local/order_product_pricing_tile.dart';
import 'package:delivery_boy/features/orders/view/local/swipe_to_deliver.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AcceptOrderView extends HookConsumerWidget {
  const AcceptOrderView(this.id, {super.key});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderCtrlProvider(id));
    final orderCtrl =
        useCallback(() => ref.read(orderCtrlProvider(id).notifier));
    final homeCtrl = ref.watch(localHomeCtrlProvider);

    final isDelivered = useState(false);

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).orderDetails),
      ),
      body: orderData.when(
        error: (e, s) => ErrorView(e, s, invalidate: orderCtrlProvider),
        loading: Loader.list,
        data: (order) {
          final assignedToMe =
              order.orderDeliveryInfo.assignTo?.id == homeCtrl?.deliveryMan.id;
          final assignedByMe =
              order.orderDeliveryInfo.assignBy?.id == homeCtrl?.deliveryMan.id;

          String? orderStatusNote() {
            final status = order.orderDeliveryInfo.status;
            final name = assignedToMe
                ? 'me'
                : order.orderDeliveryInfo.assignTo?.firstName ?? 'n/a';

            final msg = 'This order has been ${status.statusName} by $name';

            final showNoteOn = [
              if (assignedByMe) DeliveryStatus.accepted,
              DeliveryStatus.rejected,
              DeliveryStatus.delivered,
              DeliveryStatus.productReturn
            ];

            if (showNoteOn.contains(status)) return msg;

            return null;
          }

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => orderCtrl().reload(),
                  child: SingleChildScrollView(
                    physics: kDefaultScrollPhysics,
                    padding: Insets.padAll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (orderStatusNote() != null)
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: Corners.medBorder,
                              color: order
                                  .orderDeliveryInfo.status.statusColor.op1,
                            ),
                            padding: Insets.padSym(10, 15),
                            child: Text(
                              orderStatusNote()!,
                              style: context.textTheme.bodyLarge!.textColor(
                                order.orderDeliveryInfo.status.statusColor,
                              ),
                            ),
                          ),
                        if (order.billingAddress?.latLng != null)
                          Stack(
                            children: [
                              OrderInfoHead(order: order),
                            ],
                          ),
                        const Gap(Insets.lg),
                        Stack(
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
                                  Text(
                                    TR.of(context).orderInfo,
                                    style: context.textTheme.titleLarge,
                                  ),
                                  const Gap(Insets.lg),
                                  HText(
                                    title: TR.of(context).orderId,
                                    value: '#${order.orderId}',
                                  ),
                                  const Gap(Insets.med),
                                  HText(
                                    title: TR.of(context).totalEarning,
                                    value: order.orderDeliveryInfo.amount
                                        .formate(),
                                  ),
                                  const Gap(Insets.med),
                                  HText(
                                    title: TR.of(context).assignDate,
                                    value: order.orderDeliveryInfo.createdAt,
                                  ),
                                  const Gap(Insets.med),
                                  HText(
                                    title: TR.of(context).orderDate,
                                    value: order.humanReadableTime,
                                  ),
                                  const Gap(Insets.med),
                                  ListView.separated(
                                    itemCount: order.orderDetails.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    separatorBuilder: (_, __) =>
                                        const Gap(Insets.med),
                                    itemBuilder: (context, index) {
                                      final orderProduct =
                                          order.orderDetails[index];
                                      return OrderProductPricingTile(
                                        orderProduct: orderProduct,
                                      );
                                    },
                                  ),
                                  const Gap(Insets.med),
                                  if (order.shippingInformation != null)
                                    HText(
                                      title: TR.of(context).shippingInformation,
                                      value: order.shippingInformation!.name,
                                    ),
                                  const Gap(Insets.med),
                                  if (order.billingAddress != null)
                                    HText(
                                      title: TR.of(context).billingAddress,
                                      value: order.billingAddress!.address,
                                    ),
                                  const Gap(Insets.lg),
                                  const DashedDivider(),
                                  const Gap(Insets.lg),
                                  OrderPaymentInfo(order: order),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Row(
                                children: [
                                  if (order.customer != null)
                                    GestureDetector(
                                      onTap: () => context.push(
                                        RoutePaths.chatDetails(
                                            '${order.customer?.id}'),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            context.colorTheme.primary,
                                        radius: 15,
                                        child: Assets.icon.chat.svg(height: 15),
                                      ),
                                    ),
                                  const Gap(Insets.med),
                                  if (!order.orderDeliveryInfo.status.isFinis)
                                    if (assignedToMe)
                                      if (!order.isFinish)
                                        GestureDetector(
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  _AcceptSheet(
                                                id: order,
                                                title: TR
                                                    .of(context)
                                                    .areYouWantToReturnThisOrder,
                                                status: '4',
                                                orderID: order.orderId,
                                                buttonTitle: TR
                                                    .of(context)
                                                    .returnProduct,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: Corners.lgBorder,
                                              color: context.colorTheme.primary,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              TR.of(context).returnProduct,
                                              style: context
                                                  .textTheme.bodyLarge!
                                                  .copyWith(
                                                color: context
                                                    .colorTheme.onPrimary,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Gap(Insets.lg),
                      ],
                    ),
                  ),
                ),
              ),
              if (!order.orderDeliveryInfo.status.isFinis && assignedToMe)
                if (!order.isFinish)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SizedBox(
                      height: 60,
                      width: context.width,
                      child: Center(
                        child: SwipeToDeliverButton(
                          isDelivered: isDelivered,
                          svg: Assets.icon.swipeButton.svg(height: 18),
                          beforeSwipe: TR.of(context).swipeToDeliver,
                          afterSwipe: 'Delivering...',
                          onSwipe: () async {
                            final res = await showDialog(
                              context: context,
                              builder: (context) => _AcceptSheet(
                                id: order,
                                title: TR
                                    .of(context)
                                    .areYouWantToDeliveryThisOrder,
                                status: '3',
                                orderID: order.orderId,
                                buttonTitle: TR.of(context).delivered,
                              ),
                            );

                            if (res == null) isDelivered.value = false;
                          },
                        ),
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

class _AcceptSheet extends HookConsumerWidget {
  const _AcceptSheet({
    required this.id,
    required this.orderID,
    required this.status,
    required this.title,
    required this.buttonTitle,
  });

  final ProductOrder id;
  final String orderID;
  final String status;
  final String title;
  final String buttonTitle;

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final orderCtrl =
        useCallback(() => ref.read(orderCtrlProvider(orderID).notifier));
    final settingCtrl = ref.watch(localSettingsCtrlProvider);
    return AlertDialog(
      content: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icon.orderBox.svg(height: 50),
              const Gap(Insets.med),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge,
              ),
              const Gap(Insets.lg),
              if (settingCtrl!.config.orderVerification)
                FormBuilderTextField(
                  name: 'verification_code',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor:
                        context.colorTheme.surfaceBright.withOpacity(.05),
                    hintText: TR.of(context).enterOtpCode,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: Corners.medBorder,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: Corners.medBorder,
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              const Gap(Insets.med),
              FormBuilderTextField(
                name: 'note',
                maxLines: 2,
                decoration: InputDecoration(
                  fillColor: context.colorTheme.surfaceBright.withOpacity(.05),
                  hintText: TR.of(context).enterNote,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: Corners.medBorder,
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: Corners.medBorder,
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const Gap(Insets.offset),
              SubmitButton(
                onPressed: (l) async {
                  final state = formKey.currentState!;
                  if (!state.saveAndValidate()) return;
                  l.value = true;
                  await orderCtrl().handleOrder(
                    formData: state.value,
                    id: id.id.toString(),
                    status: status,
                  );
                  l.value = false;
                  if (context.mounted) {
                    context.nPop();
                    if (status == '3') {
                      context.goQuery(RoutePaths.deliverySuccess,
                          queryParameters: {
                            'orderId': orderID,
                            'address': id.billingAddress?.fullAddress,
                            'amount': id.orderDeliveryInfo.amount.formate()
                          });
                    } else {
                      context
                          .goQuery(RoutePaths.returnSuccess, queryParameters: {
                        'orderId': orderID,
                        'address': id.billingAddress?.fullAddress,
                      });
                    }
                  }
                },
                child: Text(buttonTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
