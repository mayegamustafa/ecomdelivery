import 'package:delivery_boy/main.export.dart';

class AssignedOrder {
  final int id;
  final int statusKey;
  final String pickupLocation;
  final String note;
  final String? feedback;
  final double amount;
  final String createdAt;
  final String? details;
  final AssignOrder? assignTo;
  final AssignOrder? assignBy;
  final TimeLine? timeLine;
  final Order order;
  AssignedOrder({
    required this.id,
    required this.statusKey,
    required this.createdAt,
    required this.pickupLocation,
    required this.note,
    this.feedback,
    required this.amount,
    this.details,
    this.assignTo,
    this.assignBy,
    this.timeLine,
    required this.order,
  });

  DeliveryStatus get status {
    return DeliveryStatus.fromCode(statusKey);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt,
      'status': statusKey,
      'note': note,
      'pickup_location': pickupLocation,
      'feedback': feedback,
      'amount': amount,
      'details': details,
      'assign_to': assignTo?.toMap(),
      'assign_by': assignBy?.toMap(),
      'time_line': timeLine?.toMap(),
      'order': order.toMap(),
    };
  }

  factory AssignedOrder.fromMap(Map<String, dynamic> map) {
    return AssignedOrder(
      id: map.parseInt('id'),
      createdAt: map['created_at'] ?? '',
      statusKey: map.parseInt('status'),
      note: map['note'] ?? '',
      pickupLocation: map['pickup_location'] ?? '',
      feedback: map['feedback'],
      amount: map.parseDouble('amount'),
      details: map['details'],
      assignTo: map['assign_to'] != null
          ? AssignOrder.fromMap(map['assign_to'])
          : null,
      assignBy: map['assign_by'] != null
          ? AssignOrder.fromMap(map['assign_by'])
          : null,
      timeLine:
          map['time_line'] != null ? TimeLine.fromMap(map['time_line']) : null,
      order: Order.fromMap(map['order']),
    );
  }
}

class Order {
  final int orderId;
  final String orderNumber;
  Order({
    required this.orderId,
    required this.orderNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'order_number': orderNumber,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      orderId: map['order_id']?.toInt() ?? 0,
      orderNumber: map['order_number'] ?? '',
    );
  }
}
