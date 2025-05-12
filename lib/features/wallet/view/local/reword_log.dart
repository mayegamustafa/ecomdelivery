import 'package:collection/collection.dart';
import 'package:delivery_boy/features/wallet/view/local/reword_details.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../redeem_points/controller/redeem_points_ctrl.dart';

class RewordLogTab extends HookConsumerWidget {
  const RewordLogTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rewordCtrl = ref.watch(redeemPointsCtrlProvider);
    final rewardCtrl =
        useCallback(() => ref.read(redeemPointsCtrlProvider.notifier));
    final srcCtrl = useTextEditingController();

    return rewordCtrl.when(
      loading: Loader.list,
      error: (e, s) => ErrorView(e, s, invalidate: redeemPointsCtrlProvider),
      data: (data) {
        return Column(
          children: [
            TextField(
              onTap: () async {
                final date = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now().add(30.days),
                );

                if (date == null) return;

                srcCtrl.text =
                    '${date.start.formatDate()} - ${date.end.formatDate()}';

                await rewardCtrl().filter(range: date);
              },
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: srcCtrl,
              readOnly: true,
              decoration: InputDecoration(
                hintText: TR.of(context).filterByDate,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Assets.icon.search.svg(),
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FieldClearButton(
                      ctrl: srcCtrl,
                      onClear: () => rewardCtrl().reload(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListViewWithFooter(
                emptyListWidget: const NoDataFound(),
                itemCount: data.listData.length,
                pagination: data.pagination,
                onNext: (url) => rewardCtrl().listByUrl(url),
                onPrevious: (url) => rewardCtrl().listByUrl(url),
                itemBuilder: (context, index) {
                  final reword = data.listData[index];
                  return GestureDetector(
                    onTap: () {
                      final tapped = data.listData
                          .firstWhereOrNull((e) => e.id == reword.id);
                      if (tapped == null) return;
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (context) => RewordDetails(rewardData: tapped),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      padding: Insets.padAllContainer,
                      decoration: BoxDecoration(
                        color: context.colorTheme.surface,
                        borderRadius: Corners.medBorder,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: context.colorTheme.surfaceBright
                                .withOpacity(.1),
                            child: Assets.icon.arrowDown.svg(
                              colorFilter: ColorFilter.mode(
                                context.colorTheme.surfaceBright,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const Gap(Insets.med),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${TR.of(context).point}: ${reword.point}',
                                      style: context.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      reword.humanReadableTime,
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                        color: context.colorTheme.surfaceBright
                                            .withOpacity(.7),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  reword.details,
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: context.colorTheme.surfaceBright
                                        .withOpacity(.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
