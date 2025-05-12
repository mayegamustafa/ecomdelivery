import 'package:automatic_animated_list/automatic_animated_list.dart';
import 'package:delivery_boy/features/notification/controller/notification_ctrl.dart';
import 'package:delivery_boy/features/notification/view/notification_card.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_name.dart';
import 'package:flutter/material.dart';

class NotificationView extends HookConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationCtrlProvider);
    final notificationCtrl =
        useCallback(() => ref.read(notificationCtrlProvider.notifier));

    return Scaffold(
      appBar: KAppBar(
        leading: SquareButton.backButton(
          onPressed: () => context.pop(),
        ),
        title: Text(TR.of(context).notifications),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return _NotificationDismissDialog(
                    title: TR.of(context).deleteAllNotifications,
                    body: TR
                        .of(context)
                        .areYouSureYouWantToDeleteAllNotificationsThis,
                    onSubmit: () => notificationCtrl().clearNotifications(),
                  );
                },
              );
            },
            icon: Icon(Icons.delete_sweep_rounded,
                color: context.colorTheme.error),
          ),
        ],
      ),
      body: Padding(
        padding: Insets.padAll,
        child: Column(
          children: [
            if (notifications.isEmpty)
              Center(
                child: NoDataFound(
                  topPadding: context.height / 5,
                ),
              )
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => notificationCtrl().reload(),
                  child: AutomaticAnimatedList<FCMPayload>(
                    physics: kDefaultScrollPhysics,
                    items: notifications,
                    keyingFunction: (n) => Key('${n.id}'),
                    itemBuilder: (context, notification, ani) {
                      return FadeTransition(
                        key: Key('${notification.id}'),
                        opacity: ani,
                        child: SizeTransition(
                          sizeFactor: CurvedAnimation(
                            parent: ani,
                            curve: Curves.easeOut,
                            reverseCurve: Curves.easeIn,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: NotificationCard(
                              notification: notification,
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return _NotificationDismissDialog(
                                      title:
                                          TR.of(context).deleteThisNotification,
                                      body: TR
                                          .of(context)
                                          .areYouSureYouWantToDeleteThisNotification,
                                      onSubmit: () => notificationCtrl()
                                          .deleteMessage(notification),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _NotificationDismissDialog extends StatelessWidget {
  const _NotificationDismissDialog({
    required this.title,
    required this.body,
    required this.onSubmit,
  });

  final String title;
  final String body;
  final void Function()? onSubmit;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Padding(
        padding: Insets.padSym(10, 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              body,
              style: context.textTheme.bodyLarge,
            ),
            const Gap(Insets.offset),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.nPop(),
                    child: Text(TR.of(context).no),
                  ),
                ),
                const Gap(Insets.sm),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      onSubmit?.call();
                      context.nPop();
                    },
                    child: Text(TR.of(context).ok),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
