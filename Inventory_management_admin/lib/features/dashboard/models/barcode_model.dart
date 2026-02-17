class BarcodeModel {
  final int id;
  final String barcode;
  final String boxSize;
  final int currentLocation;
  final String currentLocationDetail;
  final String createdBy;
  final String updatedBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BarcodeModel({
    required this.id,
    required this.barcode,
    required this.boxSize,
    required this.currentLocation,
    required this.currentLocationDetail,
    required this.createdBy,
    required this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory BarcodeModel.fromJson(Map<String, dynamic> json) {
    return BarcodeModel(
      id: json['id'] ?? 0,
      barcode: json['barcode'] ?? '',
      boxSize: json['box_size'] ?? '',
      currentLocation: json['current_location'] ?? 0,
      currentLocationDetail: json['current_location_detail'] ?? '',
      createdBy: json['created_by'] ?? '',
      updatedBy: json['updated_by'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? ''),
    );
  }
}
