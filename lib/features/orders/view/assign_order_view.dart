import 'package:delivery_boy/features/orders/controller/orders_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'local/order_map.dart';

class AssignOrderView extends HookConsumerWidget {
  const AssignOrderView(this.id, {super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderData = ref.watch(orderCtrlProvider(id));
    final deliveryman = ref.watch(deliveryManCtrlProvider);
    final deliverymanCtrl =
        useCallback(() => ref.read(deliveryManCtrlProvider.notifier));
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).assignOrder),
      ),
      body: orderData.when(
        error: (e, s) => ErrorView(e, s, invalidate: orderCtrlProvider),
        loading: Loader.list,
        data: (order) => deliveryman.when(
          error: (e, s) => ErrorView(e, s, invalidate: deliveryManCtrlProvider),
          loading: Loader.list,
          data: (deliverymanList) {
            return Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: Insets.padH,
                    child: OrderMap(
                      height: context.height / 2,
                      destination: order.billingAddress?.latLng,
                      address: order.billingAddress?.address,
                    ),
                  ),
                ),
                const Gap(Insets.lg),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: Insets.padH,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.vertical(top: Corners.lgRadius),
                        color: context.colorTheme.surface,
                      ),
                      padding: Insets.padH,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Gap(Insets.lg),
                          Text(
                            'Deliverymen',
                            style: context.textTheme.bodyLarge,
                          ),
                          const Gap(Insets.med),
                          SearchField(
                            hint: 'Search by name',
                            fillColor: context.colorTheme.surfaceBright
                                .withOpacity(.05),
                            autoSearch: true,
                            onSearch: (query) =>
                                deliverymanCtrl().search(query),
                            onClear: () => deliverymanCtrl().reload(),
                          ),
                          const Gap(Insets.med),
                          Expanded(
                            child: ListView.builder(
                              itemCount: deliverymanList.length,
                              itemBuilder: (context, index) {
                                return DeliverymanCard(
                                  id: order.id.toString(),
                                  deliveryman: deliverymanList[index],
                                  orderID: order.orderId,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DeliverymanCard extends HookConsumerWidget {
  const DeliverymanCard({
    super.key,
    required this.deliveryman,
    required this.orderID,
    required this.id,
  });

  final DeliveryMan deliveryman;
  final String id;
  final String orderID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => _AssignSheet(
          deliveryman: deliveryman,
          id: id,
          orderID: orderID,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                color: context.colorTheme.surfaceBright.withOpacity(.03),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: HostedImage.provider(
                            deliveryman.image,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: deliveryman.isOnlineStatusActive &&
                                    deliveryman.isOnline
                                ? context.colorTheme.errorContainer
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const Gap(Insets.med),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deliveryman.fullName,
                          style: context.textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: context.width / 1.8,
                          child: Text(
                            deliveryman.address.address,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: context.colorTheme.surfaceBright
                                  .withOpacity(.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Text(
                deliveryman.distanceInWords,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: context.colorTheme.surfaceBright.withOpacity(.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignSheet extends HookConsumerWidget {
  const _AssignSheet({
    required this.deliveryman,
    required this.id,
    required this.orderID,
  });

  final DeliveryMan deliveryman;
  final String id;
  final String orderID;

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized(() => GlobalKey<FormBuilderState>());
    final orderCtrl =
        useCallback(() => ref.read(orderCtrlProvider(orderID).notifier));
    final settingCtrl = ref.watch(localSettingsCtrlProvider);
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: FormBuilder(
        key: formKey,
        child: Padding(
          padding: Insets.padAll,
          child: Stack(
            children: [
              SizedBox(
                width: context.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: HostedImage.provider(
                        deliveryman.image,
                      ),
                    ),
                    const Gap(Insets.med),
                    Text(
                      deliveryman.fullName,
                      style: context.textTheme.bodyLarge,
                    ),
                    Text(
                      deliveryman.distanceInWords,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorTheme.surfaceBright.withOpacity(.7),
                      ),
                    ),
                    const Gap(Insets.lg),
                    FormBuilderTextField(
                      name: 'pickup_location',
                      maxLines: 2,
                      decoration: InputDecoration(
                        fillColor:
                            context.colorTheme.surfaceBright.withOpacity(.05),
                        hintText: TR.of(context).enterPickupLocation,
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
                    const Gap(Insets.med),
                    FormBuilderTextField(
                      name: 'note',
                      maxLines: 2,
                      decoration: InputDecoration(
                        fillColor:
                            context.colorTheme.surfaceBright.withOpacity(.05),
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
                    ),
                    const Gap(Insets.offset),
                    if (settingCtrl!.config.orderAssign)
                      SubmitButton(
                        onPressed: (l) async {
                          final state = formKey.currentState!;
                          if (!state.saveAndValidate()) return;
                          l.value = true;
                          await orderCtrl().assignOrder(
                            formData: state.value,
                            id: id,
                            deliverymanID: deliveryman.id.toString(),
                          );
                          l.value = false;
                          if (context.mounted) {
                            context.nPop();
                            context.push(
                              RoutePaths.acceptOrder(orderID),
                            );
                          }
                        },
                        child: Text(TR.of(context).assignOrder),
                      ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
