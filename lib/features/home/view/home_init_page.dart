import 'package:delivery_boy/features/chat/controller/customer_chat_ctrl.dart';
import 'package:delivery_boy/features/chat/controller/deliveryman_chat_ctrl.dart';
import 'package:delivery_boy/features/notification/controller/notification_ctrl.dart';
import 'package:delivery_boy/features/orders/controller/orders_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeInitPage extends HookConsumerWidget {
  const HomeInitPage({required this.child, super.key});

  final Widget child;

  static String route = '';

  bool canShowNF(RemoteMessage message) {
    final data = FCMPayload.fromRM(message);
    final type = data.type;
    if (type == null) return true;

    final id = route.split('/').lastOrNull;
    bool canShow = true;

    type.action(
      onCustomerChat: () {
        if (data.userId == id) canShow = false;
      },
      onSelfDeliveryChat: () {
        if (data.deliveryId == id) canShow = false;
      },
    );
    return canShow;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void refreshDataOnMessage(RemoteMessage message) {
      final data = FCMPayload.fromRM(message);
      final type = data.type;
      if (type == null) return;

      type.action(
        onOrder: () {
          ref.invalidate(orderCtrlProvider);
          ref.invalidate(orderListCtrlProvider);
        },
        onCustomerChat: () {
          ref.invalidate(customerChatCtrlProvider);
          ref.invalidate(customerMessageCtrlProvider);
        },
        onSelfDeliveryChat: () {
          ref.invalidate(deliveryManChatCtrlProvider);
          ref.invalidate(deliveryManChatMessageCtrlProvider);
        },
      );
    }

    Future<void> fcmMSG() async {
      final fcm = FireMessage.instance;
      fcm?.onInitialMessage(
        (msg) => OnDeviceNotification.openPage(msg, context),
      );
      fcm?.onEvents(
        onMessage: (msg) {
          ref.watch(notificationCtrlProvider.notifier).storeNotification(msg);
          refreshDataOnMessage(msg);

          if (canShowNF(msg)) LNService.displayRM(msg);
        },
        onMessageOpenedApp: (msg) =>
            OnDeviceNotification.openPage(msg, context),
      );
    }

    useEffect(
      () {
        fcmMSG();
        return null;
      },
      const [],
    );

    return child;
  }
}
