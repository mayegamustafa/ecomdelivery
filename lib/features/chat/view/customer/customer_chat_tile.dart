import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class CustomerChatTile extends StatelessWidget {
  const CustomerChatTile({
    super.key,
    required this.chat,
  });
  final CustomerData chat;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RoutePaths.chatDetails('${chat.id}')),
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
                            width: context.width / 2.5,
                            child: Text(
                              chat.name,
                              style: context.textTheme.bodyLarge,
                              maxLines: 1,
                            ),
                          ),
                          if (chat.lastMessage != null)
                            Flexible(
                              child: Text(
                                chat.lastMessage!.readableTime,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: context.textTheme.bodyLarge!.textColor(
                                  context.colorTheme.surfaceBright.op7,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (chat.lastMessage != null)
                        Text(
                          chat.lastMessage!.message,
                          style: context.textTheme.bodyLarge!.textColor(
                            context.colorTheme.surfaceBright.op7,
                          ),
                          maxLines: 1,
                        ),
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
