import 'package:delivery_boy/main.export.dart';

class DeliveryManModel {
  final int id;
  final String fcmToken;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phone;
  final String phoneCode;
  final int countryId;
  final num balance;
  final num orderBalance;
  final bool isBanned;
  final String image;
  final DeliveryManAddress address;
  final bool isKycVerified;
  final bool isOnline;
  final bool isOnlineStatusActive;
  final bool enablePushNotification;
  final String? lastLoginTime;
  final String lastOnlineTime;
  DeliveryManModel({
    required this.id,
    required this.fcmToken,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.phone,
    required this.isOnlineStatusActive,
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
    required this.lastOnlineTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fcm_token': fcmToken,
      'first_name': firstName,
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
      'is_online_status_active': isOnlineStatusActive,
      'enable_push_notification': enablePushNotification,
      'last_login_time': lastLoginTime,
      'last_online_time': lastOnlineTime,
    };
  }

  factory DeliveryManModel.fromMap(Map<String, dynamic> map) {
    return DeliveryManModel(
      id: map.parseInt('id'),
      fcmToken: map['fcm_token'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      phone: map['phone'] ?? '',
      phoneCode: map['phone_code'] ?? '',
      countryId: map.parseInt('country_id'),
      balance: map.parseNum('balance'),
      orderBalance: map.parseNum('order_balance'),
      isBanned: map['is_banned'] ?? false,
      image: map['image'] ?? '',
      address: DeliveryManAddress.fromMap(map['address']),
      isKycVerified: map['is_kyc_verified'] ?? false,
      isOnline: map['is_online'] ?? false,
      isOnlineStatusActive: map['is_online_status_active'] ?? false,
      enablePushNotification: map['enable_push_notification'] ?? false,
      lastLoginTime: map['last_login_time'] ?? '',
      lastOnlineTime: map['last_online_time'] ?? '',
    );
  }
}
