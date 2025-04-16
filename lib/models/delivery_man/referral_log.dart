import 'package:delivery_boy/main.export.dart';

class ReferralLog {
  final OverView overview;
  final List<DeliveryMan> deliveryMen;
  ReferralLog({
    required this.overview,
    required this.deliveryMen,
  });

  Map<String, dynamic> toMap() {
    return {
      'overview': overview.toMap(),
      'delivery_men': deliveryMen.map((x) => x.toMap()).toList(),
    };
  }

  factory ReferralLog.fromMap(Map<String, dynamic> map) {
    return ReferralLog(
      overview: OverView.fromMap(map['overview']),
      deliveryMen: List<DeliveryMan>.from(
        map['delivery_men']?['data'].map((x) => DeliveryMan.fromMap(x)),
      ),
    );
  }

  ReferralLog copyWith({
    OverView? overview,
    List<DeliveryMan>? deliveryMen,
  }) {
    return ReferralLog(
      overview: overview ?? this.overview,
      deliveryMen: deliveryMen ?? this.deliveryMen,
    );
  }
}

class OverView {
  final num totalPointEarned;
  final num totalReferred;
  OverView({
    required this.totalPointEarned,
    required this.totalReferred,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_point_earned': totalPointEarned,
      'total_reffered': totalReferred,
    };
  }

  factory OverView.fromMap(Map<String, dynamic> map) {
    return OverView(
      totalPointEarned: map['total_point_earned'] ?? 0,
      totalReferred: map['total_reffered'] ?? 0,
    );
  }
}
