import 'dart:io' as io;

import 'package:delivery_boy/features/support_ticket/controller/ticket_massage_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'local/selected_file_sheet.dart';
import 'local/ticket_chat_bubble.dart';

class TicketChatView extends HookConsumerWidget {
  const TicketChatView(this.id, {super.key});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final massageCtrl = useTextEditingController();
    final massage = ref.watch(ticketMessageCtrlProvider(id));
    final files = useState<List<io.File>>([]);
    final selected = useState<List<TicketMassage>>([]);

    final ticketCtrl =
        useCallback(() => ref.read(ticketMessageCtrlProvider(id).notifier));

    void addToSelected(TicketMassage msg) {
      final contains = selected.value.map((e) => e.id).contains(msg.id);
      if (contains) {
        selected.value = selected.value.where((e) => e.id != msg.id).toList();
      } else {
        selected.value = [...selected.value, msg];
      }
    }

    final refreshCtrl = useMemoized(RefreshController.new);

    return Scaffold(
      appBar: KAppBar(
        centerTitle: selected.value.isEmpty,
        leading: SquareButton.backButton(
          iconData: selected.value.isNotEmpty ? Icons.close : null,
          onPressed: () {
            if (selected.value.isEmpty) return context.pop();
            selected.value = [];
          },
        ),
        title: selected.value.isNotEmpty
            ? Text('${selected.value.length}')
            : massage.maybeWhen(
                orElse: () => const SizedBox.shrink(),
                data: (data) => Text(
                  data.ticket.subject,
                ),
              ),
        actions: [
          if (selected.value.isNotEmpty)
            IconButton(
              style: IconButton.styleFrom(
                foregroundColor: context.colorTheme.onSurface,
              ),
              onPressed: () {
                final msgs = <String>[];
                for (var msg in selected.value) {
                  final date = msg.createdAt.formatDate('dd/MM, hh:mm a');
                  msgs.add(
                      '[$date] ${msg.isAdminReply ? 'Admin' : 'Self'} : ${msg.message}');
                }
                Clipper.copy(msgs.join('\n'));
              },
              icon: const Icon(Icons.copy_rounded),
            ),
        ],
      ),
      body: massage.when(
        error: (error, stackTrace) => ErrorView(error, stackTrace),
        loading: () => Loader.list(),
        data: (ticket) {
          final messages = ticket.massages.reversed.toList();
          return Column(
            children: [
              Expanded(
                flex: 8,
                child: SmartRefresher(
                  controller: refreshCtrl,
                  reverse: true,
                  physics: kDefaultScrollPhysics,
                  onRefresh: () async {
                    await ticketCtrl().reload();
                    refreshCtrl.refreshCompleted();
                  },
                  child: CustomScrollView(
                    reverse: true,
                    physics: kDefaultScrollPhysics,
                    slivers: [
                      SliverGroupedListView<TicketMassage, DateTime>(
                        elements: messages,
                        groupBy: (element) => DateTime(
                          element.createdAt.year,
                          element.createdAt.month,
                          element.createdAt.day,
                          element.createdAt.hour,
                        ),
                        order: GroupedListOrder.DESC,
                        groupComparator: (v1, v2) => v1.compareTo(v2),
                        itemComparator: (e1, e2) =>
                            e1.createdAt.compareTo(e2.createdAt),
                        itemBuilder: (context, message) {
                          final selectedMsg = selected.value
                              .map((e) => e.id)
                              .contains(message.id);
                          return GestureDetector(
                            onLongPress: () {
                              if (selected.value.isEmpty) {
                                addToSelected(message);
                              }
                            },
                            onTap: () {
                              if (selected.value.isNotEmpty) {
                                addToSelected(message);
                              }
                            },
                            child: TicketChatBubble(
                              message: message,
                              ticketId: id,
                              selected: selectedMsg,
                            ),
                          );
                        },
                        groupSeparatorBuilder: (value) => Center(
                          child: DecoratedContainer(
                            margin: Insets.padSym(8, 0),
                            padding: Insets.padSym(8, 12),
                            color: context.colorTheme.surface,
                            borderRadius: 100,
                            child: Text(
                              value.formatDate('dd MMM, yyyy'),
                              style: context.textTheme.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (ticket.ticket.status == TicketStatus.closed)
                DecoratedContainer(
                  width: context.width,
                  padding: const EdgeInsets.all(10),
                  color: context.colorTheme.error,
                  child: Center(
                    child: Text(
                      TR.of(context).ticketClosed,
                      style: TextStyle(color: context.colorTheme.onError),
                    ),
                  ),
                )
              else
                Padding(
                  padding: Insets.padH.copyWith(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: massageCtrl,
                          decoration: InputDecoration(
                            fillColor: context.colorTheme.surfaceBright
                                .withOpacity(.05),
                            suffixIconConstraints: const BoxConstraints(
                              maxWidth: 50,
                              maxHeight: 50,
                            ),
                            suffixIcon: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (files.value.isEmpty) {
                                      files.value =
                                          await ticketCtrl().pickFiles();
                                    } else {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                            top: Corners.lgRadius,
                                          ),
                                        ),
                                        builder: (_) =>
                                            SelectedFilesSheet(files: files),
                                      );
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Badge.count(
                                      count: files.value.length,
                                      isLabelVisible: files.value.isNotEmpty,
                                      offset: const Offset(15, -10),
                                      child: Assets.icon.file.svg(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            hintText: TR.of(context).writeYourMessage,
                          ),
                        ),
                      ),
                      const Gap(Insets.med),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: context.colorTheme.surfaceBright,
                        ),
                        onPressed: () {
                          ticketCtrl()
                              .ticketReply(massageCtrl.text, files.value);
                          massageCtrl.clear();
                          files.value = [];
                          selected.value = [];
                        },
                        icon: Assets.icon.send.svg(),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
