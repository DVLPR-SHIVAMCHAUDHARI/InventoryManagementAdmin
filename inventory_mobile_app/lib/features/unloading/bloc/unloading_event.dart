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
  final String palletCode;
  final int casesQuantity;
  final int mappingBottle;
  final int combinationBottleBoxes;

  const SubmitBottleEntry({
    required this.palletCode,
    required this.casesQuantity,
    required this.mappingBottle,
    required this.combinationBottleBoxes,
  });

  @override
  List<Object?> get props => [
    palletCode,
    casesQuantity,
    mappingBottle,
    combinationBottleBoxes,
  ];
}

class UpdateBottleEntry extends UnloadingEvent {
  final int id;
  final String palletCode;
  final int casesQuantity;
  final int mappingBottle;
  final int combinationBottleBoxes;

  UpdateBottleEntry({
    required this.id,
    required this.palletCode,
    required this.casesQuantity,
    required this.mappingBottle,
    required this.combinationBottleBoxes,
  });
  @override
  List<Object?> get props => [
    id,
    palletCode,
    casesQuantity,
    mappingBottle,
    combinationBottleBoxes,
  ];
}

class DeleteBottleEntry extends UnloadingEvent {
  final int id;

  const DeleteBottleEntry({required this.id});

  @override
  List<Object?> get props => [id];
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

/// ==========================
/// SUBMIT LABEL ENTRY
/// ==========================
class SubmitLabelEntry extends UnloadingEvent {
  final String palletCode;
  final int casesQuantity;
  final int mappingLabel;
  final int rollPerCase;
  final int labelPerRoll;

  const SubmitLabelEntry({
    required this.palletCode,
    required this.casesQuantity,
    required this.mappingLabel,
    required this.rollPerCase,
    required this.labelPerRoll,
  });

  @override
  List<Object?> get props => [
    palletCode,
    casesQuantity,
    mappingLabel,
    rollPerCase,
    labelPerRoll,
  ];
}

/// ==========================
/// UPDATE LABEL ENTRY
/// ==========================
class UpdateLabelEntry extends UnloadingEvent {
  final int id;
  final String palletCode;
  final int casesQuantity;
  final int mappingLabel;
  final int rollPerCase;
  final int labelPerRoll;

  UpdateLabelEntry({
    required this.id,
    required this.palletCode,
    required this.casesQuantity,
    required this.mappingLabel,
    required this.rollPerCase,
    required this.labelPerRoll,
  });

  @override
  List<Object?> get props => [
    id,
    palletCode,
    casesQuantity,
    mappingLabel,
    rollPerCase,
    labelPerRoll,
  ];
}

/// ==========================
/// DELETE LABEL ENTRY
/// ==========================
class DeleteLabelEntry extends UnloadingEvent {
  final int id;

  const DeleteLabelEntry({required this.id});

  @override
  List<Object?> get props => [id];
}
