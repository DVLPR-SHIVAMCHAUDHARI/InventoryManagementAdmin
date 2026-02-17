import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WarehousePieChart extends StatelessWidget {
  final List<MainLocationSummaryModel> data;

  const WarehousePieChart({super.key, required this.data});

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
          title: ChartTitle(text: 'Warehouse Distribution'),
          legend: Legend(
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
          ),
          tooltipBehavior: TooltipBehavior(
            enable: true, // enable tooltip on hover / tap
            format: 'point.x : point.y', // show name and count
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          series: [
            PieSeries<MainLocationSummaryModel, String>(
              dataSource: data,
              xValueMapper: (d, _) => d.departmentName,
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

class LocationBoxSizeChart extends StatelessWidget {
  final List<MainLocationSummaryModel> locations;

  const LocationBoxSizeChart({super.key, required this.locations});

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
    final chartData = buildPartyBoxChartData(locations);

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
            text: 'Department vs Box Size Distribution',
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
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.x : point.y', // shows location + count
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
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
            return ColumnSeries<LocationBoxChartData, String>(
              name: boxSize,
              dataSource: chartData.where((e) => e.boxSize == boxSize).toList(),
              xValueMapper: (d, _) => d.locationName,
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

List<LocationBoxChartData> buildPartyBoxChartData(
  List<MainLocationSummaryModel> parties,
) {
  final List<LocationBoxChartData> data = [];

  for (final party in parties) {
    for (final box in party.boxSizes) {
      data.add(
        LocationBoxChartData(
          locationName: party.departmentName,
          boxSize: box.boxSize,
          count: box.boxCount,
        ),
      );
    }
  }

  return data;
}
