import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

import '../../controller/ticket_file_downloader.dart';

class TicketChatBubble extends HookConsumerWidget {
  const TicketChatBubble({
    super.key,
    required this.message,
    required this.ticketId,
    required this.selected,
  });

  final TicketMassage message;
  final String ticketId;
  final bool selected;
  final radius = const BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fileDownload = ref.watch(ticketFileDownloaderProvider);
    final fileDownloadCtrl =
        useCallback(() => ref.read(ticketFileDownloaderProvider.notifier));
    return Column(
      crossAxisAlignment: !message.isAdminReply
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          padding: Insets.padH,
          color: context.colorTheme.primary.withOpacity(selected ? .1 : 0),
          child: Row(
            mainAxisAlignment: !message.isAdminReply
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                  margin: Insets.padSym(5, 0),
                  constraints: BoxConstraints(
                    maxWidth: context.width / 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: !message.isAdminReply
                        ? context.colorTheme.primary
                        : context.colorTheme.surface,
                    borderRadius: !message.isAdminReply
                        ? const BorderRadius.all(Radius.circular(12)).copyWith(
                            bottomRight: const Radius.circular(0),
                          )
                        : const BorderRadius.all(Radius.circular(12)).copyWith(
                            topLeft: const Radius.circular(0),
                          ),
                  ),
                  padding: Insets.padSym(10, 15.0),
                  child: TextParser(
                    text: message.message ?? '',
                    style: context.textTheme.bodyLarge!.textColor(
                      !message.isAdminReply
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.surfaceBright,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (message.files.isNotEmpty) ...[
          SizedBox(
            width: context.width / 1.5,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: message.files.length,
              itemBuilder: (context, index) {
                final download = fileDownload
                    .where((f) => f.id == message.files[index].id)
                    .firstOrNull;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.colorTheme.onSurface.withOpacity(.05),
                      borderRadius: radius,
                    ),
                    padding: Insets.padSym(8, 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => fileDownloadCtrl().addToQueue(
                            message.files[index],
                            ticketId,
                            message.id.toString(),
                          ),
                          child: CircleAvatar(
                            backgroundColor: context.colorTheme.primary,
                            child: download == null
                                ? Icon(
                                    Icons.download_rounded,
                                    color: context.colorTheme.onPrimary,
                                  )
                                : (download.progress?.isNegative == true)
                                    ? Icon(
                                        Icons.file_open_rounded,
                                        color: context.colorTheme.onPrimary,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          value: download.progress,
                                          color: context.colorTheme.onPrimary,
                                        ),
                                      ),
                          ),
                        ),
                        const Gap(Insets.med),
                        SizedBox(
                          width: context.width / 5.5,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'File ${index + 1}',
                                  style: context.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '\n${message.files[index].fileName.split('.').last}',
                                ),
                              ],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(Insets.sm),
        ],
        Padding(
          padding: Insets.padH,
          child: Text(
            message.createdAt.formatDate(),
            style: context.textTheme.bodyMedium!.textColor(
              context.colorTheme.surfaceBright.op7,
            ),
          ),
        ),
      ],
    );
  }
}
