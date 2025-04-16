import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class OrderPaymentInfo extends StatelessWidget {
  const OrderPaymentInfo({
    super.key,
    required this.order,
  });

  final ProductOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HText(
          title: 'Subtotal',
          value: order.orderAmount.formate(),
        ),
        const Gap(Insets.med),
        HText(
          title: 'Discount',
          value: order.discount.formate(),
        ),
        const Gap(Insets.med),
        HText(
          title: 'Tax',
          value: order.totalTax.formate(),
        ),
        const Gap(Insets.med),
        HText(
          title: 'Shipping Charge',
          value: order.shippingCharge.formate(),
        ),
        const Gap(Insets.med),
        HText(
          title: 'Payment',
          value: order.paymentVia ?? '',
        ),
        const Gap(Insets.lg),
        const DashedDivider(),
        const Gap(Insets.lg),
        Row(
          children: [
            Text(
              'Total ',
              style: context.textTheme.titleLarge,
            ),
            Text(
              '(incl. VAT)',
              style: context.textTheme.bodyMedium!.copyWith(
                color: context.colorTheme.surfaceBright.withOpacity(.7),
              ),
            ),
            const Spacer(),
            Text(
              order.totalAmount.formate(),
              style: context.textTheme.titleLarge,
            ),
          ],
        ),
      ],
    );
  }
}
