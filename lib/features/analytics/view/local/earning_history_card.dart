import 'package:delivery_boy/main.export.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningHistoryChart extends HookWidget {
  const EarningHistoryChart({super.key, required this.earningLog});

  final EarningLog earningLog;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    final tooltipBehavior =
        TooltipBehavior(enable: true, header: '', canShowMarker: true);

    final List<_ChartData> weeklyData = earningLog.weeklyEarnings.entries
        .map((e) => _ChartData(e.key.substring(0, 3), e.value))
        .toList();

    final List<_ChartData> monthlyData = earningLog.monthlyEarnings.entries
        .map((e) => _ChartData(e.key.substring(0, 3), e.value))
        .toList();

    final List<_ChartData> yearlyData = earningLog.yearlyEarnings.entries
        .map((e) => _ChartData(e.key, e.value))
        .toList();

    List<_ChartData> getCurrentData() {
      return switch (selectedIndex.value) {
        0 => weeklyData,
        1 => monthlyData,
        _ => yearlyData
      };
    }

    return Container(
      decoration: BoxDecoration(
        color: context.colorTheme.surface,
        borderRadius: Corners.medBorder,
      ),
      padding: Insets.padAllContainer,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: context.colorTheme.surfaceBright.withOpacity(.1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(Insets.sm),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: selectedIndex.value == 0
                          ? context.colorTheme.primary
                          : context.colorTheme.surface,
                      foregroundColor: selectedIndex.value == 0
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.surfaceBright.withOpacity(.7),
                    ),
                    onPressed: () => selectedIndex.value = 0,
                    child: Text(
                      TR.of(context).weekly,
                      maxLines: 1,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: selectedIndex.value == 0
                            ? context.colorTheme.onPrimary
                            : context.colorTheme.surfaceBright,
                      ),
                    ),
                  ),
                ),
                const Gap(Insets.sm),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: selectedIndex.value == 1
                          ? context.colorTheme.primary
                          : context.colorTheme.surface,
                      foregroundColor: selectedIndex.value == 1
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.surfaceBright.withOpacity(.7),
                    ),
                    onPressed: () => selectedIndex.value = 1,
                    child: Text(
                      TR.of(context).monthly,
                      maxLines: 1,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: selectedIndex.value == 1
                            ? context.colorTheme.onPrimary
                            : context.colorTheme.surfaceBright,
                      ),
                    ),
                  ),
                ),
                const Gap(Insets.sm),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: selectedIndex.value == 2
                          ? context.colorTheme.primary
                          : context.colorTheme.surface,
                      foregroundColor: selectedIndex.value == 2
                          ? context.colorTheme.onPrimary
                          : context.colorTheme.surfaceBright.withOpacity(.7),
                    ),
                    onPressed: () => selectedIndex.value = 2,
                    child: Text(
                      TR.of(context).yearly,
                      maxLines: 1,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: selectedIndex.value == 2
                            ? context.colorTheme.onPrimary
                            : context.colorTheme.surfaceBright,
                      ),
                    ),
                  ),
                ),
                const Gap(Insets.sm),
              ],
            ),
          ),
          const Gap(Insets.med),
          SizedBox(
            height: 200,
            child: SfCartesianChart(
              tooltipBehavior: tooltipBehavior,
              legend: const Legend(isVisible: false),
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                majorGridLines: MajorGridLines(
                  color: context.colorTheme.surfaceBright.withOpacity(.08),
                ),
                interval: 1,
              ),
              primaryYAxis: const NumericAxis(
                labelFormat: '{value}',
                axisLine: AxisLine(width: 0),
                majorTickLines: MajorTickLines(size: 0),
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: [
                SplineSeries<_ChartData, String>(
                  name: selectedIndex.value == 0
                      ? 'Weekly'
                      : selectedIndex.value == 1
                          ? 'Monthly'
                          : 'Yearly',
                  dataSource: getCurrentData(),
                  xValueMapper: (_ChartData data, _) => data.month,
                  yValueMapper: (_ChartData data, _) =>
                      selectedIndex.value == 0 ? data.value : data.value / 1000,
                  color: Colors.red,
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    color: Colors.red,
                    borderWidth: 2,
                  ),
                  dataLabelSettings: const DataLabelSettings(isVisible: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  const _ChartData(this.month, this.value);

  final String month;
  final int value;
}
