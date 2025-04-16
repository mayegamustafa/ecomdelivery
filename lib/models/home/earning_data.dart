class EarningData {
  const EarningData({
    required this.orderId,
    required this.amount,
    required this.details,
    required this.rawDate,
    required this.readableDate,
    required this.dateIso,
  });

  factory EarningData.fromMap(Map<String, dynamic> map) {
    return EarningData(
      orderId: map['order']['order_id'],
      amount: map['amount'],
      details: map['details'],
      rawDate: map['created_at'],
      readableDate: map['human_readable_time'],
      dateIso: map['date_time'],
    );
  }

  final num amount;
  final String dateIso;
  final String details;
  final String orderId;
  final String rawDate;
  final String readableDate;

  DateTime get date => DateTime.parse(rawDate);

  Map<String, dynamic> toMap() {
    return {
      'order': {'order_id': orderId},
      'amount': amount,
      'details': details,
      'created_at': rawDate,
      'date_time': dateIso,
      'human_readable_time': readableDate,
    };
  }
}
