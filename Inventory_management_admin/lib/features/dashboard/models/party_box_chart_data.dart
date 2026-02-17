import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';

class PartyBoxChartData {
  final String partyName;
  final String boxSize;
  final int count;

  PartyBoxChartData({
    required this.partyName,
    required this.boxSize,
    required this.count,
  });
}

List<PartyBoxChartData> buildPartyBoxChartData(
  List<PartySummaryModel> parties,
) {
  final List<PartyBoxChartData> data = [];

  for (final party in parties) {
    for (final box in party.boxSizes) {
      data.add(
        PartyBoxChartData(
          partyName: party.partyName,
          boxSize: box.boxSize,
          count: box.boxCount,
        ),
      );
    }
  }

  return data;
}

class PartyBoxSizeModel {
  final String boxSize;
  final int boxCount;

  PartyBoxSizeModel({required this.boxSize, required this.boxCount});

  factory PartyBoxSizeModel.fromJson(Map<String, dynamic> json) {
    return PartyBoxSizeModel(
      boxSize: json['box_size'] ?? '',
      boxCount: json['box_count'] ?? 0,
    );
  }
}
