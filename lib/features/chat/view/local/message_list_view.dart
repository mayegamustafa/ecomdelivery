import 'package:delivery_boy/features/chat/controller/customer_chat_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageListView extends HookConsumerWidget {
  const MessageListView({
    super.key,
    required this.messages,
    required this.chatCtrl,
    required this.img,
    required this.selected,
    required this.addToSelected,
  });

  final PagedItem<MessageModel> messages;
  final CustomerMessageCtrl Function() chatCtrl;
  final String img;
  final List<MessageModel> selected;
  final Function(MessageModel msg) addToSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refreshCtrl = useMemoized(RefreshController.new);

    return SmartRefresher(
      controller: refreshCtrl,
      enablePullUp: true,
      reverse: true,
      physics: kDefaultScrollPhysics,
      onRefresh: () async {
        await chatCtrl().reload();
        refreshCtrl.refreshCompleted();
      },
      onLoading: () async {
        final load = await chatCtrl().loadMore();
        if (load case LoadStatus.failed) {
          refreshCtrl.loadFailed();
        }
        if (load case LoadStatus.noMore) {
          refreshCtrl.loadNoData();
        }
        await Future.delayed(1.seconds);
        refreshCtrl.loadComplete();
      },
      child: CustomScrollView(
        reverse: true,
        physics: kDefaultScrollPhysics,
        slivers: [
          SliverGroupedListView<MessageModel, DateTime>(
            elements: messages.listData,
            groupBy: (e) => DateTime(
              e.dateTime.year,
              e.dateTime.month,
              e.dateTime.day,
              e.dateTime.hour,
            ),
            order: GroupedListOrder.DESC,
            groupComparator: (v1, v2) => v1.compareTo(v2),
            itemComparator: (e1, e2) => e1.dateTime.compareTo(e2.dateTime),
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
            itemBuilder: (context, msg) {
              final selectedMsg = selected.map((e) => e.id).contains(msg.id);
              return GestureDetector(
                onLongPress: () {
                  if (selected.isEmpty) addToSelected(msg);
                },
                onTap: () {
                  if (selected.isNotEmpty) addToSelected(msg);
                },
                child: UniChatBubble(
                  img: img,
                  message: msg.message,
                  selected: selectedMsg,
                  isMine: msg.isMine,
                  isSeen: msg.isSeen,
                  files: msg.files,
                  time: msg.readableTime,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
