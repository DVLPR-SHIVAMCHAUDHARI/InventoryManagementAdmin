class GateEntryModel {
  final int id;

  final DateTime? date;
  final String? time;

  final String driverName;
  final String vehicleNo;

  final int? partyId;
  final String? partyName;
  final String? invoiceId;

  final int vehicleWeight;
  final String driverMobileNo;

  final DateTime? createdAt;
  final String? createdBy;

  GateEntryModel({
    required this.id,
    required this.date,
    required this.time,
    required this.driverName,
    required this.vehicleNo,
    this.partyId,
    this.partyName,
    this.invoiceId,
    required this.vehicleWeight,
    required this.driverMobileNo,
    this.createdAt,
    this.createdBy,
  });

  factory GateEntryModel.fromJson(Map<String, dynamic> json) {
    return GateEntryModel(
      id: json["id"] ?? 0,

      /// date: "23-03-2026"
      date: _parseDate(json["date"]),

      /// time: "11:18"
      time: json["time"],

      driverName: json["driver_name"] ?? "",
      vehicleNo: json["vehicle_no"] ?? "",

      /// IMPORTANT: correct mapping
      partyId: json["party_name_id"],
      partyName: json["party_name"],
      invoiceId: json["invoice_id"],

      vehicleWeight: int.tryParse(json["vehicle_weight"].toString()) ?? 0,

      driverMobileNo: json["driver_mobile_no"]?.toString() ?? "",

      createdAt: _parseDateTime(json["created_at"]),
      createdBy: json["created_by"],
    );
  }

  /// ---------------- HELPERS ----------------

  static DateTime? _parseDate(String? date) {
    if (date == null) return null;

    try {
      final parts = date.split("-");
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]), // year
          int.parse(parts[1]), // month
          int.parse(parts[0]), // day
        );
      }
    } catch (_) {}

    return null;
  }

  static DateTime? _parseDateTime(String? dateTime) {
    if (dateTime == null) return null;

    try {
      return DateTime.parse(dateTime);
    } catch (_) {
      return null;
    }
  }
}
