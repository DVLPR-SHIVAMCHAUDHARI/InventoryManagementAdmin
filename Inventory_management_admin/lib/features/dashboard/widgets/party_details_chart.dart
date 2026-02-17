import 'package:inventory_management_admin_pannel/features/dashboard/models/party_box_chart_data.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PartyBoxSizeChart extends StatelessWidget {
  final List<PartySummaryModel> parties;

  const PartyBoxSizeChart({super.key, required this.parties});

  static const List<Color> chartColors = [
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFF2196F3), // Blue
    Color(0xFFE91E63), // Pink
    Color(0xFFFFEB3B), // Yellow
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
    Color(0xFFFF5722), // Deep Orange
  ];

  @override
  Widget build(BuildContext context) {
    final chartData = buildPartyBoxChartData(parties);

    final boxSizes = chartData.map((e) => e.boxSize).toSet().toList();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        height: 420, // ✅ Web-friendly height
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: SfCartesianChart(
          title: ChartTitle(
            text: 'Party vs Box Size Distribution',
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(enable: true),
          primaryXAxis: CategoryAxis(
            labelRotation: 0,
            majorGridLines: const MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Box Count'),
            majorGridLines: MajorGridLines(color: Colors.grey.shade200),
          ),
          series: boxSizes.asMap().entries.map((entry) {
            final index = entry.key;
            final boxSize = entry.value;
            return ColumnSeries<PartyBoxChartData, String>(
              name: boxSize,
              dataSource: chartData.where((e) => e.boxSize == boxSize).toList(),
              xValueMapper: (d, _) => d.partyName,
              yValueMapper: (d, _) => d.count,
              pointColorMapper: (d, _) =>
                  chartColors[index % chartColors.length],
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class PartyPieChart extends StatelessWidget {
  final List<PartySummaryModel> data;

  const PartyPieChart({super.key, required this.data});

  static const List<Color> chartColors = [
    Color(0xFF4CAF50), // Green
    Color(0xFFFF9800), // Orange
    Color(0xFF2196F3), // Blue
    Color(0xFFE91E63), // Pink
    Color(0xFFFFEB3B), // Yellow
    Color(0xFF9C27B0), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFF795548), // Brown
    Color(0xFF607D8B), // Blue Grey
    Color(0xFFFF5722), // Deep Orange
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SfCircularChart(
          title: ChartTitle(text: 'Party Distribution'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true, // enable tooltip on hover / tap
            format: 'point.x : point.y', // show party name + count
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          series: [
            PieSeries<PartySummaryModel, String>(
              dataSource: data,
              xValueMapper: (d, _) => d.partyName,
              yValueMapper: (d, _) => d.totalBoxes.toDouble(),
              pointColorMapper: (d, index) =>
                  chartColors[index % chartColors.length],
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelPosition: ChartDataLabelPosition.inside,
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
