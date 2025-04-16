import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class WithdrawSuccessView extends ConsumerWidget {
  const WithdrawSuccessView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trx = context.query('trx');
    final method = context.query('method');

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
                  const Gap(Insets.med),
                  Text(
                    TR.of(context).withdrawSuccess,
                    style: context.textTheme.headlineSmall,
                  ),
                  Text(
                    TR.of(context).youHaveSuccessfully,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorTheme.surfaceBright.withOpacity(.6),
                    ),
                  ),
                  const Gap(Insets.offset),
                  if (trx != null || method != null)
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
                              TR.of(context).orderDetails,
                              style: context.textTheme.titleLarge,
                            ),
                            const Gap(Insets.lg),
                            if (trx != null)
                              HText(
                                  title: TR.of(context).transactionId,
                                  value: trx),
                            const Gap(Insets.med),
                            if (method != null)
                              HText(
                                  title: TR.of(context).bankInfo,
                                  value: method),
                          ],
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: Insets.padH.copyWith(bottom: Insets.med),
            child: SubmitButton(
              onPressed: (l) => context.push(RoutePaths.home),
              child: Text(TR.of(context).backToHome),
            ),
          )
        ],
      ),
    );
  }
}
