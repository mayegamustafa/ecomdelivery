import 'package:collection/collection.dart';
import 'package:delivery_boy/features/wallet/controller/wallet_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

import '../../../transactions/controller/transactions_ctrl.dart';
import 'transaction_details.dart';

class AllTransactionTab extends HookConsumerWidget {
  const AllTransactionTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionData = ref.watch(transactionsCtrlProvider);
    final trxCtrl =
        useCallback(() => ref.read(transactionsCtrlProvider.notifier));

    return transactionData.when(
      loading: Loader.list,
      error: (e, s) => ErrorView(e, s, invalidate: withdrawMethodsProvider),
      data: (allTransaction) => Column(
        children: [
          SearchField(
            onSearch: (x) => trxCtrl().filter(search: x),
            onRangeSearch: (range) => trxCtrl().filter(dateRange: range),
            onClear: () => trxCtrl().reload(),
          ),
          Expanded(
            child: ListViewWithFooter(
              emptyListWidget: const NoDataFound(),
              physics: kDefaultScrollPhysics,
              itemCount: allTransaction.listData.length,
              onNext: (url) => trxCtrl().listByUrl(url),
              onPrevious: (url) => trxCtrl().listByUrl(url),
              pagination: allTransaction.pagination,
              itemBuilder: (context, index) {
                final allTransactionData = allTransaction.listData[index];
                return KListTile(
                  title: Text(allTransactionData.trxId).copyable(),
                  subtitle: Text(allTransactionData.date),
                  trailing: Text(
                    allTransactionData.formattedAmount,
                    style: context.textTheme.bodyLarge!.textColor(
                      allTransactionData.amountColor,
                    ),
                  ),
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
                  onTap: () {
                    final tapped = allTransaction.listData.firstWhereOrNull(
                        (e) => e.trxId == allTransactionData.trxId);
                    if (tapped == null) return;
                    showModalBottomSheet(
                      showDragHandle: true,
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      builder: (context) {
                        return TransactionDetails(transactionData: tapped);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
