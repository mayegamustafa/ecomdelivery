import 'package:delivery_boy/features/region/controller/region_ctrl.dart';
import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningCharData {
  final String x;
  final int y;

  EarningCharData({required this.x, required this.y});
}

class EarningChart extends HookConsumerWidget {
  const EarningChart(this.overview, {super.key});
  final MainOverview overview;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tooltipBehavior = useState(
        TooltipBehavior(enable: true, header: '', canShowMarker: false));

    final List<EarningCharData> successData = overview.earningLog.entries
        .map(
          (entry) => EarningCharData(
            x: entry.key.substring(0, 3),
            y: entry.value,
          ),
        )
        .toList();

    final currency = ref.watch(regionCtrlProvider.select((e) => e.currency));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: context.colorTheme.surface,
          borderRadius: Corners.medBorder,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfCartesianChart(
            plotAreaBorderWidth: 0,
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(
                color: context.colorTheme.surfaceBright.withOpacity(.08),
              ),
              interval: 1,
            ),
            primaryYAxis: NumericAxis(
              labelFormat: '{value}',
              numberFormat: NumberFormat.currency(
                symbol: currency?.symbol,
              ),
              rangePadding: ChartRangePadding.round,
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            series: _getEarningColumnSeries(successData),
            tooltipBehavior: tooltipBehavior.value,
          ),
        ),
      ),
    );
  }

  List<ColumnSeries<EarningCharData, String>> _getEarningColumnSeries(
    List<EarningCharData> successData,
  ) {
    return <ColumnSeries<EarningCharData, String>>[
      ColumnSeries<EarningCharData, String>(
        dataSource: successData,
        xValueMapper: (EarningCharData sales, _) => sales.x,
        yValueMapper: (EarningCharData sales, _) => sales.y,
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          textStyle: TextStyle(fontSize: 10),
        ),
      ),
    ];
  }
}
