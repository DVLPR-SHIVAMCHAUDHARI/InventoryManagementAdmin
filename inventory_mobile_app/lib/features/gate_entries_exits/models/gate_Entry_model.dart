class GateExitEntry {
  final int gateId;
  final String date;
  final String gateTime;
  final String invoiceNo;
  final String lorryNo;
  final String partyName;
  final String driverName;
  final String driverMobile;
  final bool isExited; // logout / back_hand

  GateExitEntry({
    required this.gateId,
    required this.date,
    required this.gateTime,
    required this.invoiceNo,
    required this.lorryNo,
    required this.partyName,
    required this.driverName,
    required this.driverMobile,
    required this.isExited,
  });
}
