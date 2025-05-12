import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalOrderChart extends HookWidget {
  const TotalOrderChart({
    super.key,
    required this.analytics,
  });
  final AnalyticsModel analytics;
  @override
  Widget build(BuildContext context) {
    final tooltipBehavior = useState(
        TooltipBehavior(enable: true, header: '', canShowMarker: true));

    final List<_ChartData> successData =
        analytics.overview.orderGraph.monthlyOrders.entries
            .map(
              (entry) => _ChartData(
                entry.key.substring(0, 3),
                entry.value.delivered,
              ),
            )
            .toList();
    final List<_ChartData> pendingData =
        analytics.overview.orderGraph.monthlyOrders.entries
            .map(
              (entry) => _ChartData(
                entry.key.substring(0, 3),
                entry.value.pending,
              ),
            )
            .toList();

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      height: 250,
      child: SfCartesianChart(
        tooltipBehavior: tooltipBehavior.value,
        legend: Legend(
          isVisible: true,
          position: LegendPosition.top,
          legendItemBuilder: (legendText, series, point, seriesIndex) {
            return Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: series?.color,
                  ),
                ),
                const Gap(Insets.med),
                Text(legendText)
              ],
            );
          },
        ),
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(
            color: context.colorTheme.surfaceBright.withOpacity(.08),
          ),
          interval: 1,
        ),
        primaryYAxis: const NumericAxis(
          labelFormat: '{value}',
          rangePadding: ChartRangePadding.round,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0),
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: [
          SplineSeries<_ChartData, String>(
            name: TR.of(context).successDelivered,
            dataSource: successData,
            xValueMapper: (_ChartData data, _) => data.month,
            yValueMapper: (_ChartData data, _) => data.value,
            color: Colors.red,
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: Colors.red,
              borderWidth: 2,
            ),
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
          SplineSeries<_ChartData, String>(
            name: TR.of(context).pendingDelivered,
            dataSource: pendingData,
            xValueMapper: (_ChartData data, _) => data.month,
            yValueMapper: (_ChartData data, _) => data.value,
            color: Colors.green,
            markerSettings: const MarkerSettings(
              isVisible: true,
              color: Colors.green,
              borderWidth: 2,
            ),
            dataLabelSettings: const DataLabelSettings(isVisible: false),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.month, this.value);
  final String month;
  final int value;
}
