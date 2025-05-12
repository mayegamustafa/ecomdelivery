import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../../controller/deliveryman_chat_ctrl.dart';

class DeliveryChatTab extends HookConsumerWidget {
  const DeliveryChatTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryManChatData = ref.watch(deliveryManChatCtrlProvider);
    final deliveryChatCtrl =
        useCallback(() => ref.read(deliveryManChatCtrlProvider.notifier));
    return deliveryManChatData.when(
      loading: Loader.list,
      error: (e, s) => ErrorView(e, s, invalidate: deliveryManChatCtrlProvider),
      data: (chats) => Column(
        children: [
          SearchField(
            hint: TR.of(context).searchByNameOrEmail,
            onClear: () => deliveryChatCtrl().reload(),
            onSearch: (query) => deliveryChatCtrl().search(query),
          ),
          const Gap(Insets.lg),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => deliveryChatCtrl().reload(),
              child: chats.isEmpty
                  ? NoDataFound(topPadding: context.height / 7)
                  : ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: DeliveryManChatTile(chat: chats[index]),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryManChatTile extends StatelessWidget {
  const DeliveryManChatTile({
    super.key,
    required this.chat,
  });
  final DeliveryMan chat;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push(RoutePaths.deliverymanChatDetails('${chat.id}')),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: Corners.medBorder,
              color: context.colorTheme.surface,
            ),
            padding: Insets.padAllContainer,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: context.colorTheme.primary,
                      backgroundImage: HostedImage.provider(chat.image),
                    ),
                    Positioned(
                      bottom: 2,
                      right: -5,
                      child: CircleAvatar(
                        radius: 10,
                        child: CircleAvatar(
                          backgroundColor:
                              chat.isOnlineStatusActive && chat.isOnline
                                  ? context.colorTheme.errorContainer
                                  : context.colorTheme.surfaceBright.op5,
                          radius: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.med),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.width / 2.2,
                            child: Text(
                              chat.fullName,
                              style: context.textTheme.bodyLarge,
                              maxLines: 1,
                            ),
                          ),
                          if (chat.message != null)
                            Text(
                              chat.message!.createdAt.formatDate('HH:mm a'),
                              style: context.textTheme.bodyLarge!.textColor(
                                context.colorTheme.surfaceBright.op7,
                              ),
                            ),
                        ],
                      ),
                      if (chat.message != null) ...[
                        Text(
                          chat.message!.message,
                          style: context.textTheme.bodyLarge!.textColor(
                            context.colorTheme.surfaceBright.op7,
                          ),
                          maxLines: 1,
                        ),
                        const Gap(Insets.med),
                      ],
                      if (chat.lastLoginTime.isNotEmpty)
                        Text(chat.lastLoginTime),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
