import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class DeliverySuccessView extends ConsumerWidget {
  const DeliverySuccessView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderId = context.query('orderId');
    final address = context.query('address');
    final amount = context.query('amount');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: Insets.padH,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Assets.svg.done.svg(),
                  const Gap(Insets.lg),
                  Text(
                    'Delivered Success!',
                    style: context.textTheme.headlineSmall,
                  ),
                  Text(
                    'Your product has been delivered successfully.',
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge!.textColor(
                      context.colorTheme.surfaceBright.op7,
                    ),
                  ),
                  const Gap(Insets.offset),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: Corners.medBorder,
                      color: context.colorTheme.surface,
                    ),
                    child: Padding(
                      padding: Insets.padAllContainer,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Details',
                            style: context.textTheme.titleLarge,
                          ),
                          if (orderId != null) ...[
                            const Gap(Insets.lg),
                            HText(
                              title: 'Order Number',
                              value: orderId,
                            ),
                          ],
                          if (address != null) ...[
                            const Gap(Insets.lg),
                            HText(
                              title: 'Order From',
                              value: address,
                            ),
                          ],
                          if (amount != null) ...[
                            const Gap(Insets.lg),
                            HText(
                              title: 'Earning',
                              value: amount,
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: Insets.padH,
            child: SubmitButton(
              onPressed: (l) => context.go(RoutePaths.home),
              child: Text(
                'Back to home',
                style: TextStyle(
                  color: context.colorTheme.surfaceContainerHighest,
                ),
              ),
            ),
          ),
          const Gap(Insets.lg),
        ],
      ),
    );
  }
}
