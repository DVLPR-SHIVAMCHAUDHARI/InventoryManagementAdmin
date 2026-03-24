import 'package:equatable/equatable.dart';

abstract class UnloadingEvent extends Equatable {
  const UnloadingEvent();

  @override
  List<Object?> get props => [];
}

/// Switch Bottle Dropdown
class SwitchBottleId extends UnloadingEvent {
  final int? bottleId;

  const SwitchBottleId(this.bottleId);

  @override
  List<Object?> get props => [bottleId];
}

class SwitchcapId extends UnloadingEvent {
  final int? capId;

  const SwitchcapId(this.capId);

  @override
  List<Object?> get props => [capId];
}

class SwitchLabelId extends UnloadingEvent {
  final int? labelId;

  const SwitchLabelId(this.labelId);

  @override
  List<Object?> get props => [labelId];
}

class SwitchCartonId extends UnloadingEvent {
  final int? cartonId;

  const SwitchCartonId(this.cartonId);

  @override
  List<Object?> get props => [cartonId];
}

class SwitchmonoCartonId extends UnloadingEvent {
  final int? monoCartonId;

  const SwitchmonoCartonId(this.monoCartonId);

  @override
  List<Object?> get props => [monoCartonId];
}

/// Submit Bottle Entry
class SubmitBottleEntry extends UnloadingEvent {
  final int gateId;
  final String palletCode;
  final int palletQty;
  final int bottleId;
  final int warehouseId;

  const SubmitBottleEntry({
    required this.gateId,
    required this.palletCode,
    required this.palletQty,
    required this.bottleId,
    required this.warehouseId,
  });

  @override
  List<Object?> get props => [
    gateId,
    palletCode,
    palletQty,
    bottleId,
    warehouseId,
  ];
}

/// Submit cap Entry
class SubmitCapEntry extends UnloadingEvent {
  final int gateId;
  final String palletCode;
  final int palletQty;
  final int capId;
  final int warehouseId;

  const SubmitCapEntry({
    required this.gateId,
    required this.palletCode,
    required this.palletQty,
    required this.capId,
    required this.warehouseId,
  });

  @override
  List<Object?> get props => [
    gateId,
    palletCode,
    palletQty,
    capId,
    warehouseId,
  ];
}

/// Submit label Entry
class SubmitLabelEntry extends UnloadingEvent {
  final int gateId;
  final String palletCode;
  final int palletQty;
  final int labelId;
  final int warehouseId;

  const SubmitLabelEntry({
    required this.gateId,
    required this.palletCode,
    required this.palletQty,
    required this.labelId,
    required this.warehouseId,
  });

  @override
  List<Object?> get props => [
    gateId,
    palletCode,
    palletQty,
    labelId,
    warehouseId,
  ];
}

/// Submit carton Entry
class SubmitCartonEntry extends UnloadingEvent {
  final int gateId;
  final String palletCode;
  final int palletQty;
  final int cartonId;
  final int warehouseId;

  const SubmitCartonEntry({
    required this.gateId,
    required this.palletCode,
    required this.palletQty,
    required this.cartonId,
    required this.warehouseId,
  });

  @override
  List<Object?> get props => [
    gateId,
    palletCode,
    palletQty,
    cartonId,
    warehouseId,
  ];
}

/// Submit monocarton Entry
class SubmitMonoCartonEntry extends UnloadingEvent {
  final int gateId;
  final String palletCode;
  final int palletQty;
  final int monocartonId;
  final int warehouseId;

  const SubmitMonoCartonEntry({
    required this.gateId,
    required this.palletCode,
    required this.palletQty,
    required this.monocartonId,
    required this.warehouseId,
  });

  @override
  List<Object?> get props => [
    gateId,
    palletCode,
    palletQty,
    monocartonId,
    warehouseId,
  ];
}
