class GateExitModel {
  final int id;
  final String date;
  final String time;
  final String exitDate;
  final String exitTime;
  final String createdAt;
  final String createdBy;
  final String? invoiceId;
  final String partyName;
  final String updatedAt;
  final String? updatedBy;
  final String vehicleNo;
  final String driverName;
  final int partyNameId;
  final int productWeight;
  final int vehicleWeight;
  final String driverMobileNo;
  final int outVehicleWeight;

  GateExitModel({
    required this.id,
    required this.date,
    required this.time,
    required this.exitDate,
    required this.exitTime,
    required this.createdAt,
    required this.createdBy,
    this.invoiceId,
    required this.partyName,
    required this.updatedAt,
    this.updatedBy,
    required this.vehicleNo,
    required this.driverName,
    required this.partyNameId,
    required this.productWeight,
    required this.vehicleWeight,
    required this.driverMobileNo,
    required this.outVehicleWeight,
  });

  factory GateExitModel.fromJson(Map<String, dynamic> json) {
    return GateExitModel(
      id: json['id'],
      date: json['date'],
      time: json['time'],
      exitDate: json['exit_date'],
      exitTime: json['exit_time'],
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      invoiceId: json['invoice_id'],
      partyName: json['party_name'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
      vehicleNo: json['vehicle_no'],
      driverName: json['driver_name'],
      partyNameId: json['party_name_id'],
      productWeight: json['product_weight'],
      vehicleWeight: json['vehicle_weight'],
      driverMobileNo: json['driver_mobile_no'],
      outVehicleWeight: json['out_vehicle_weight'],
    );
  }
}
