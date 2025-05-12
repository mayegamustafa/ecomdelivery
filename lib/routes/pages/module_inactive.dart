import 'dart:io';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class ModuleInactive extends HookConsumerWidget {
  const ModuleInactive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: Insets.padAll,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.lottie.underMaintenance.lottie(height: 250),
              Text(
                TR.of(context).deliverymanModuleOff,
                style: context.textTheme.titleLarge,
              ),
              Text(
                TR.of(context).msgDeliverymanModuleIs,
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
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
