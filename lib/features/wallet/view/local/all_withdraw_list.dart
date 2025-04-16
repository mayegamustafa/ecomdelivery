import 'package:delivery_boy/features/wallet/controller/wallet_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class AllWithdrawTable extends StatelessWidget {
  const AllWithdrawTable({
    super.key,
    required this.searchCtrl,
    required this.withdrawCtrl,
    required this.withdrawList,
  });

  final TextEditingController searchCtrl;
  final WithDrawListCtrl Function() withdrawCtrl;
  final AsyncValue<PagedItem<WithdrawData>> withdrawList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Insets.padH,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              TR.of(context).withdrawList,
              style: context.textTheme.titleLarge,
            ),
          ),
        ),
        const Gap(Insets.lg),
        Padding(
          padding: Insets.padH,
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  searchCtrl.clear();
                  withdrawCtrl().reload();
                },
                icon: const Icon(Icons.clear),
              ),
              hintText: TR.of(context).searchByTrx,
              border: const OutlineInputBorder(),
            ),
            onChanged: (value) => withdrawCtrl().search(value),
          ),
        ),
        const Gap(Insets.sm),
        Padding(
          padding: Insets.padH,
          child: Container(
            decoration: BoxDecoration(
              color: context.colorTheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        TR.of(context).date,
                        style: context.textTheme.labelMedium!.copyWith(
                          color: context.colorTheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Text(
                        TR.of(context).transactionId,
                        style: context.textTheme.labelMedium!.copyWith(
                          color: context.colorTheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      TR.of(context).receivable,
                      style: context.textTheme.labelMedium!.copyWith(
                        color: context.colorTheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(Insets.sm),
        withdrawList.when(
          loading: Loader.list,
          error: ErrorView.new,
          data: (data) => ListViewWithFooter(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            pagination: data.pagination,
            onNext: (url) => withdrawCtrl().listByUrl(url),
            onPrevious: (url) => withdrawCtrl().listByUrl(url),
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].readableTime,
                                style: context.textTheme.labelMedium,
                              ),
                              Text(
                                data[index].date,
                                style: context.textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: SelectableText(
                              data[index].trxNo,
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              data[index]
                                  .finalAmount
                                  .formate(currency: data[index].currency),
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 20,
                      color: context.colorTheme.primary,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  TR.of(context).method,
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(Insets.sm),
                                Text(
                                  data[index].method.name,
                                  style: context.textTheme.labelMedium,
                                )
                              ],
                            ),
                            const Gap(Insets.sm),
                            Row(
                              children: [
                                Text(
                                  TR.of(context).amount,
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(Insets.sm),
                                Text(
                                  data[index].amount.formate(useBase: true),
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    color: context.colorTheme.errorContainer,
                                  ),
                                )
                              ],
                            ),
                            const Gap(Insets.sm),
                            Row(
                              children: [
                                Text(
                                  TR.of(context).charge,
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(Insets.sm),
                                Text(
                                  data[index].charge.formate(useBase: true),
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    color: context.colorTheme.error,
                                  ),
                                )
                              ],
                            ),
                            const Gap(Insets.sm),
                            Row(
                              children: [
                                Text(
                                  TR.of(context).status,
                                  style:
                                      context.textTheme.labelMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Gap(Insets.sm),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        data[index].statusColor.withOpacity(.1),
                                    borderRadius: Corners.smBorder,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5),
                                    child: Text(
                                      data[index].status,
                                      style: context.textTheme.labelMedium!
                                          .copyWith(
                                        color: data[index].statusColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Gap(Insets.sm),
                            if (data[index].feedback.isNotEmpty)
                              Row(
                                children: [
                                  Text(
                                    TR.of(context).note,
                                    style:
                                        context.textTheme.labelMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(Insets.sm),
                                  Text(
                                    data[index].feedback,
                                    style:
                                        context.textTheme.labelMedium!.copyWith(
                                      color: context.colorTheme.error,
                                    ),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
