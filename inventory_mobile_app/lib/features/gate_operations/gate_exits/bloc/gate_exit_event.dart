import 'package:equatable/equatable.dart';

abstract class GateExitEvent extends Equatable {
  const GateExitEvent();

  @override
  List<Object?> get props => [];
}

class SubmitGateExitEvent extends GateExitEvent {
  final int id;
  final int truckType;
  final int outVehicleWeight;

  final String exitDate;
  final String exitTime;

  const SubmitGateExitEvent({
    required this.id,
    required this.truckType,
    required this.outVehicleWeight,

    required this.exitDate,
    required this.exitTime,
  });

  @override
  List<Object?> get props => [
    id,
    truckType,
    outVehicleWeight,

    exitDate,
    exitTime,
  ];
}

class FetchGateExitsEvent extends GateExitEvent {
  final int truckType;
  final String exitDate;

  const FetchGateExitsEvent({required this.truckType, required this.exitDate});
}

class UpdateGateExitEvent extends GateExitEvent {
  final int id;
  final int truckType;
  final int outVehicleWeight;

  const UpdateGateExitEvent({
    required this.id,
    required this.truckType,
    required this.outVehicleWeight,
  });
}

class DeleteGateExitEvent extends GateExitEvent {
  final int id;
  final int truckType;

  const DeleteGateExitEvent({required this.id, required this.truckType});
}
