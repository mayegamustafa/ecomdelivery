import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:delivery_boy/features/home/controller/home_ctrl.dart';
import 'package:delivery_boy/features/orders/controller/request_order_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/models/home/assigned_order.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';

class AssignOrderLog extends HookConsumerWidget {
  const AssignOrderLog({super.key});

  static const assignType = ['me', 'others'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = useTabController(initialLength: 2);
    final current = useState(0);

    useEffect(
      () {
        tab.addListener(() {
          current.value = tab.index;
        });
        return null;
      },
      const [],
    );

    return Builder(
      builder: (context) {
        final currentTab = assignType[current.value];
        return Scaffold(
          appBar: KAppBar(
            leading: SquareButton.backButton(
              onPressed: () => context.pop(),
            ),
            title: const Text('Assign By'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: Insets.padH,
                child: SegmentedTabControl(
                  controller: tab,
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
                    for (var tab in assignType)
                      SegmentTab(label: tab.toTitleCase),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: Insets.padH,
            child: Column(
              children: [
                const Gap(Insets.med),
                SearchField(
                  hint: TR.of(context).searchByOrderNumber,
                  onClear: () => ref
                      .read(assignOrderCtrlProvider(currentTab).notifier)
                      .reload(),
                  onSearch: (q) => ref
                      .read(assignOrderCtrlProvider(currentTab).notifier)
                      .filter(search: q),
                  onRangeSearch: (range) => ref
                      .read(assignOrderCtrlProvider(currentTab).notifier)
                      .filter(date: range),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tab,
                    children: [
                      for (var tab in assignType) AssignOrdersView(tab),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AssignOrdersView extends HookConsumerWidget {
  const AssignOrdersView(this.status, {super.key});

  final String status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListData = ref.watch(assignOrderCtrlProvider(status));
    final orderCtrl =
        useCallback(() => ref.read(assignOrderCtrlProvider(status).notifier));
    return RefreshIndicator(
      onRefresh: () async => orderCtrl().reload(),
      child: orderListData.when(
        error: (e, s) => ErrorView(e, s, invalidate: assignOrderCtrlProvider),
        loading: Loader.list,
        data: (orders) {
          return ListViewWithFooter(
            emptyListWidget: const NoDataFound(),
            physics: kDefaultScrollPhysics,
            pagination: orders.pagination,
            itemCount: orders.length,
            onNext: (url) => orderCtrl().listByUrl(url),
            onPrevious: (url) => orderCtrl().listByUrl(url),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: AssignOrderTile(assign: orders[index]),
            ),
          );
        },
      ),
    );
  }
}

class AssignOrderTile extends ConsumerWidget {
  const AssignOrderTile({
    super.key,
    required this.assign,
  });

  final AssignedOrder assign;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeCtrl = ref.watch(localHomeCtrlProvider);
    final assignMe = assign.assignTo?.id == homeCtrl?.deliveryMan.id;

    return GestureDetector(
      onTap: () {
        var assigned = assign.assignTo?.id == homeCtrl?.deliveryMan.id;

        if (assigned && assign.status.isPending) {
          context.push(
            RoutePaths.orderDetails(assign.order.orderNumber),
          );
        } else if (!assigned && assign.status.isRejected) {
          context.push(
            RoutePaths.orderDetails(assign.order.orderNumber),
          );
        } else {
          context.pushQuery(
            RoutePaths.acceptOrder(assign.order.orderNumber),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.medBorder,
          color: context.colorTheme.surface,
        ),
        padding: Insets.padAllContainer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: context.colorTheme.surfaceBright.op(.05),
              child: Assets.icon.arrowDown.svg(
                colorFilter: ColorFilter.mode(
                  context.colorTheme.surfaceBright,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Gap(Insets.med),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              assign.order.orderNumber,
                              style: context.textTheme.bodyLarge,
                              maxLines: 1,
                            ).copyable(),
                            const Gap(Insets.sm),
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: context.colorTheme.surface,
                              child: GestureDetector(
                                onTap: () => Clipper.copy(
                                  assign.order.orderNumber,
                                ),
                                child: Assets.icon.copy.svg(
                                  height: 14,
                                  colorFilter: ColorFilter.mode(
                                    context.colorTheme.errorContainer,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(Insets.sm),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            assign.amount.formate(),
                            style: context.textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: assignMe ? 'Assign By: ' : 'Assign to: '),
                        TextSpan(
                          text: assignMe
                              ? assign.assignBy?.firstName
                              : assign.assignTo?.firstName,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Note: ${assign.note}',
                      ),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: Corners.smBorder,
                          color: assign.status.statusColor.withOpacity(.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          child: Text(
                            assign.status.name.titleCaseSingle,
                            style: TextStyle(color: assign.status.statusColor),
                          ),
                        ),
                      ),
                      const Gap(Insets.sm),
                      GestureDetector(
                        onTap: () => context.push(
                          RoutePaths.deliverymanChatDetails(
                            '${!assignMe ? assign.assignTo?.id : assign.assignBy?.id}',
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: context.colorTheme.primary,
                          child: Assets.icon.chat.svg(
                            height: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const Gap(Insets.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.width / 2,
                        child: Text(
                          'Pickup Location: ${assign.pickupLocation}',
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorTheme.surfaceBright
                                .withOpacity(.7),
                          ),
                        ),
                      ),
                      Text(assign.createdAt)
                    ],
                  ),
                  const Gap(Insets.sm),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
