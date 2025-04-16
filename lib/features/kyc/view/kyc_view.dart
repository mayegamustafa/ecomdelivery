import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class KYCView extends ConsumerWidget {
  const KYCView(this.kyc, {super.key});

  final KYCLog kyc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).kycDetails),
      ),
      body: SingleChildScrollView(
        padding: Insets.padAll,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                color: context.colorTheme.surface,
              ),
              padding: Insets.padAll,
              child: SeparatedColumn(
                separatorBuilder: () => const Divider(height: 25),
                children: [
                  SpacedText(
                    left: TR.of(context).date,
                    styleBuilder: (left, right) => (
                      context.textTheme.titleMedium,
                      context.textTheme.titleMedium!.bold,
                    ),
                    right: kyc.readableTime,
                  ),
                  SpacedText(
                    left: TR.of(context).status,
                    right: kyc.statusConfig.$1,
                    styleBuilder: (left, right) => (
                      context.textTheme.titleMedium,
                      context.textTheme.titleMedium!.bold
                          .textColor(kyc.statusConfig.$2),
                    ),
                  ),
                  SpacedText(
                    left: TR.of(context).feedback,
                    right: kyc.feedback ?? 'N/A',
                    styleBuilder: (left, right) => (
                      context.textTheme.titleMedium,
                      context.textTheme.titleMedium!.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(Insets.lg),
            Container(
              decoration: BoxDecoration(
                borderRadius: Corners.medBorder,
                color: context.colorTheme.surface,
              ),
              padding: Insets.padAll,
              child: SeparatedColumn(
                separatorBuilder: () => const Divider(height: 25),
                children: [
                  for (var data in kyc.kyc.data.entries)
                    SpacedText(
                      left: data.key.replaceAll('_', ' ').toTitleCase,
                      right: data.value,
                      styleBuilder: (left, right) => (
                        context.textTheme.titleMedium,
                        context.textTheme.titleMedium!.bold,
                      ),
                    ),
                ],
              ),
            ),
            const Gap(Insets.lg),
            if (kyc.kyc.files.isNotEmpty)
              ShadowContainer(
                padding: Insets.padAll,
                child: SeparatedColumn(
                  separatorBuilder: () => const Divider(height: 25),
                  children: [
                    for (var data in kyc.kyc.files.entries)
                      Row(
                        children: [
                          Text(
                            data.key.replaceAll('_', ' ').toTitleCase,
                            style: context.textTheme.titleMedium,
                          ),
                          const Gap(Insets.med),
                          const Spacer(),
                          HostedImage.square(
                            data.value,
                            dimension: 100,
                            enablePreviewing: true,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            const Gap(Insets.med),
            FilledButton.icon(
              style: OutlinedButton.styleFrom(
                fixedSize: const Size.fromHeight(50),
              ),
              onPressed: () async {
                final test = ref.refresh(homeCtrlProvider);

                test.maybeWhen(
                  data: (d) =>
                      ref.read(serverStatusProvider.notifier).update(200),
                  orElse: () =>
                      Toaster.showError(TR.of(context).kycNotVerified),
                );
              },
              icon: const Icon(Icons.arrow_forward_rounded),
              label: Text(TR.of(context).goToHome),
            ),
            const Gap(Insets.med),
          ],
        ),
      ),
    );
  }
}
