import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

import 'local/local.dart';
import 'local/reword_log.dart';

class ReportView extends ConsumerWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).report),
      ),
      body: Padding(
        padding: Insets.padH.copyWith(top: Insets.med),
        child: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              SegmentedTabControl(
                selectedTabTextColor: context.colorTheme.onPrimary,
                textStyle: context.textTheme.bodyLarge,
                indicatorPadding: const EdgeInsets.all(3),
                tabTextColor: context.colorTheme.surfaceBright,
                indicatorDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.colorTheme.primary,
                ),
                barDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: context.colorTheme.surface,
                ),
                tabs: [
                  SegmentTab(
                    label: TR.of(context).transaction,
                  ),
                  SegmentTab(
                    label: TR.of(context).withdraw,
                  ),
                  SegmentTab(
                    label: TR.of(context).reword,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 65),
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    AllTransactionTab(),
                    WithdrawTransactionsTab(),
                    RewordLogTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
