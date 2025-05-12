class ReviewData {
  const ReviewData({
    required this.id,
    required this.rating,
    required this.message,
    required this.order,
    required this.createdAt,
  });

  factory ReviewData.fromMap(Map<String, dynamic> map) {
    return ReviewData(
      id: map['id']?.toInt() ?? 0,
      rating: map['rating']?.toInt() ?? 0,
      message: map['message'] ?? '',
      order: ReviewOrder.fromMap(map['order']),
      createdAt: map['created_at'] ?? '',
    );
  }

  final String createdAt;
  final int id;
  final String message;
  final ReviewOrder order;
  final int rating;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'rating': rating});
    result.addAll({'message': message});
    result.addAll({'order': order.toMap()});
    result.addAll({'created_at': createdAt});
    return result;
  }
}

class ReviewOrder {
  const ReviewOrder({
    required this.id,
    required this.uid,
    required this.orderNumber,
  });

  factory ReviewOrder.fromMap(Map<String, dynamic> map) {
    return ReviewOrder(
      id: map['id']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
      orderNumber: map['order_number'] ?? '',
    );
  }

  final int id;
  final String orderNumber;
  final String uid;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'order_number': orderNumber});
    return result;
  }
}
