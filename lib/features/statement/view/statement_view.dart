import 'package:delivery_boy/features/statement/controller/statement_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

import 'local/statement_card.dart';

class StatementView extends HookConsumerWidget {
  const StatementView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statementData = ref.watch(statementCtrlProvider);
    final statementCtrl =
        useCallback(() => ref.read(statementCtrlProvider.notifier));
    return Scaffold(
      appBar: AppBar(
        title: Text(TR.of(context).earningStatement),
      ),
      body: Padding(
        padding: Insets.padAll,
        child: statementData.when(
          error: (e, s) => ErrorView(e, s, invalidate: statementCtrlProvider),
          loading: Loader.list,
          data: (statements) {
            return RefreshIndicator(
              onRefresh: () => statementCtrl().reload(),
              child: ListViewWithFooter(
                itemCount: statements.length,
                pagination: statements.pagination,
                onNext: (url) => statementCtrl().fromUrl(url),
                onPrevious: (url) => statementCtrl().fromUrl(url),
                itemBuilder: (context, index) =>
                    StatementCard(statements[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
