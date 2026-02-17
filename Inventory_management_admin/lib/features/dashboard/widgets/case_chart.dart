import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CasesStatusChart extends StatelessWidget {
  final int assigned;
  final int received;
  final int pending;
  final int missing;

  const CasesStatusChart({
    super.key,
    required this.assigned,
    required this.received,
    required this.pending,
    required this.missing,
  });

  @override
  Widget build(BuildContext context) {
    final data = [
      _ChartData("Assigned", assigned, Colors.orange),
      _ChartData("Received", received, Colors.green),
      _ChartData("Pending", pending, Colors.blue),
      _ChartData("Missing", missing, Colors.red),
    ];

    return Container(
      height: 400,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: SfCartesianChart(
        title: ChartTitle(text: 'Cases Overview'),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(),
        series: <CartesianSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
            dataSource: data,
            xValueMapper: (d, _) => d.label,
            yValueMapper: (d, _) => d.value,
            pointColorMapper: (d, _) => d.color,

            width: 0.3,
            spacing: 0.4,
            borderRadius: BorderRadius.circular(6),

            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  final String label;
  final int value;
  final Color color;

  _ChartData(this.label, this.value, this.color);
}
