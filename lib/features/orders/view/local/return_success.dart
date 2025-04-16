import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class ReturnSuccessView extends ConsumerWidget {
  const ReturnSuccessView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderId = context.query('orderId');
    final address = context.query('address');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 47.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: context.colorTheme.primary.withOpacity(.1),
                    child: Assets.icon.orderBox.svg(height: 50),
                  ),
                  const Gap(Insets.lg),
                  Text(
                    'Product Return Success!',
                    style: context.textTheme.headlineSmall,
                  ),
                  Text(
                    'Your product has been Return successfully.',
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
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  context.colorTheme.onPrimary,
                ),
              ),
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
