import 'package:delivery_boy/_core/l10n/gen_/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../_core/strings/app_const.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const Gap(Insets.med),
            Text(TR.of(context).cartUserDelivery),
          ],
        ),
      ),
    );
  }
}
