import 'package:delivery_boy/features/chat/controller/deliveryman_chat_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DeliverymanChatList extends HookConsumerWidget {
  const DeliverymanChatList({
    super.key,
    required this.chat,
    required this.chatCtrl,
    required this.img,
  });

  final DeliveryManChat chat;
  final DeliveryManChatMessageCtrl Function() chatCtrl;
  final String img;

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
        await chatCtrl().loadMore();
        refreshCtrl.loadComplete();
      },
      child: CustomScrollView(
        reverse: true,
        physics: kDefaultScrollPhysics,
        slivers: [
          SliverGroupedListView<DeliveryMessage, DateTime>(
            elements: chat.messages.listData,
            groupBy: (e) => DateTime(
              e.createdAt.year,
              e.createdAt.month,
              e.createdAt.day,
              e.createdAt.hour,
            ),
            order: GroupedListOrder.DESC,
            groupComparator: (v1, v2) => v1.compareTo(v2),
            itemComparator: (e1, e2) => e1.createdAt.compareTo(e2.createdAt),
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
              return GestureDetector(
                child: UniChatBubble(
                  img: img,
                  message: msg.message,
                  isMine: msg.isMe(chat.loggedInDeliveryman.id),
                  isSeen: msg.isSeen,
                  time: msg.createdAt.formatDate('hh:mm a'),
                  selected: false,
                  files: msg.files,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
