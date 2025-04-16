import 'package:delivery_boy/main.export.dart';

class RewardPoint {
  final String name;
  final double amount;
  final double lessThanEq;
  final double minAmount;

  const RewardPoint({
    required this.name,
    required this.amount,
    required this.lessThanEq,
    required this.minAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
      'less_than_eq': lessThanEq,
      'min_amount': minAmount,
    };
  }

  static List<RewardPoint> fromList(List? list) {
    return List<RewardPoint>.from(
      list?.map((x) => RewardPoint.fromMap(x)) ?? [],
    );
  }

  factory RewardPoint.fromMap(Map<String, dynamic> map) {
    return RewardPoint(
      name: map['name'] ?? '',
      amount: map.parseDouble('amount'),
      lessThanEq: map.parseDouble('less_than_eq'),
      minAmount: map.parseDouble('min_amount'),
    );
  }
}

class RewardPointConfig {
  final double minAmount;
  final double lesThenEq;
  final double point;
  RewardPointConfig({
    required this.minAmount,
    required this.lesThenEq,
    required this.point,
  });

  Map<String, dynamic> toMap() {
    return {
      'min_amount': minAmount,
      'less_than_eq': lesThenEq,
      'point': point,
    };
  }

  static List<RewardPointConfig> fromList(List? list) {
    return List<RewardPointConfig>.from(
      list?.map((x) => RewardPointConfig.fromMap(x)) ?? [],
    );
  }

  factory RewardPointConfig.fromMap(Map<String, dynamic> map) {
    return RewardPointConfig(
      minAmount: map.parseDouble('min_amount'),
      lesThenEq: map.parseDouble('less_than_eq'),
      point: map.parseDouble('point'),
    );
  }
  bool isBetween(double amount) {
    return amount > minAmount.formateSelf(rateCheck: true) &&
        amount <= lesThenEq.formateSelf(rateCheck: true);
  }
}
