import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

class ProductOrder {
  const ProductOrder({
    required this.id,
    required this.uid,
    this.verificationCode,
    required this.type,
    required this.typeFlag,
    required this.orderId,
    required this.quantity,
    required this.walletPayment,
    required this.humanReadableTime,
    required this.dateTime,
    this.customer,
    this.billingAddress,
    required this.totalProduct,
    required this.orderAmount,
    required this.originalAmount,
    required this.totalTax,
    required this.shippingCharge,
    required this.paymentStatus,
    required this.invoiceLogo,
    required this.deliveryStatus,
    this.paymentVia,
    required this.deliveryManFee,
    required this.orderDetails,
    required this.orderStatus,
    required this.discount,
    required this.orderDeliveryInfo,
    required this.shippingInformation,
  });

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      id: map['id']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
      verificationCode: map['verification_code'],
      type: map['type'] ?? '',
      typeFlag: map['type_flag']?.toInt() ?? 0,
      orderId: map['order_id'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      walletPayment: map['wallet_payment'] ?? false,
      humanReadableTime: map['human_readable_time'] ?? '',
      dateTime: map['date_time'] ?? '',
      customer: map['customer_info'] != null
          ? CustomerData.fromMap(map['customer_info'])
          : null,
      billingAddress: _parseBilling(map),
      totalProduct: map['total_product']?.toInt() ?? 0,
      orderAmount: map['order_amount'] ?? 0,
      originalAmount: map['original_amount'] ?? 0,
      totalTax: map['total_taxes'] ?? 0,
      shippingCharge: map['shipping_charge'] ?? 0,
      paymentStatus: map['payment_status'] ?? '',
      invoiceLogo: map['invoice_logo'] ?? '',
      deliveryStatus: map['delevary_status'] ?? '',
      paymentVia: map['payment_via'] ?? '',
      deliveryManFee: map['deliveryManFee'] ?? 0,
      orderDetails: List<OrderDetails>.from(
          map['order_details']?['data'].map((x) => OrderDetails.fromMap(x))),
      orderStatus: List<OrderStatuses>.from(
          map['order_status']?['data'].map((x) => OrderStatuses.fromMap(x))),
      discount: map['discount'] ?? 0,
      orderDeliveryInfo: OrderDeliveryInfo.fromMap(map['order_delivery_info']),
      shippingInformation: map['shipping_info'] is! Map
          ? null
          : ShippingInformation.fromMap(map['shipping_info']),
    );
  }

  final BillingInfo? billingAddress;
  final CustomerData? customer;
  final String dateTime;
  final num deliveryManFee;
  final String deliveryStatus;
  final num discount;
  final String humanReadableTime;
  final int id;
  final String invoiceLogo;
  final num orderAmount;
  final OrderDeliveryInfo orderDeliveryInfo;
  final List<OrderDetails> orderDetails;
  final String orderId;
  final List<OrderStatuses> orderStatus;
  final num originalAmount;
  final String paymentStatus;
  final String? paymentVia;
  final int quantity;
  final num shippingCharge;
  final ShippingInformation? shippingInformation;
  final int totalProduct;
  final num totalTax;
  final String type;
  final int typeFlag;
  final String uid;
  final String? verificationCode;
  final bool walletPayment;

  bool get isDigital => typeFlag == 101;
  bool get isPhysical => typeFlag == 102;
  num get totalAmount => orderAmount + totalTax + discount + shippingCharge;

  bool get isPlaced => deliveryStatus.toLowerCase() == 'placed';
  bool get isConfirmed => deliveryStatus.toLowerCase() == 'confirmed';
  bool get isShipped => deliveryStatus.toLowerCase() == 'shipped';
  bool get isDelivered => deliveryStatus.toLowerCase() == 'delivered';
  bool get isProcessing => deliveryStatus.toLowerCase() == 'processing';
  bool get isPending => deliveryStatus.toLowerCase() == 'pending';
  bool get isCancel => deliveryStatus.toLowerCase() == 'cancel';
  bool get isReturn => deliveryStatus.toLowerCase() == 'return';

  ///Delivery precess finished
  bool get isFinish => isDelivered || isReturn || isCancel;

  Color get statusColor => switch (deliveryStatus.lc) {
        'placed' => Colors.purple,
        'confirmed' => Colors.cyan,
        'shipped' => Colors.amber,
        'delivered' => Colors.green,
        'processing' => Colors.red,
        _ => Colors.red,
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'verification_code': verificationCode,
      'type': type,
      'type_flag': typeFlag,
      'order_id': orderId,
      'quantity': quantity,
      'wallet_payment': walletPayment,
      'human_readable_time': humanReadableTime,
      'date_time': dateTime,
      'customer_info': customer?.toMap(),
      'billing_address': billingAddress?.toMap(),
      'total_product': totalProduct,
      'order_amount': orderAmount,
      'original_amount': originalAmount,
      'total_taxes': totalTax,
      'shipping_charge': shippingCharge,
      'payment_status': paymentStatus,
      'invoice_logo': invoiceLogo,
      'delevary_status': deliveryStatus,
      'payment_via': paymentVia,
      'deliveryManFee': deliveryManFee,
      'order_details': {'data': orderDetails.map((x) => x.toMap()).toList()},
      'order_status': {'data': orderStatus.map((x) => x.toMap()).toList()},
      'discount': discount,
      'order_delivery_info': orderDeliveryInfo.toMap(),
      'shipping_info': shippingInformation?.toMap(),
    };
  }

  static BillingInfo? _parseBilling(dynamic map) {
    final info = map['billing_address'];
    final address = map['new_billing_address'];

    if (address is Map<String, dynamic>) {
      final it = BillingAddress.fromMap(address);
      return BillingInfo.fromAddress(it);
    }
    if (info is Map<String, dynamic>) {
      return BillingInfo.fromMap(info);
    }

    return null;
  }
}
