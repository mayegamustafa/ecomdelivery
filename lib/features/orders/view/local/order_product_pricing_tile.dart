import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class OrderProductPricingTile extends StatelessWidget {
  const OrderProductPricingTile({
    super.key,
    required this.orderProduct,
  });

  final OrderDetails orderProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Insets.padAllContainer,
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
        color: context.colorTheme.surfaceBright.op(.03),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HostedImage(
            orderProduct.productImage,
            height: 50,
            width: 50,
          ),
          const Gap(Insets.med),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(orderProduct.productName),
                Text(
                  'Price: ${orderProduct.itemPrice.formate()}',
                ),
                Text(
                  'Quantity: ${orderProduct.quantity}',
                  style: context.textTheme.bodyMedium!.textColor(
                    context.colorTheme.surfaceBright.op7,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
