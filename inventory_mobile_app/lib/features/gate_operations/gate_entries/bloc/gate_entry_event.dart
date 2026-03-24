import 'package:equatable/equatable.dart';

abstract class GateEntryEvent extends Equatable {
  const GateEntryEvent();

  @override
  List<Object?> get props => [];
}

class SubmitGateEntryEvent extends GateEntryEvent {
  final String date;
  final String time;

  final int truckType; // 1 = Filled, 2 = Empty

  final String vehicleNo;
  final String driverName;
  final String driverMobileNo;
  final int vehicleWeight;

  final String? invoiceNo; // optional
  final int? partyId; // optional

  const SubmitGateEntryEvent({
    required this.date,
    required this.time,
    required this.truckType,
    required this.vehicleNo,
    required this.driverName,
    required this.driverMobileNo,
    required this.vehicleWeight,
    this.invoiceNo,
    this.partyId,
  });

  @override
  List<Object?> get props => [
    date,
    time,
    truckType,
    vehicleNo,
    driverName,
    driverMobileNo,
    vehicleWeight,
    invoiceNo,
    partyId,
  ];
}

class FetchGateEntries extends GateEntryEvent {
  final int truckType; // 1 = Raw, 2 = Empty
  final String date;

  const FetchGateEntries({required this.truckType, required this.date});

  @override
  List<Object?> get props => [truckType, date];
}

class UpdateGateEntryEvent extends GateEntryEvent {
  final int id;
  final int truckType;

  final String driverName;
  final String vehicleNo;
  final int vehicleWeight;
  final String driverMobileNo;

  final String date;
  final String time;

  final String? invoiceId;
  final int? partyId;

  const UpdateGateEntryEvent({
    required this.id,
    required this.truckType,
    required this.driverName,
    required this.vehicleNo,
    required this.vehicleWeight,
    required this.driverMobileNo,
    required this.date,
    required this.time,
    this.invoiceId,
    this.partyId,
  });

  @override
  List<Object?> get props => [
    id,
    truckType,
    driverName,
    vehicleNo,
    vehicleWeight,
    driverMobileNo,
    date,
    time,
    invoiceId,
    partyId,
  ];
}

class DeleteGateEntryEvent extends GateEntryEvent {
  final int id;
  final int truckType;

  const DeleteGateEntryEvent({required this.id, required this.truckType});

  @override
  List<Object?> get props => [id, truckType];
}
