import 'package:inventory_management_admin_pannel/features/dashboard/models/party_box_chart_data.dart';

class StageSummaryModel {
  final int stage1;
  final int stage2;
  final int stage1To2;
  final int stage2To1;
  final int totalBoxes;

  StageSummaryModel({
    required this.stage1,
    required this.stage2,
    required this.stage1To2,
    required this.stage2To1,
    required this.totalBoxes,
  });

  factory StageSummaryModel.fromJson(Map<String, dynamic> json) {
    return StageSummaryModel(
      stage1: json['stage_1'] ?? 0,
      stage2: json['stage_2'] ?? 0,
      stage1To2: json['stage_1_2'] ?? 0,
      stage2To1: json['stage_2_1'] ?? 0,
      totalBoxes: json['total_boxes'] ?? 0,
    );
  }
}

class MainLocationSummaryModel {
  final String departmentName;
  final int totalBoxes;
  final List<PartyBoxSizeModel> boxSizes;

  MainLocationSummaryModel({
    required this.departmentName,
    required this.totalBoxes,
    required this.boxSizes,
  });

  factory MainLocationSummaryModel.fromJson(Map<String, dynamic> json) {
    return MainLocationSummaryModel(
      departmentName: json['department_name'] ?? '',
      totalBoxes: json['counting'] ?? 0,
      boxSizes: (json['box_sizes'] as List? ?? [])
          .map((e) => PartyBoxSizeModel.fromJson(e))
          .toList(),
    );
  }
}

class LocationBoxChartData {
  final String locationName;
  final String boxSize;
  final int count;

  LocationBoxChartData({
    required this.locationName,
    required this.boxSize,
    required this.count,
  });
}

class PartySummaryModel {
  final String partyName;
  final int totalBoxes;
  final List<PartyBoxSizeModel> boxSizes;

  PartySummaryModel({
    required this.partyName,
    required this.totalBoxes,
    required this.boxSizes,
  });

  factory PartySummaryModel.fromJson(Map<String, dynamic> json) {
    return PartySummaryModel(
      partyName: json['party_name'] ?? '',
      totalBoxes: json['total_boxes'] ?? 0,
      boxSizes: (json['box_sizes'] as List? ?? [])
          .map((e) => PartyBoxSizeModel.fromJson(e))
          .toList(),
    );
  }
}
