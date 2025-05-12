import 'package:delivery_boy/features/home/view/request_order.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class RequestedOrderList extends ConsumerWidget {
  const RequestedOrderList({
    super.key,
    required this.requestedOrders,
  });

  final List<ProductOrder> requestedOrders;

  @override
  Widget build(BuildContext context, ref) {
   
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              TR.of(context).newOrders,
              style: context.textTheme.titleLarge,
            ),
            TextButton(
              onPressed: () => context.push(
                RoutePaths.requestOrders,
              ),
              child: Text(
                TR.of(context).seeAll,
                style: context.textTheme.bodyMedium!.textColor(
                  context.colorTheme.surfaceBright.op7,
                ),
              ),
            ),
          ],
        ),
        const Gap(Insets.med),
        ListView.builder(
          itemCount: requestedOrders.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final order = requestedOrders[index];
            return RequestedOrderTile(order: order);
          },
        ),
      ],
    );
  }
}
