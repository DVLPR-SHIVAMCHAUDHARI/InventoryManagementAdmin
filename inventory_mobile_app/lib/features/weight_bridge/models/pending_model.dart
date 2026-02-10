class WeighBridgePendingEntry {
  final int gateId;
  final String date;
  final String gateTime;
  final String invoiceNo;
  final String lorryNo;
  final String partyName;
  final String driverName;
  final String driverMobile;

  // WB IN data
  final String materialName;
  final double grossWeight;
  final String wbInDate;
  final String wbInTime;

  WeighBridgePendingEntry({
    required this.gateId,
    required this.date,
    required this.gateTime,
    required this.invoiceNo,
    required this.lorryNo,
    required this.partyName,
    required this.driverName,
    required this.driverMobile,
    required this.materialName,
    required this.grossWeight,
    required this.wbInDate,
    required this.wbInTime,
  });
}
