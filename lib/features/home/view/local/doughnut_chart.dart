import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData({required this.x, required this.y, required this.text});

  final String text;
  final String x;
  final int y;
}

class DoughnutChartView extends HookWidget {
  const DoughnutChartView(this.overview, {super.key});

  final MainOverview overview;

  List<DoughnutSeries<ChartSampleData, String>> _getDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        explode: false,
        dataSource: [
          ChartSampleData(
            x: 'Total Withdraw',
            y: overview.totalSuccessWithdraw,
            text: overview.totalSuccessWithdraw.formate(),
          ),
          ChartSampleData(
            x: 'Pending Withdraw',
            y: overview.totalRejectedWithdraw,
            text: overview.totalRejectedWithdraw.formate(),
          ),
          ChartSampleData(
            x: 'Reject Withdraw',
            y: overview.totalPendingWithdraw,
            text: overview.totalPendingWithdraw.formate(),
          ),
        ],
        xValueMapper: (data, _) => data.x,
        yValueMapper: (data, _) => data.y,
        dataLabelMapper: (data, _) => data.text,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tooltip = useMemoized(
      () => TooltipBehavior(enable: true, format: 'point.x : point.y'),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: Corners.medBorder,
        color: context.colorTheme.surface,
      ),
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          textStyle: context.textTheme.bodyMedium,
        ),
        series: _getDefaultDoughnutSeries(),
        tooltipBehavior: tooltip,
      ),
    );
  }
}
