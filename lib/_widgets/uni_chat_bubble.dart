import 'package:delivery_boy/features/chat/controller/chat_file_downloader.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class UniChatBubble extends StatelessWidget {
  const UniChatBubble({
    super.key,
    required this.img,
    required this.message,
    required this.time,
    required this.isMine,
    required this.isSeen,
    this.selected = false,
    required this.files,
  });

  final String img, time, message;
  final bool isMine, isSeen, selected;
  final List<({String name, String url})> files;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: Insets.padH,
          color: context.colorTheme.primary.withOpacity(selected ? .1 : 0),
          child: Row(
            mainAxisAlignment:
                isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMine)
                CircleAvatar(
                  backgroundImage: HostedImage.provider(img),
                ),
              const Gap(Insets.sm),
              Flexible(
                child: Container(
                  margin: Insets.padSym(5, 0),
                  constraints: BoxConstraints(
                    maxWidth: context.width / 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: isMine
                        ? context.colorTheme.primary
                        : context.colorTheme.surface,
                    borderRadius: isMine
                        ? const BorderRadius.all(Radius.circular(12)).copyWith(
                            bottomRight: const Radius.circular(0),
                          )
                        : const BorderRadius.all(Radius.circular(12)).copyWith(
                            topLeft: const Radius.circular(0),
                          ),
                  ),
                  padding: Insets.padSym(10, 15.0),
                  child: TextParser(
                    text: message,
                    style: context.textTheme.bodyLarge!.textColor(
                      isMine
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.surfaceBright,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (files.isNotEmpty) ...[
          Padding(
            padding: Insets.padH,
            child: _ChatFiles(files: files),
          ),
        ],
        Padding(
          padding: Insets.padH,
          child: Row(
            mainAxisAlignment:
                isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                time,
                style: context.textTheme.bodyMedium!.textColor(
                  context.colorTheme.surfaceBright.op7,
                ),
              ),
              const Gap(Insets.sm),
              if (isMine && isSeen)
                Icon(
                  Icons.done_all,
                  size: 15,
                  color: context.colorTheme.errorContainer,
                ),
              if (isMine && !isSeen)
                Icon(
                  Icons.done,
                  size: 15,
                  color: context.colorTheme.errorContainer,
                ),
            ],
          ),
        ),
        const Gap(Insets.sm),
      ],
    );
  }
}

class _ChatFiles extends HookConsumerWidget {
  const _ChatFiles({
    required this.files,
  });

  final List<({String name, String url})> files;

  final radius = const BorderRadius.all(Radius.circular(12));
  @override
  Widget build(BuildContext context, ref) {
    final downloadQueue = ref.watch(chatFileDownloaderProvider);
    final downloader =
        useCallback(() => ref.read(chatFileDownloaderProvider.notifier));

    return SizedBox(
      width: context.width / 1.5,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: files.length,
        itemBuilder: (context, index) {
          final download =
              downloadQueue.where((f) => f.url == files[index].url).firstOrNull;

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
                    onTap: () => downloader().addToQueue(files[index]),
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
                            text: '\n${files[index].name.split('.').last}',
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
    );
  }
}
