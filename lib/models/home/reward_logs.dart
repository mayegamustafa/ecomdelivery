import 'package:delivery_boy/models/home/product_order.dart';

class RewardLogs {
  final int id;
  final ProductOrder? order;
  final int postPoint;
  final int point;
  final String createdAtStr;
  final String humanReadableTime;
  final String details;
  RewardLogs({
    required this.id,
    this.order,
    required this.postPoint,
    required this.point,
    required this.createdAtStr,
    required this.humanReadableTime,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order?.toMap(),
      'post_point': postPoint,
      'point': point,
      'created_at': createdAtStr,
      'human_readable_time': humanReadableTime,
      'details': details,
    };
  }

  DateTime get createdAt => DateTime.parse(createdAtStr);
  factory RewardLogs.fromMap(Map<String, dynamic> map) {
    return RewardLogs(
      id: map['id']?.toInt() ?? 0,
      order: map['order'] != null ? ProductOrder.fromMap(map['order']) : null,
      postPoint: map['post_point']?.toInt() ?? 0,
      point: map['point']?.toInt() ?? 0,
      createdAtStr: map['created_at'] ?? '',
      humanReadableTime: map['human_readable_time'] ?? '',
      details: map['details'] ?? '',
    );
  }
}
