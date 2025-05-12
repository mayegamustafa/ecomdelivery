import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key,
    required this.orderData,
    required this.svg,
    required this.onTap,
  });

  final ProductOrder orderData;
  final Widget svg;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.medBorder,
          color: context.colorTheme.surface,
        ),
        child: Padding(
          padding: Insets.padAllContainer,
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0x80FFE6BC),
                child: svg,
              ),
              const Gap(Insets.med),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '#${orderData.orderId}',
                          style: context.textTheme.bodyLarge,
                        ),
                        const Gap(Insets.sm),
                        GestureDetector(
                          onTap: () => Clipper.copy(orderData.orderId),
                          child: Assets.icon.copy.svg(
                            colorFilter: ColorFilter.mode(
                              context.colorTheme.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                orderData.orderDetails.firstOrNull
                                        ?.productName ??
                                    '',
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
                                  orderData.orderAmount.formate(),
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
                                color: orderData.statusColor.withOpacity(.05),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                child: Text(
                                  orderData.deliveryStatus,
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    color: orderData.statusColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Text(
                            orderData.orderDeliveryInfo.createdAt.isNotEmpty
                                ? orderData.orderDeliveryInfo.createdAt
                                : orderData.humanReadableTime,
                          ).fit,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
