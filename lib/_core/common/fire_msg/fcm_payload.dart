import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

enum NotificationType {
  order,
  deliveryChat,
  selfDeliveryChat,
  customerChat,
  sellerChat,
  productUpdate;

  static NotificationType? fromValue(String? value) {
    return switch (value) {
      'order' => order,
      'deliveryman_chat' || 'deliveryChat' => deliveryChat,
      'self_deliveryman_chat' || 'selfDeliveryChat' => selfDeliveryChat,
      'customer_chat' || 'customerChat' => customerChat,
      'seller_chat' || 'sellerChat' => sellerChat,
      'product_update' || 'productUpdate' => productUpdate,
      _ => null,
    };
  }

  String get btnLabel => switch (this) {
        order => 'Open Order',
        deliveryChat => 'Reply',
        customerChat => 'Reply',
        sellerChat => 'Reply',
        productUpdate => 'Show Product',
        selfDeliveryChat => 'Reply',
      };

  void action({
    VoidCallback? onOrder,
    VoidCallback? onDeliveryChat,
    VoidCallback? onCustomerChat,
    VoidCallback? onSellerChat,
    VoidCallback? onProductUpdate,
    VoidCallback? onSelfDeliveryChat,
  }) {
    switch (this) {
      case NotificationType.order:
        onOrder?.call();
        break;
      case NotificationType.deliveryChat:
        onDeliveryChat?.call();
        break;
      case NotificationType.customerChat:
        onCustomerChat?.call();
        break;
      case NotificationType.sellerChat:
        onSellerChat?.call();
        break;
      case NotificationType.productUpdate:
        onProductUpdate?.call();
        break;
      case NotificationType.selfDeliveryChat:
        onSelfDeliveryChat?.call();
        break;
    }
  }
}

class FCMPayload {
  const FCMPayload({
    required this.title,
    required this.body,
    required this.image,
    required this.deliveryId,
    required this.sellerId,
    required this.userId,
    required this.orderNumber,
    required this.orderUid,
    required this.orderId,
    required this.productUid,
    required this.type,
    required this.receivedAt,
    required this.id,
  });

  final int id;
  final DateTime receivedAt;
  final String body;
  final String? deliveryId;
  final String? image;
  final String? orderId;
  final String? orderNumber;
  final String? orderUid;
  final String? productUid;
  final String? sellerId;
  final String title;
  final NotificationType? type;
  final String? userId;

  factory FCMPayload.fromRM(RemoteMessage message) {
    final map = message.data;
    final notification = message.notification;
    return FCMPayload(
      id: message.messageId?.hashCode ?? DateTime.now().millisecondsSinceEpoch,
      receivedAt: message.sentTime ?? DateTime.now(),
      title: map['title'] ?? notification?.title ?? '',
      body: map['body'] ?? notification?.body ?? '',
      image: map['image'],
      deliveryId: map['deliveryman_id'],
      sellerId: map['seller_id'],
      userId: map['user_id'],
      orderNumber: map['order_number'],
      orderUid: map['order_uid'],
      orderId: map['order_id'],
      productUid: map['product_uid'],
      type: NotificationType.fromValue(map['type']),
    );
  }
  factory FCMPayload.fromMap(Map<String, dynamic> map) {
    return FCMPayload(
      id: map['id'] ?? DateTime.now().millisecondsSinceEpoch,
      receivedAt: switch (map) {
        {'received_at': String x} => DateTime.parse(x),
        _ => DateTime.now(),
      },
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      image: map['image'],
      deliveryId: map['deliveryman_id'],
      sellerId: map['seller_id'],
      userId: map['user_id'],
      orderNumber: map['order_number'],
      orderUid: map['order_uid'],
      orderId: map['order_id'],
      productUid: map['product_uid'],
      type: NotificationType.fromValue(map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'image': image,
      'deliveryman_id': deliveryId,
      'seller_id': sellerId,
      'user_id': userId,
      'order_number': orderNumber,
      'order_uid': orderUid,
      'order_id': orderId,
      'product_uid': productUid,
      'type': type?.name,
      'id': id,
      'received_at': receivedAt.toIso8601String(),
    };
  }
}
