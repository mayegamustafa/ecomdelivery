import 'dart:io';

import 'package:delivery_boy/features/chat/controller/customer_chat_ctrl.dart';
import 'package:delivery_boy/features/chat/view/local/chat_view_appbar.dart';
import 'package:delivery_boy/features/chat/view/local/message_list_view.dart';
import 'package:delivery_boy/features/support_ticket/view/local/selected_file_sheet.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CustomerChatDetailsView extends HookConsumerWidget {
  const CustomerChatDetailsView({super.key, required this.id});

  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(customerMessageCtrlProvider(id));
    final chatCtrl =
        useCallback(() => ref.read(customerMessageCtrlProvider(id).notifier));

    final msgCtrl = useTextEditingController();
    final files = useState<List<File>>([]);
    final selected = useState<List<MessageModel>>([]);

    void addToSelected(MessageModel msg) {
      final contains = selected.value.map((e) => e.id).contains(msg.id);
      if (contains) {
        selected.value = selected.value.where((e) => e.id != msg.id).toList();
      } else {
        selected.value = [...selected.value, msg];
      }
    }

    return messageData.when(
      error: (e, s) => ErrorView(e, s).withSF(),
      loading: () => Loader.list().withSF(),
      data: (msgData) {
        final CustomerChat(:customer, :deliveryMan, :messages) = msgData;

        return Scaffold(
          appBar: ChatViewAppbar(msgData, selectedMSG: selected),
          body: Column(
            children: [
              Expanded(
                flex: 8,
                child: MessageListView(
                  messages: messages,
                  img: deliveryMan.image,
                  chatCtrl: chatCtrl,
                  selected: selected.value,
                  addToSelected: addToSelected,
                ),
              ),
              Container(
                color: context.colorTheme.surface,
                padding: Insets.padAll,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: msgCtrl,
                        decoration: InputDecoration(
                          fillColor:
                              context.colorTheme.surfaceBright.withOpacity(.05),
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
                                    files.value = await chatCtrl().pickFiles();
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
                    InkWell(
                      onTap: () async {
                        chatCtrl().reply(msgCtrl.text, files.value);
                        msgCtrl.clear();
                        files.value = [];
                        selected.value = [];
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: context.isDark
                            ? context.colorTheme.primary
                            : context.colorTheme.surfaceContainerHighest,
                        child: Assets.icon.send.svg(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
