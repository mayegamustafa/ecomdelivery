import 'package:delivery_boy/main.export.dart';

class DeliveryMan {
  const DeliveryMan({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.referredBy,
    required this.registeredAt,
    required this.email,
    required this.fcmToken,
    required this.referralCode,
    required this.point,
    required this.isOnlineStatusActive,
    required this.lastOnlineTime,
    required this.distanceInWords,
    required this.distance,
    required this.username,
    required this.phone,
    required this.phoneCode,
    required this.countryId,
    required this.balance,
    required this.orderBalance,
    required this.isBanned,
    required this.image,
    required this.address,
    required this.kycData,
    required this.reviews,
    required this.avgRatings,
    required this.isOnline,
    required this.pushNotification,
    required this.isKycVerified,
    required this.enablePushNotification,
    required this.lastLoginTime,
    required this.message,
  });

  factory DeliveryMan.fromMap(Map<String, dynamic> map) {
    return DeliveryMan(
      id: map.parseInt('id'),
      firstName: map['first_name'] ?? '',
      referredBy: switch (map) {
        {'reffered_by': QMap q} => DeliveryMan.fromMap(q),
        _ => null
      },
      lastName: map['last_name'] ?? '',
      fcmToken: map['fcm_token'] ?? '',
      registeredAt: map['registered_at'] ?? '',
      referralCode: map.parseInt('referral_code'),
      point: map.parseInt('point'),
      isOnlineStatusActive: map['is_online_status_active'] ?? false,
      lastOnlineTime: map['last_online_time'] ?? '',
      distanceInWords: map['distance_in_words'] ?? '',
      distance: map.parseInt('distance'),
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
      kycData: Map<String, dynamic>.from(map['kyc_data'] ?? {}),
      reviews: PagedItem<DeliveryManReview>.fromMap(
        map['reviews'],
        (x) => DeliveryManReview.fromMap(x),
      ),
      avgRatings: map.parseDouble('avg_ratings'),
      isOnline: map['is_online'] ?? false,
      pushNotification: map['enable_push_notification'] ?? false,
      isKycVerified: map['is_kyc_verified'] ?? false,
      enablePushNotification: map['enable_push_notification'] ?? false,
      lastLoginTime: map['last_login_time'] ?? '',
      message: map['latest_deliveryman_message'] == null
          ? null
          : DeliveryMessage.fromMap(map['latest_deliveryman_message']),
    );
  }

  final DeliveryManAddress address;
  final num balance;
  final int countryId;
  final DeliveryMan? referredBy;
  final String registeredAt;
  final String email;
  final String firstName;
  final String fcmToken;
  final int referralCode;
  final int point;
  final bool isOnlineStatusActive;
  final String lastOnlineTime;
  final String distanceInWords;
  final int distance;
  final int id;
  final String image;
  final bool isBanned;
  final Map<String, dynamic> kycData;
  final String lastName;
  final num orderBalance;
  final String phone;
  final String phoneCode;
  final String username;
  final double avgRatings;
  final PagedItem<DeliveryManReview> reviews;
  final bool isOnline;
  final bool pushNotification;
  final bool isKycVerified;
  final bool enablePushNotification;
  final String lastLoginTime;
  final DeliveryMessage? message;

  String get fullName {
    final isEmpty = firstName.isEmpty && lastName.isEmpty;
    return isEmpty ? '' : '$firstName $lastName';
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'first_name': firstName});
    result.addAll({'reffered_by': referredBy?.toMap()});
    result.addAll({'last_name': lastName});
    result.addAll({'registered_at': registeredAt});
    result.addAll({'fcm_token': fcmToken});
    result.addAll({'referral_code': referralCode});
    result.addAll({'point': point});
    result.addAll({'is_online_status_active': isOnlineStatusActive});
    result.addAll({'last_online_time': lastOnlineTime});
    result.addAll({'distance_in_words': distanceInWords});
    result.addAll({'distance': distance});
    result.addAll({'email': email});
    result.addAll({'username': username});
    result.addAll({'phone': phone});
    result.addAll({'phone_code': phoneCode});
    result.addAll({'country_id': countryId});
    result.addAll({'balance': balance});
    result.addAll({'order_balance': orderBalance});
    result.addAll({'is_banned': isBanned});
    result.addAll({'image': image});
    result.addAll({'address': address.toMap()});
    result.addAll({'kyc_data': kycData});
    result.addAll({'reviews': reviews.toMap((x) => x.toMap())});
    result.addAll({'avg_ratings': avgRatings});
    result.addAll({'is_online': isOnline});
    result.addAll({'enable_push_notification': pushNotification});
    result.addAll({'is_kyc_verified': isKycVerified});
    result.addAll({'last_login_time': lastLoginTime});
    result.addAll({'latest_deliveryman_message': message?.toMap()});

    return result;
  }
}

class DeliveryManReview {
  const DeliveryManReview({
    required this.id,
    required this.rating,
    required this.message,
    required this.orderId,
    required this.orderUid,
    required this.orderNumber,
    required this.createdAt,
  });

  final String createdAt;
  final int id;
  final String message;
  final String orderId;
  final String orderNumber;
  final String orderUid;
  final double rating;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'message': message,
      'order': {
        'id': orderId,
        'uid': orderUid,
        'order_number': orderNumber,
      },
      'created_at': createdAt,
    };
  }

  factory DeliveryManReview.fromMap(Map<String, dynamic> map) {
    return DeliveryManReview(
      id: map.parseInt('id'),
      rating: map.parseDouble('rating'),
      message: map['message'] ?? '',
      orderId: map['order']?['id']?.toString() ?? '',
      orderUid: map['order']?['uid'] ?? '',
      orderNumber: map['order']?['order_number'] ?? '',
      createdAt: map['created_at'],
    );
  }
}
