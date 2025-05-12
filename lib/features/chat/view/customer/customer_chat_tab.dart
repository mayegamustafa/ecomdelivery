import 'package:delivery_boy/features/chat/controller/customer_chat_ctrl.dart';
import 'package:delivery_boy/features/chat/view/customer/customer_chat_tile.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class CustomerChatTab extends HookConsumerWidget {
  const CustomerChatTab({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsData = ref.watch(customerChatCtrlProvider);
    final chatCtrl =
        useCallback(() => ref.read(customerChatCtrlProvider.notifier));
    return Column(
      children: [
        SearchField(
          hint: TR.of(context).searchByNameOrEmail,
          onSearch: (query) => chatCtrl().search(query),
          onClear: () => chatCtrl().reload(),
        ),
        const Gap(Insets.lg),
        chatsData.when(
          loading: Loader.list,
          error: (e, s) =>
              ErrorView(e, s, invalidate: customerChatCtrlProvider),
          data: (chats) {
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async => chatCtrl().reload(),
                child: chats.isEmpty
                    ? NoDataFound(topPadding: context.height / 7)
                    : ListView.builder(
                        physics: kDefaultScrollPhysics,
                        itemCount: chats.length,
                        itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: CustomerChatTile(chat: chats[i]),
                        ),
                      ),
              ),
            );
          },
        ),
      ],
    );
  }
}
