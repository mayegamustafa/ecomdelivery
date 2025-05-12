import 'package:delivery_boy/features/wallet/controller/withdraw_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class WithdrawConfirmDialog extends ConsumerWidget {
  const WithdrawConfirmDialog({
    super.key,
    required this.formData,
  });

  final QMap formData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawData = ref.watch(withdrawCtrlProvider);

    final extraData = formData.entries.where((e) => e.key != 'amount').toList();

    if (withdrawData == null) {
      return AlertDialog(
        title: Text(TR.of(context).withdrawRequest),
        content: Text(TR.of(context).somethinWrongWithdraw),
        actions: [
          TextButton(
            onPressed: () => context.nPop(),
            child: Text(TR.of(context).ok),
          ),
        ],
      );
    }

    Future<bool> withdrawConfirm() async {
      final ctrl = ref.read(withdrawCtrlProvider.notifier);
      final data = <String, dynamic>{};
      for (var e in extraData) {
        data.addAll({e.key: e.value});
      }
      return await ctrl.store('${withdrawData.id}', data);
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      decoration: const BoxDecoration(
        borderRadius: Corners.medBorder,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TR.of(context).withdrawPreview),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.nPop(),
            icon: const Icon(Icons.close_rounded),
          ),
        ),
        bottomNavigationBar: SubmitButton(
          padding: Insets.padAll,
          onPressed: (l) async {
            final trx = withdrawData.trxNo;
            final method = withdrawData.method.name;
            l.value = true;
            final isOk = await withdrawConfirm();
            l.value = false;

            if (context.mounted && isOk) {
              context.nPop(true);
              final uri = Uri(
                path: RoutePaths.withdrawSuccess,
                queryParameters: {'trx': trx, 'method': method},
              );
              context.go(uri.toString());
            } else {
              if (context.mounted) context.nPop(false);
            }
          },
          child: Text(TR.of(context).withdraw),
        ),
        body: SingleChildScrollView(
          padding: Insets.padAll,
          child: SeparatedColumn(
            separatorBuilder: () => const Gap(Insets.lg),
            children: [
              SpacedText(
                left: TR.of(context).withdrawMethod,
                right: withdrawData.method.name,
                style: context.textTheme.bodyLarge,
              ),
              SpacedText(
                left: TR.of(context).withdrawAmount,
                right: withdrawData.amount.formate(useBase: true),
                style: context.textTheme.bodyLarge,
              ),
              SpacedText(
                left: TR.of(context).charge,
                right: withdrawData.charge.formate(useBase: true),
                style: context.textTheme.bodyLarge,
              ),
              SpacedText(
                left: TR.of(context).conversionRate,
                right:
                    '${withdrawData.currency.rate} ${withdrawData.currency.name}',
                style: context.textTheme.bodyLarge,
              ),
              const Divider(),
              SpacedText(
                left: TR.of(context).finalAmount,
                right: withdrawData.finalAmount
                    .formate(currency: withdrawData.currency),
                style: context.textTheme.titleMedium,
                styleBuilder: (left, right) => (
                  left,
                  context.textTheme.titleLarge?.copyWith(
                    color: context.colorTheme.primary,
                  ),
                ),
              ),
              const Divider(),
              for (var MapEntry(:key, :value) in extraData)
                SpacedText(
                  left: withdrawData.method.inputLabelFromName(key),
                  right: value,
                  style: context.textTheme.bodyLarge,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
