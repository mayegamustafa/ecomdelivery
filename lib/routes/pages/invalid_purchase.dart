import 'dart:io';

import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class InvalidPurchasePage extends HookConsumerWidget {
  const InvalidPurchasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: Insets.padAll,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.lottie.warning.lottie(height: 250),
              const SizedBox(height: 20),
              Text(
                TR.of(context).yourSoftwareIsNotInstalledYet,
                style: context.textTheme.titleLarge,
              ),
              Text(
                TR.of(context).pleaseContactYourAdmin,
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(150, 50),
                    ),
                    onPressed: () async {
                      final statusCtrl =
                          ref.read(serverStatusProvider.notifier);

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
            ],
          ),
        ),
      ),
    );
  }
}
