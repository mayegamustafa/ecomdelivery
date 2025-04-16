import 'package:delivery_boy/features/wallet/controller/wallet_ctrl.dart';
import 'package:delivery_boy/features/wallet/view/local/withdraw_method_card.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';

class SelectMethodSheet extends ConsumerWidget {
  const SelectMethodSheet({
    super.key,
    required this.onSelected,
    required this.isSelected,
  });

  final Function(WithdrawMethod method) onSelected;
  final Function(WithdrawMethod method) isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methodList = ref.watch(withdrawMethodsProvider);

    return Container(
      color: context.colorTheme.surfaceBright.withOpacity(.04),
      height: context.height,
      child: methodList.when(
        loading: Loader.list,
        error: ErrorView.new,
        data: (methods) {
          return Column(
            children: [
              const Gap(Insets.offset),
              Row(
                children: [
                  SquareButton.backButton(
                    onPressed: () => context.pop(),
                  ),
                  const Gap(50),
                  Text(
                    TR.of(context).withdrawMethod,
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
              const Gap(Insets.lg),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: methods.length,
                itemBuilder: (context, index) {
                  final method = methods[index];
                  return WithdrawMethodCard(
                    method: method,
                    isSelected: isSelected(method),
                    onSelected: onSelected,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
