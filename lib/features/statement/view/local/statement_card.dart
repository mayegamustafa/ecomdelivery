import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class StatementCard extends ConsumerWidget {
  const StatementCard(this.earning, {super.key});

  final EarningData earning;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ShadowContainer(
      offset: const Offset(0, 0),
      child: Padding(
        padding: Insets.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order: ${earning.orderId}',
                      style: context.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(earning.details, maxLines: 2),
                    const Gap(Insets.med),
                    Row(
                      children: [
                        Text(
                          '${'tr.earing_amt'}: ',
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          earning.amount.formate(),
                          style: context.textTheme.titleLarge?.copyWith(
                            color: context.colorTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                DecoratedContainer(
                  padding: Insets.padSym(4, 8),
                  color: context.colorTheme.primary.withOpacity(.1),
                  borderRadius: Corners.med,
                  child: Text(
                    earning.readableDate,
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            FilledButton(
              onPressed: () =>
                  context.push(RoutePaths.statementDetails(earning.orderId)),
              child: const Text('tr.btn.view_details'),
            )
          ],
        ),
      ),
    );
  }
}
