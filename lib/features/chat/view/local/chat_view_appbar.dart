import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:flutter/material.dart';

class ChatViewAppbar extends HookConsumerWidget implements PreferredSizeWidget {
  const ChatViewAppbar(
    this.msgData, {
    super.key,
    required this.selectedMSG,
    this.onClear,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final CustomerChat msgData;
  final ValueNotifier<List<MessageModel>> selectedMSG;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
      valueListenable: selectedMSG,
      builder: (context, selected, _) {
        return KAppBar(
          centerTitle: selected.isEmpty,
          leading: SquareButton.backButton(
            iconData: selected.isNotEmpty ? Icons.close : null,
            onPressed: () {
              if (selected.isEmpty) return context.pop();
              selectedMSG.value = [];
            },
          ),
          actions: [
            if (selected.isNotEmpty)
              IconButton(
                style: IconButton.styleFrom(
                  foregroundColor: context.colorTheme.onSurface,
                ),
                onPressed: () {
                  final msgs = <String>[];
                  for (var msg in selected) {
                    final date = msg.dateTime.formatDate('dd/MM, hh:mm a');
                    msgs.add('[$date] ${msg.userName} : ${msg.message}');
                  }
                  Clipper.copy(msgs.join('\n'));
                },
                icon: const Icon(Icons.copy_rounded),
              ),
          ],
          title: selected.isNotEmpty
              ? Text('${selected.length}')
              : Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: context.colorTheme.primary,
                          backgroundImage:
                              HostedImage.provider(msgData.customer.image),
                        ),
                      ],
                    ),
                    const Gap(Insets.med),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msgData.customer.name,
                          style: context.textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}
