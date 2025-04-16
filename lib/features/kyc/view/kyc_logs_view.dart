import 'package:delivery_boy/features/kyc/controller/kyc_ctrl.dart';
import 'package:delivery_boy/features/kyc/view/kyc_view.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class KYCLogsView extends ConsumerWidget {
  const KYCLogsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsData = ref.watch(kycLogsProvider);
    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).kycLogs),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(kycLogsProvider);
        },
        child: logsData.when(
          loading: Loader.list,
          error: ErrorView.new,
          data: (logs) {
            return logs.isEmpty
                ? Center(
                    child: Column(
                      children: [
                        Gap(context.height / 4.5),
                        Assets.svg.noData.svg(),
                        const Gap(Insets.lg),
                        Text(
                          TR.of(context).noDataFound,
                          style: context.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: logs.length,
                    padding: Insets.padAll,
                    separatorBuilder: (_, __) => const Gap(Insets.med),
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.medBorder,
                          color: context.colorTheme.surface,
                        ),
                        child: ListTile(
                          onTap: () {
                            context.nPush(KYCView(log));
                          },
                          title: Text(log.readableTime),
                          subtitle: Text(log.date),
                          trailing: DecoratedContainer(
                            color: log.statusConfig.$2.withOpacity(.1),
                            padding: Insets.padSym(3, 8),
                            borderRadius: Corners.med,
                            child: Text(
                              log.statusConfig.$1,
                              style: context.textTheme.titleMedium
                                  ?.textColor(log.statusConfig.$2),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
