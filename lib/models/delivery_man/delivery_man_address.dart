import 'package:delivery_boy/main.export.dart';

class DeliveryManAddress {
  DeliveryManAddress({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory DeliveryManAddress.fromMap(Map<String, dynamic> map) {
    return DeliveryManAddress(
      latitude: map.parseDouble('latitude'),
      longitude: map.parseDouble('longitude'),
      address: map['address'] ?? '',
    );
  }

  final String address;
  final double latitude;
  final double longitude;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    result.addAll({'address': address});

    return result;
  }
}
