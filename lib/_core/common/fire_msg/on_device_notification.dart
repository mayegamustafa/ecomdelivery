import 'package:delivery_boy/main.export.dart';
import 'package:delivery_boy/routes/route_config.dart';
import 'package:delivery_boy/routes/routing.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class OnDeviceNotification {
  static BuildContext? get _context => Get.context;

  static openPage(RemoteMessage message, BuildContext context) {
    final data = FCMPayload.fromRM(message);

    buttonAction(data, context);
  }

  static openPageFromLN(Map<String, dynamic> message) {
    try {
      final data = FCMPayload.fromMap(message);
      if (_context == null) throw Exception('context not found on `openPage`');
      buttonAction(data, _context!);
    } catch (e, s) {
      Logger.ex(e, s);
    }
  }

  static void buttonAction(FCMPayload data, BuildContext context) {
    final type = data.type;

    if (type == null) return;
    type.action(
      onCustomerChat: () {
        if (data.userId != null) {
          context.push(RoutePaths.chatDetails(data.userId!));
        }
      },
      onSelfDeliveryChat: () {
        if (data.deliveryId != null) {
          context.push(RoutePaths.deliverymanChatDetails(data.deliveryId!));
        }
      },
      onOrder: () {
        if (data.orderNumber != null) {
          context.push(RoutePaths.orderDetails(data.orderNumber!));
        }
      },
    );
  }
}
