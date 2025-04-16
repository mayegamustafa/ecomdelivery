import 'package:collection/collection.dart';
import 'package:delivery_boy/features/wallet/controller/wallet_ctrl.dart';
import 'package:delivery_boy/features/wallet/view/local/withdraw_details.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class WithdrawTransactionsTab extends HookConsumerWidget {
  const WithdrawTransactionsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawData = ref.watch(withDrawListCtrlProvider);
    final withdrawCtrl =
        useCallback(() => ref.read(withDrawListCtrlProvider.notifier));

    return withdrawData.when(
      loading: Loader.list,
      error: (e, s) => ErrorView(e, s, invalidate: withdrawMethodsProvider),
      data: (withdraw) => Column(
        children: [
          SearchField(
            onSearch: (x) => withdrawCtrl().filter(search: x),
            onRangeSearch: (range) => withdrawCtrl().filter(range: range),
            onClear: () => withdrawCtrl().reload(),
          ),
          Expanded(
            child: ListViewWithFooter(
              emptyListWidget: const NoDataFound(),
              itemCount: withdraw.listData.length,
              pagination: withdraw.pagination,
              onNext: (url) => withdrawCtrl().listByUrl(url),
              onPrevious: (url) => withdrawCtrl().listByUrl(url),
              itemBuilder: (context, index) {
                final withdrawData = withdraw.listData[index];
                return GestureDetector(
                  onTap: () {
                    final tapped = withdraw.listData
                        .firstWhereOrNull((e) => e.trxNo == withdrawData.trxNo);
                    if (tapped == null) return;
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      builder: (context) {
                        return WithdrawDetails(withdrawData: tapped);
                      },
                    );
                  },
                  child: KListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          context.colorTheme.surfaceBright.withOpacity(.1),
                      child: Assets.icon.arrowDown.svg(
                        colorFilter: ColorFilter.mode(
                          context.colorTheme.surfaceBright,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    title: Text(withdrawData.trxNo).copyable(),
                    subtitle: Text(
                      withdrawData.readableTime,
                      style: context.textTheme.bodyMedium!.textColor(
                        context.colorTheme.surfaceBright.withOpacity(.7),
                      ),
                    ),
                    trailing: Text(
                      '-${withdrawData.amount.formate()}',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: context.colorTheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
