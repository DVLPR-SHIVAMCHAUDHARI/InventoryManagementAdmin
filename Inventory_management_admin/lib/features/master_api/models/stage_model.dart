class StageModel {
  final int id;
  final String stage;
  final DateTime? createdAt;

  StageModel({required this.id, required this.stage, this.createdAt});

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      id: json['id'] ?? 0,
      stage: json['stage'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }
}
