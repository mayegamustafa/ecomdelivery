import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';

import '../controller/ticket_ctrl.dart';
import 'local/ticket_list_card.dart';

class TicketListView extends HookConsumerWidget {
  const TicketListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketList = ref.watch(ticketListCtrlProvider);
    final ticketListCtrl =
        useCallback(() => ref.read(ticketListCtrlProvider.notifier));
    return Scaffold(
      appBar: KAppBar(
        title: Text(TR.of(context).tickets),
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton.filled(
            onPressed: () => context.push(RoutePaths.createTicket),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ticketList.when(
        error: (error, stackTrace) => ErrorView(error, stackTrace),
        loading: () => Loader.list(),
        data: (ticketList) {
          return Padding(
            padding: Insets.padAll,
            child: Column(
              children: [
                SearchField(
                  hint: TR.of(context).searchByTicketNumber,
                  onSearch: ticketListCtrl().search,
                  onClear: ticketListCtrl().reload,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => ticketListCtrl().reload(),
                    child: ListViewWithFooter(
                      itemCount: ticketList.length,
                      pagination: ticketList.pagination,
                      emptyListWidget: NoDataFound(
                        errorText: TR.of(context).noTicketsFound,
                      ),
                      onNext: (url) => ticketListCtrl().listByUrl(url),
                      onPrevious: (url) => ticketListCtrl().listByUrl(url),
                      itemBuilder: (context, index) => TicketListCard(
                        ticket: ticketList[index],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
