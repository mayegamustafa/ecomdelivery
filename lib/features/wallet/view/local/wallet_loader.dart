import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class WalletLoader extends ConsumerWidget {
  const WalletLoader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          KShimmer.card(
            height: context.height / 5,
            width: double.infinity,
          ),
          const Gap(Insets.med),
          Row(
            children: [
              Expanded(
                child: KShimmer.card(
                  height: 100,
                ),
              ),
              const Gap(Insets.med),
              Expanded(
                child: KShimmer.card(
                  height: 100,
                ),
              ),
            ],
          ),
          const Gap(Insets.med),
          KShimmer.card(
            height: 30,
            width: double.infinity,
          ),
          const Gap(Insets.med),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: KShimmer.card(
                height: 70,
                width: double.infinity,
              ),
            ),
          )
        ],
      ),
    );
  }
}
