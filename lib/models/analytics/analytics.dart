class AnalyticsModel {
  final Overview overview;

  AnalyticsModel({required this.overview});

  factory AnalyticsModel.fromMap(Map<String, dynamic> json) {
    return AnalyticsModel(
      overview: Overview.fromMap(json['overview']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'overview': overview.toMap(),
    };
  }
}

class Overview {
  final int totalOrder;
  final int totalDelivered;
  final int pendingOrder;
  final OrderGraph orderGraph;
  final EarningLog earningLog;

  Overview({
    required this.totalOrder,
    required this.totalDelivered,
    required this.pendingOrder,
    required this.orderGraph,
    required this.earningLog,
  });

  double get deliveredPercentage {
    if (totalOrder == 0) return 0.0;
    return (totalDelivered / totalOrder) * 100;
  }

  double get pendingPercentage {
    if (totalOrder == 0) return 0.0;
    return (pendingOrder / totalOrder) * 100;
  }

  factory Overview.fromMap(Map<String, dynamic> json) {
    return Overview(
      totalOrder: json['total_order'],
      totalDelivered: json['total_delivered'],
      pendingOrder: json['pending_order'],
      orderGraph: OrderGraph.fromMap(json['order_graph']),
      earningLog: EarningLog.fromMap(json['earning_log']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'total_order': totalOrder,
      'total_delivered': totalDelivered,
      'pending_order': pendingOrder,
      'order_graph': orderGraph.toMap(),
      'earning_log': earningLog.toMap(),
    };
  }
}

class OrderGraph {
  final Map<String, OrderStatus> monthlyOrders;

  OrderGraph({required this.monthlyOrders});

  factory OrderGraph.fromMap(Map<String, dynamic> json) {
    Map<String, OrderStatus> monthlyOrders = {};
    json.forEach((key, value) {
      monthlyOrders[key] = OrderStatus.fromMap(value);
    });
    return OrderGraph(monthlyOrders: monthlyOrders);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    monthlyOrders.forEach((key, value) {
      data[key] = value.toMap();
    });
    return data;
  }
}

class OrderStatus {
  final int delivered;
  final int pending;

  OrderStatus({required this.delivered, required this.pending});

  factory OrderStatus.fromMap(Map<String, dynamic> json) {
    return OrderStatus(
      delivered: json['delivered'],
      pending: json['pending'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'delivered': delivered,
      'pending': pending,
    };
  }
}

class EarningLog {
  final Map<String, int> monthlyEarnings;
  final Map<String, int> weeklyEarnings;
  final Map<String, int> yearlyEarnings;

  EarningLog({
    required this.monthlyEarnings,
    required this.weeklyEarnings,
    required this.yearlyEarnings,
  });

  factory EarningLog.fromMap(Map<String, dynamic> json) {
    return EarningLog(
      monthlyEarnings: Map<String, int>.from(json['monthly']),
      weeklyEarnings: Map<String, int>.from(json['weekly']),
      yearlyEarnings: Map<String, int>.from(json['yearly']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'monthly': monthlyEarnings,
      'weekly': weeklyEarnings,
      'yearly': yearlyEarnings,
    };
  }
}
