import 'package:delivery_boy/main.export.dart';

class MainOverview {
  MainOverview({
    required this.totalSuccessWithdraw,
    required this.totalPendingWithdraw,
    required this.totalRejectedWithdraw,
    required this.totalOrder,
    required this.totalPlacedOrder,
    required this.totalShippedOrder,
    required this.totalCancelOrder,
    required this.totalReturnOrder,
    required this.totalDeliveredOrder,
    required this.totalConfirmedOrder,
    required this.totalProcessingOrder,
    required this.earningLog,
  });

  factory MainOverview.fromMap(Map<String, dynamic> map) {
    return MainOverview(
      totalSuccessWithdraw: map.parseInt('total_success_withdraw'),
      totalPendingWithdraw: map.parseInt('total_pending_withdraw'),
      totalReturnOrder: map.parseInt('total_return_order'),
      totalRejectedWithdraw: map.parseInt('total_rejected_withdraw'),
      totalOrder: map.parseInt('total_order'),
      totalPlacedOrder: map.parseInt('total_placed_order'),
      totalShippedOrder: map.parseInt('total_shipped_order'),
      totalCancelOrder: map.parseInt('total_cancel_order'),
      totalDeliveredOrder: map.parseInt('total_delivered_order'),
      totalConfirmedOrder: map.parseInt('total_confirmed_order'),
      totalProcessingOrder: map.parseInt('total_processing_order'),
      earningLog: Map.from(map['earning_log']).map(
        (k, v) => MapEntry(k, v),
      ),
    );
  }

  final Map<String, int> earningLog;
  final int totalCancelOrder;
  final int totalConfirmedOrder;
  final int totalDeliveredOrder;
  final int totalOrder;
  final int totalPendingWithdraw;
  final int totalPlacedOrder;
  final int totalProcessingOrder;
  final int totalRejectedWithdraw;
  final int totalReturnOrder;
  final int totalShippedOrder;
  final int totalSuccessWithdraw;

  bool canShowPieChart() => !(totalSuccessWithdraw == 0 &&
      totalRejectedWithdraw == 0 &&
      totalPendingWithdraw == 0);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'total_success_withdraw': totalSuccessWithdraw});
    result.addAll({'total_pending_withdraw': totalPendingWithdraw});
    result.addAll({'total_return_order': totalReturnOrder});
    result.addAll({'total_rejected_withdraw': totalRejectedWithdraw});
    result.addAll({'total_order': totalOrder});
    result.addAll({'total_placed_order': totalPlacedOrder});
    result.addAll({'total_shipped_order': totalShippedOrder});
    result.addAll({'total_cancel_order': totalCancelOrder});
    result.addAll({'total_delivered_order': totalDeliveredOrder});
    result.addAll({'total_confirmed_order': totalConfirmedOrder});
    result.addAll({'total_processing_order': totalProcessingOrder});
    result.addAll({'earning_log': earningLog});

    return result;
  }

  List<({String title, SvgGenImage svg, int count})> get deliveryData => [
        (
          title: TR.current.totalDelivery,
          svg: Assets.icon.package,
          count: totalDeliveredOrder,
        ),
        (
          title: TR.current.totalOrder,
          svg: Assets.icon.box,
          count: totalOrder,
        ),
        (
          title: TR.current.pendingOrder,
          svg: Assets.icon.box,
          count: totalPlacedOrder,
        ),
        (
          title: TR.current.processingOrder,
          svg: Assets.icon.box,
          count: totalProcessingOrder,
        ),
        (
          title: TR.current.confirmedOrder,
          svg: Assets.icon.box,
          count: totalShippedOrder,
        ),
        (
          title: TR.current.shippedOrder,
          svg: Assets.icon.box,
          count: totalShippedOrder,
        ),
        (
          title: TR.current.cancelOrder,
          svg: Assets.icon.packageClose,
          count: totalCancelOrder,
        ),
      ];
}
