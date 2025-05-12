import 'package:delivery_boy/main.export.dart';

class OrderDetails {
  const OrderDetails({
    required this.id,
    required this.uid,
    required this.productName,
    required this.productImage,
    required this.quantity,
    // required this.itemPrice,
    required this.totalPrice,
    required this.attribute,
    required this.digitalAttribute,
    required this.status,
    required this.originalTotalPrice,
    required this.totalTax,
    required this.discount,
  });

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      id: map.parseInt('id'),
      uid: map['uid'] ?? '',
      productName: map['product_name'] ?? '',
      productImage: map['product_image'] ?? '',
      quantity: map.parseInt('quantity'),
      // itemPrice: map.parseNum('item_price'),
      totalPrice: map.parseNum('total_price'),
      originalTotalPrice: map.parseNum('original_total_price'),
      totalTax: map.parseNum('total_taxes'),
      discount: map.parseNum('discount'),
      attribute: map['attribute'] ?? '',
      digitalAttribute: map['digital_attribute'] ?? '',
      status: map['status'] ?? '',
    );
  }

  final String attribute;
  final String digitalAttribute;
  final num discount;
  final int id;
  final num originalTotalPrice;
  final String productImage;
  final String productName;
  final int quantity;
  final String status;
  final num totalTax;
  final String uid;

  // final num itemPrice;
  final num totalPrice;

  num get itemPrice => totalPrice / quantity;

  Map<String, dynamic> toMap() {
    final result = {
      'id': id,
      'uid': uid,
      'product_name': productName,
      'product_image': productImage,
      'quantity': quantity,
      // 'item_price': itemPrice,
      'total_price': totalPrice,
      'original_total_price': originalTotalPrice,
      'total_taxes': totalTax,
      'discount': discount,
      'attribute': attribute,
      'digital_attribute': digitalAttribute,
      'status': status,
    };

    return result;
  }
}

class OrderStatuses {
  OrderStatuses({
    required this.id,
    required this.uid,
    required this.paymentStatus,
    required this.paymentNote,
    required this.deliveryStatus,
    required this.deliveryNote,
    required this.deliveryStatusKey,
    required this.createdAt,
  });

  factory OrderStatuses.def(String status, String date) {
    return OrderStatuses(
      id: 0,
      uid: '',
      paymentStatus: '',
      paymentNote: '',
      deliveryStatus: status.toTitleCase,
      deliveryStatusKey: status,
      deliveryNote: '',
      createdAt: date,
    );
  }

  factory OrderStatuses.fromMap(Map<String, dynamic> map) {
    return OrderStatuses(
      id: map.parseInt('id'),
      uid: map['uid'] ?? '',
      paymentStatus: map['payment_status'] ?? '',
      paymentNote: map['payment_note'] ?? '',
      deliveryStatus: map['delivery_status'] ?? '',
      deliveryStatusKey: map['delivery_status_key'] ?? '',
      deliveryNote: map['delivery_note'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  final String createdAt;
  final String deliveryNote;
  final String deliveryStatus;
  final String deliveryStatusKey;
  final int id;
  final String paymentNote;
  final String paymentStatus;
  final String uid;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'payment_status': paymentStatus});
    result.addAll({'payment_note': paymentNote});
    result.addAll({'delivery_status': deliveryStatus});
    result.addAll({'delivery_status_key': deliveryStatusKey});
    result.addAll({'delivery_note': deliveryNote});
    result.addAll({'created_at': createdAt});

    return result;
  }

  bool get isPlaced => deliveryStatusKey == 'placed';
  bool get isConfirmed => deliveryStatusKey == 'confirmed';
  bool get isShipped => deliveryStatusKey == 'shipped';
  bool get isDelivered => deliveryStatusKey == 'delivered';
  bool get isProcessing => deliveryStatusKey == 'processing';
}
