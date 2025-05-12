import 'dart:io';
import 'package:delivery_boy/features/chat/view/local/deliveryman_chat_list.dart';
import 'package:delivery_boy/features/support_ticket/view/local/selected_file_sheet.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../controller/deliveryman_chat_ctrl.dart';

class DeliverymanChatDetailsView extends HookConsumerWidget {
  const DeliverymanChatDetailsView({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageData = ref.watch(deliveryManChatMessageCtrlProvider(id));
    final deliveryChatCtrl = useCallback(
        () => ref.read(deliveryManChatMessageCtrlProvider(id).notifier));
    final msgCtrl = useTextEditingController();
    final files = useState<List<File>>([]);

    return messageData.when(
      error: (e, s) => ErrorView(e, s).withSF(),
      loading: () => Loader.list().withSF(),
      data: (msgData) {
        final DeliveryManChat(:loggedInDeliveryman, :deliveryMan, :messages) =
            msgData;
        return Scaffold(
          appBar: KAppBar(
            centerTitle: false,
            leading: SquareButton.backButton(
              onPressed: () => context.pop(),
            ),
            title: Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          HostedImage.provider(msgData.deliveryMan.image),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor:
                            msgData.deliveryMan.isOnlineStatusActive &&
                                    msgData.deliveryMan.isOnline
                                ? context.colorTheme.errorContainer
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const Gap(Insets.med),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(msgData.deliveryMan.firstName),
                    msgData.deliveryMan.isOnlineStatusActive &&
                            msgData.deliveryMan.isOnline
                        ? Text(
                            TR.of(context).online,
                            style: context.textTheme.bodyMedium,
                          )
                        : Text(
                            msgData.deliveryMan.lastOnlineTime.isNotEmpty
                                ? msgData.deliveryMan.lastOnlineTime
                                : TR.of(context).longTimeAgo,
                            style: context.textTheme.bodyMedium,
                          )
                  ],
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 8,
                child: DeliverymanChatList(
                  chat: msgData,
                  img: deliveryMan.image,
                  chatCtrl: deliveryChatCtrl,
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
                                    files.value =
                                        await deliveryChatCtrl().pickFiles();
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
                        deliveryChatCtrl().replyChat(msgCtrl.text, files.value);
                        msgCtrl.clear();
                        files.value = [];
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
