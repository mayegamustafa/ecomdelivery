import 'package:delivery_boy/features/orders/view/local/order_map.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class OrderInfoHead extends StatelessWidget {
  const OrderInfoHead({
    super.key,
    required this.order,
  });
  final ProductOrder order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.lgBorder,
        color: context.colorTheme.surface,
      ),
      padding: Insets.padAllContainer,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0x80FFE6BC),
                child: Assets.icon.orderBox.svg(),
              ),
              const Gap(Insets.med),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    '#${order.orderId}',
                    style: context.textTheme.bodyLarge,
                  ),
                  Text(
                    order.humanReadableTime,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colorTheme.surfaceBright.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(Insets.med),
          OrderMap(
            destination: order.billingAddress?.latLng,
            address: order.billingAddress?.address,
          ),
        ],
      ),
    );
  }
}
