class CurrentLocationModel {
  final int id;
  final String location;
  final String createdBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CurrentLocationModel({
    required this.id,
    required this.location,
    required this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory CurrentLocationModel.fromJson(Map<String, dynamic> json) {
    return CurrentLocationModel(
      id: json['id'] ?? 0,
      location: json['location'] ?? '',
      createdBy: json['created_by'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
    );
  }
}
