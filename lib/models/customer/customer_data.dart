import 'package:delivery_boy/main.export.dart';

class CustomerData {
  const CustomerData({
    required this.uid,
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.image,
    required this.address,
    required this.country,
    required this.billingAddress,
    required this.lastMessage,
  });

  factory CustomerData.fromMap(Map<String, dynamic> map) {
    return CustomerData(
      uid: map['uid'],
      id: map.parseInt('id'),
      name: map['name'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      image: map['image'],
      address: map.converter('address', (v) => CustomerAddress.fromMap(v)),
      country: map.converter('country', (c) => Country.fromMap(c)),
      billingAddress:
          map.converter('billing_address', (c) => BillingInfo.fromMap(c)),
      lastMessage: map.converter(
        'latest_conversation',
        (x) => MessageModel.fromMap(x),
      ),
    );
  }

  String? get fullAddress {
    if (address == null) return null;
    return '${address?.address}, ${address?.city}, ${address?.state} (${address?.zip})';
  }

  final CustomerAddress? address;
  final BillingInfo? billingAddress;
  final Country? country;
  final String email;
  final int id;
  final String image;
  final MessageModel? lastMessage;
  final String name;
  final String? phone;
  final String uid;
  final String? username;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'image': image,
      'address': address?.toMap(),
      'country': country?.toMap(),
      'billing_address': billingAddress,
      'latest_conversation': lastMessage?.toMap(),
    };
  }
}
