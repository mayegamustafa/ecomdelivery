import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';

enum DeliveryStatus {
  pending(0),
  accepted(1),
  rejected(2),
  delivered(3),
  productReturn(4);

  bool get isPending => this == DeliveryStatus.pending;
  bool get isAccepted => this == DeliveryStatus.accepted;
  bool get isRejected => this == DeliveryStatus.rejected;
  bool get isDelivered => this == DeliveryStatus.delivered;
  bool get isProductReturn => this == DeliveryStatus.productReturn;

  bool get isFinis => (isDelivered || isProductReturn || isRejected);

  Color get statusColor => switch (this) {
        DeliveryStatus.pending => Colors.purple,
        DeliveryStatus.accepted => Colors.cyan,
        DeliveryStatus.rejected => Colors.red,
        DeliveryStatus.delivered => Colors.green,
        DeliveryStatus.productReturn => Colors.blue,
      };
  String get statusName => switch (this) {
        DeliveryStatus.pending => 'Pending',
        DeliveryStatus.accepted => 'Accepted',
        DeliveryStatus.rejected => 'Rejected',
        DeliveryStatus.delivered => 'Delivered',
        DeliveryStatus.productReturn => 'Returned',
      };

  const DeliveryStatus(this.code);
  final int code;
  factory DeliveryStatus.fromCode(int code) {
    return values.firstWhere((e) => e.code == code);
  }
}

class OrderDeliveryInfo {
  OrderDeliveryInfo({
    required this.id,
    required this.statusCode,
    required this.pickupLocation,
    required this.note,
    required this.createdAt,
    this.feedback,
    required this.amount,
    this.details,
    this.assignTo,
    this.assignBy,
    this.timeLine,
  });

  factory OrderDeliveryInfo.fromMap(Map<String, dynamic> map) {
    return OrderDeliveryInfo(
      id: map.parseInt('id'),
      statusCode: map.parseInt('status'),
      pickupLocation: map['pickup_location'] ?? '',
      createdAt: map['created_at'] ?? '',
      note: map['note'] ?? '',
      feedback: map['feedback'],
      amount: map.parseNum('amount'),
      details: map['details'],
      assignTo: map['assign_to'] != null
          ? AssignOrder.fromMap(map['assign_to'])
          : null,
      assignBy: map['assign_by'] != null
          ? AssignOrder.fromMap(map['assign_by'])
          : null,
      timeLine:
          map['time_line'] != null ? TimeLine.fromMap(map['time_line']) : null,
    );
  }

  final num amount;
  final AssignOrder? assignTo;
  final AssignOrder? assignBy;
  final String? details;
  final String? feedback;
  final int id;
  final String createdAt;
  final String note;
  final String pickupLocation;
  final int statusCode;
  final TimeLine? timeLine;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': statusCode,
      'note': note,
      'created_at': createdAt,
      'pickup_location': pickupLocation,
      'feedback': feedback,
      'amount': amount,
      'details': details,
      'assignTo': assignTo?.toMap(),
      'assign_by': assignBy?.toMap(),
      'time_line': timeLine?.toMap(),
    };
  }

  DeliveryStatus get status {
    return DeliveryStatus.fromCode(statusCode);
  }
}

class AssignOrder {
  AssignOrder({
    required this.id,
    required this.fcmToken,
    required this.firstName,
    required this.registeredAt,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.phoneCode,
    required this.countryId,
    required this.balance,
    required this.orderBalance,
    required this.isBanned,
    required this.image,
    required this.address,
    required this.isKycVerified,
    required this.isOnline,
    required this.enablePushNotification,
    required this.lastLoginTime,
  });

  factory AssignOrder.fromMap(Map<String, dynamic> map) {
    return AssignOrder(
      id: map.parseInt('id'),
      fcmToken: map['fcm_token'] ?? '',
      registeredAt: map['registered_at'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
      phoneCode: map['phone_code'] ?? '',
      countryId: map.parseInt('country_id'),
      balance: map['balance'] ?? 0,
      orderBalance: map.parseNum('order_balance'),
      isBanned: map['is_banned'] ?? false,
      image: map['image'] ?? '',
      address: Address.fromMap(map['address']),
      isKycVerified: map['is_kyc_verified'] ?? false,
      isOnline: map['is_online'] ?? false,
      enablePushNotification: map['enable_push_notification'] ?? false,
      lastLoginTime: map['last_login_time'] ?? '',
    );
  }

  final Address address;
  final num balance;
  final int countryId;
  final String email;
  final bool enablePushNotification;
  final String fcmToken;
  final String firstName;
  final int id;
  final String image;
  final bool isBanned;
  final bool isKycVerified;
  final bool isOnline;
  final String lastLoginTime;
  final String lastName;
  final num orderBalance;
  final String phone;
  final String phoneCode;
  final String registeredAt;
  final String username;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fcm_token': fcmToken,
      'first_name': firstName,
      'registered_at': registeredAt,
      'last_name': lastName,
      'email': email,
      'username': username,
      'phone': phone,
      'phone_code': phoneCode,
      'country_id': countryId,
      'balance': balance,
      'order_balance': orderBalance,
      'is_banned': isBanned,
      'image': image,
      'address': address.toMap(),
      'is_kyc_verified': isKycVerified,
      'is_online': isOnline,
      'enable_push_notification': enablePushNotification,
      'last_login_time': lastLoginTime,
    };
  }
}

class Address {
  Address({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      latitude: map.parseDouble('latitude'),
      longitude: map.parseDouble('longitude'),
      address: map['address'] ?? '',
    );
  }

  final String address;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }
}

class TimeLine {
  TimeLine({
    required this.actions,
  });

  factory TimeLine.fromMap(Map<String, dynamic> json) {
    Map<String, Assign> actions = {};

    json.forEach((key, value) {
      actions[key] = Assign.fromMap(value);
    });

    return TimeLine(actions: actions);
  }

  final Map<String, Assign> actions;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {};

    actions.forEach((key, action) {
      json[key] = action.toMap();
    });

    return json;
  }

  List<Assign> getActionsAsList() {
    return actions.values.toList();
  }
}

class Assign {
  Assign({
    required this.actionBy,
    required this.time,
    required this.details,
  });

  factory Assign.fromMap(Map<String, dynamic> map) {
    return Assign(
      actionBy: map['action_by'] ?? '',
      time: map['time'] != null ? DateTime.parse(map['time']) : DateTime.now(),
      details: map['details'] ?? '',
    );
  }

  final String actionBy;
  final String details;
  final DateTime time;

  Map<String, dynamic> toMap() {
    return {
      'action_by': actionBy,
      'time': time.toIso8601String(),
      'details': details,
    };
  }
}

class ShippingInformation {
  ShippingInformation({
    required this.name,
    required this.duration,
    required this.durationUnit,
  });

  factory ShippingInformation.fromMap(Map<String, dynamic> map) {
    return ShippingInformation(
      name: map['name'] ?? '',
      duration: map['duration'] ?? '',
      durationUnit: map['duration_unit'] ?? '',
    );
  }

  final String duration;
  final String durationUnit;
  final String name;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'duration': duration,
      'duration_unit': durationUnit,
    };
  }
}
