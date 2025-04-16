import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:delivery_boy/routes/route_name.dart';

class OtherPaymentView extends ConsumerWidget {
  const OtherPaymentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: GestureDetector(
            onTap: () => context.pop(),
            child: CircleAvatar(
              backgroundColor: context.colorTheme.surface,
              child: Assets.icon.arrowLeft.svg(
                height: 30,
                colorFilter: ColorFilter.mode(
                  context.colorTheme.surfaceBright,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        title: const Text('Other Payment'),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
