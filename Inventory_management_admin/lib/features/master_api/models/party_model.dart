class PartyModel {
  final int id;
  final String name;
  final String companyAddress;
  final String department;
  final String createdBy;
  final String updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PartyModel({
    required this.id,
    required this.name,
    required this.companyAddress,
    required this.department,
    required this.createdBy,
    required this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) {
    return PartyModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      companyAddress: json['company_address'] ?? '',
      department: json['department'] ?? '-',
      createdBy: json['created_by'] ?? '-',
      updatedBy: json['updated_by'] ?? '-',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
