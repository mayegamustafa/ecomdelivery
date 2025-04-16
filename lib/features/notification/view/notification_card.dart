import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onDelete,
  });
  final FCMPayload notification;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        OnDeviceNotification.buttonAction(notification, context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Corners.lgBorder,
          color: context.colorTheme.surface,
        ),
        padding: Insets.padAllContainer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(0x80FFE6BC),
              child: Assets.icon.orderBox.svg(),
            ),
            const Gap(Insets.med),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.receivedAt.formatDate(),
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: context.colorTheme.surfaceBright
                                .withOpacity(.5),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onDelete,
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.clear_rounded, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const Gap(Insets.sm),
                  Text(
                    notification.title,
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    notification.body,
                    maxLines: 3,
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: context.colorTheme.surfaceBright.withOpacity(.7),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
