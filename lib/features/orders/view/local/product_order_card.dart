import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class ProductOrderCard extends StatelessWidget {
  const ProductOrderCard({
    super.key,
    required this.order,
  });

  final ProductOrder order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (order.orderDeliveryInfo.status.isPending) {
          context.push(RoutePaths.orderDetails(order.orderId));
        } else {
          context.push(RoutePaths.acceptOrder(order.orderId));
        }
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: Corners.medBorder,
          color: context.colorTheme.surface,
        ),
        padding: Insets.padAll,
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: context.colorTheme.primary.withOpacity(.1),
              child: Assets.icon.orderBox.svg(),
            ),
            const Gap(Insets.med),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.orderId,
                    style: context.textTheme.bodyLarge,
                  ).copyable(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderDetails.firstOrNull?.productName ?? '',
                              style: TextStyle(
                                color: context.colorTheme.onSurface
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Gap(Insets.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xff00BBFF).withOpacity(.1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                order.orderAmount.formate(),
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: const Color(0xff00BBFF),
                                ),
                              ),
                            ),
                          ),
                          const Gap(Insets.sm),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: order.statusColor.withOpacity(.05),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                order.deliveryStatus,
                                style: context.textTheme.bodyLarge!.copyWith(
                                  color: order.statusColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(order.humanReadableTime),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
