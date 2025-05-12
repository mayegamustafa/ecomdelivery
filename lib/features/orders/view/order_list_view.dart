import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:delivery_boy/features/orders/controller/orders_ctrl.dart';
import 'package:delivery_boy/features/orders/controller/request_order_ctrl.dart';
import 'package:delivery_boy/features/settings/controller/settings_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'local/assign_order_log.dart';
import 'local/product_order_card.dart';

class OrderListView extends HookConsumerWidget {
  const OrderListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).order),
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Stack(
          children: [
            Padding(
              padding: Insets.padH,
              child: SegmentedTabControl(
                selectedTabTextColor: context.colorTheme.onPrimary,
                textStyle: context.textTheme.bodyLarge,
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
                    label: TR.of(context).allOrder,
                  ),
                  SegmentTab(
                    label: TR.of(context).assignOrder,
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 65),
              child: TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  AllOrderTabView(),
                  AssignOrderTabView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllOrderTabView extends HookConsumerWidget {
  const AllOrderTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(localSettingsCtrlProvider);

    if (settings == null) {
      return ErrorView(TR.of(context).notFound, null);
    }
    final tabs = [
      null,
      ...settings.config.deliveryStatus.enumData.keys.map((e) => e)
    ];

    return Builder(
      builder: (context) {
        final current = DefaultTabController.of(context).index;
        final currentTab = tabs[current];
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: tabs.length,
                  child: Column(
                    children: [
                      Padding(
                        padding: Insets.padH,
                        child: SearchField(
                          hint: TR.of(context).searchByOrderNumber,
                          onClear: () => ref
                              .read(orderListCtrlProvider(currentTab).notifier)
                              .reload(),
                          onSearch: (q) => ref
                              .read(orderListCtrlProvider(currentTab).notifier)
                              .search(q),
                          onRangeSearch: (range) => ref
                              .read(orderListCtrlProvider(currentTab).notifier)
                              .filterByDate(range),
                        ),
                      ),
                      const Gap(Insets.med),
                      ButtonsTabBar(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 35),
                        buttonMargin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        unselectedLabelStyle: TextStyle(
                          color: context.colorTheme.surfaceContainerHighest,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorTheme.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        unselectedDecoration: BoxDecoration(
                          color: context.colorTheme.onPrimary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          for (var tab in tabs)
                            Tab(text: tab?.toTitleCase ?? 'All'),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: Insets.padH,
                          child: TabBarView(
                            // controller: tab,
                            children: [
                              for (var tab in tabs) _OrdersView(tab),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class AssignOrderTabView extends HookConsumerWidget {
  const AssignOrderTabView({super.key});
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: Insets.padH,
                        child: SearchField(
                          hint: TR.of(context).searchByOrderNumber,
                          onClear: () => ref
                              .read(
                                  assignOrderCtrlProvider(currentTab).notifier)
                              .reload(),
                          onSearch: (q) => ref
                              .read(
                                  assignOrderCtrlProvider(currentTab).notifier)
                              .filter(search: q),
                          onRangeSearch: (range) => ref
                              .read(
                                  assignOrderCtrlProvider(currentTab).notifier)
                              .filter(date: range),
                        ),
                      ),
                      const Gap(Insets.med),
                      ButtonsTabBar(
                        controller: tab,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 35),
                        buttonMargin: Insets.padH.copyWith(bottom: 5),
                        unselectedLabelStyle: TextStyle(
                          color: context.colorTheme.surfaceContainerHighest,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorTheme.primary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        unselectedDecoration: BoxDecoration(
                          color: context.colorTheme.onPrimary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          for (var tab in assignType)
                            Tab(text: tab.toTitleCase),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: Insets.padH,
                          child: TabBarView(
                            controller: tab,
                            children: [
                              for (var tab in assignType) AssignOrdersView(tab),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrdersView extends HookConsumerWidget {
  const _OrdersView(this.status);

  final String? status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListData = ref.watch(orderListCtrlProvider(status));
    final orderCtrl =
        useCallback(() => ref.read(orderListCtrlProvider(status).notifier));
    return RefreshIndicator(
      onRefresh: () async => orderCtrl().reload(),
      child: orderListData.when(
        error: (e, s) => ErrorView(e, s, invalidate: orderListCtrlProvider),
        loading: Loader.list,
        data: (orders) {
          return ListViewWithFooter(
            emptyListWidget: const NoDataFound(),
            physics: kDefaultScrollPhysics,
            pagination: orders.pagination,
            itemCount: orders.length,
            onNext: (url) => orderCtrl().fromUrl(url),
            onPrevious: (url) => orderCtrl().fromUrl(url),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ProductOrderCard(order: orders[index]),
            ),
          );
        },
      ),
    );
  }
}
