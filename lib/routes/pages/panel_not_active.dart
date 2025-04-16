import 'dart:io';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class PanelInactive extends ConsumerWidget {
  const PanelInactive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.lottie.panelNotActive.lottie(height: 250),
            Text(
              TR.of(context).deliverymanIsCurrentlyInactive,
              style: context.textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              TR.of(context).pleaseContactYourAdmin,
              style: context.textTheme.titleLarge,
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                  ),
                  onPressed: () async {
                    final statusCtrl = ref.read(serverStatusProvider.notifier);

                    await statusCtrl.retryStatusResolver();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(TR.of(context).retry),
                ),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                  ),
                  onPressed: () => exit(0),
                  icon: const Icon(Icons.exit_to_app_rounded),
                  label: Text(TR.of(context).exit),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
