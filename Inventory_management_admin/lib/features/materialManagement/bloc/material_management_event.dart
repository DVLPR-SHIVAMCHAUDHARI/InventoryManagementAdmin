import 'package:equatable/equatable.dart';

abstract class MaterialManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateBottleEntryEvent extends MaterialManagementEvent {
  final int? size;
  final String? partyName;
  final int? totalBottlesPerCase;
  final String? bottleStatus;
  final String? bottleType;

  CreateBottleEntryEvent({
    this.size,
    this.partyName,
    this.totalBottlesPerCase,
    this.bottleStatus,
    this.bottleType,
  });

  @override
  List<Object?> get props => [
    size,
    partyName,
    totalBottlesPerCase,
    bottleStatus,
    bottleType,
  ];
}

class UpdateBottleEntryEvent extends MaterialManagementEvent {
  final int? updateId;
  final int? size;
  final String? partyName;
  final int? totalBottlePerCase;
  final String? bottleStatus;
  final String? bottleType;

  UpdateBottleEntryEvent({
    this.updateId,
    this.size,
    this.partyName,
    this.totalBottlePerCase,
    this.bottleStatus,
    this.bottleType,
  });

  @override
  List<Object?> get props => [
    updateId,
    size,
    partyName,
    totalBottlePerCase,
    bottleStatus,
    bottleType,
  ];
}

class DeleteBottleEntryEvent extends MaterialManagementEvent {
  final int? deleteId;

  DeleteBottleEntryEvent({this.deleteId});

  @override
  List<Object?> get props => [deleteId];
}

class CreateCapEntryEvent extends MaterialManagementEvent {
  final int? size;
  final String? partyName;
  final int? totalCapPerCase;
  final String? capStatus;
  final String? capType;

  CreateCapEntryEvent({
    this.size,
    this.partyName,
    this.totalCapPerCase,
    this.capStatus,
    this.capType,
  });

  @override
  List<Object?> get props => [
    size,
    partyName,
    totalCapPerCase,
    capStatus,
    capType,
  ];
}

class UpdateCapEntryEvent extends MaterialManagementEvent {
  final int? updateId;
  final int? size;
  final String? partyName;
  final int? totalCapPerCase;
  final String? capStatus;
  final String? capType;

  UpdateCapEntryEvent({
    this.updateId,
    this.size,
    this.partyName,
    this.totalCapPerCase,
    this.capStatus,
    this.capType,
  });

  @override
  List<Object?> get props => [
    updateId,
    size,
    partyName,
    totalCapPerCase,
    capStatus,
    capType,
  ];
}

class DeleteCapEntryEvent extends MaterialManagementEvent {
  final int? deleteId;

  DeleteCapEntryEvent({this.deleteId});

  @override
  List<Object?> get props => [deleteId];
}

class CreateLableEntryEvent extends MaterialManagementEvent {
  final int size;
  final String partyName;
  final int totalLablePerCase;
  final String lableStatus;
  final String lableType;

  CreateLableEntryEvent({
    required this.size,
    required this.partyName,
    required this.totalLablePerCase,
    required this.lableStatus,
    required this.lableType,
  });
  @override
  List<Object?> get props => [
    size,
    partyName,
    totalLablePerCase,
    lableStatus,
    lableType,
  ];
}

class UpdateLableEntryEvent extends MaterialManagementEvent {
  final int updateId;
  final int size;
  final String partyName;
  final int totalLablePerCase;
  final String lableStatus;
  final String lableType;

  UpdateLableEntryEvent({
    required this.updateId,
    required this.size,
    required this.partyName,
    required this.totalLablePerCase,
    required this.lableStatus,
    required this.lableType,
  });
  @override
  List<Object?> get props => [
    updateId,
    size,
    partyName,
    totalLablePerCase,
    lableStatus,
    lableType,
  ];
}

class DeleteLableEntryEvent extends MaterialManagementEvent {
  final int deleteId;

  DeleteLableEntryEvent({required this.deleteId});
  @override
  List<Object?> get props => [deleteId];
}
////////////////////////////////////////////////////////////
/// CARTON EVENTS
////////////////////////////////////////////////////////////

abstract class CartonEvent extends MaterialManagementEvent {}

class CreateCartonEntryEvent extends MaterialManagementEvent {
  final int size;
  final String partyName;
  final int totalCartonPerCase;
  final String cartonStatus;
  final String cartonType;

  CreateCartonEntryEvent({
    required this.size,
    required this.partyName,
    required this.totalCartonPerCase,
    required this.cartonStatus,
    required this.cartonType,
  });
}

class UpdateCartonEntryEvent extends MaterialManagementEvent {
  final int updateId;
  final int size;
  final String partyName;
  final int totalCartonPerCase;
  final String cartonStatus;
  final String cartonType;

  UpdateCartonEntryEvent({
    required this.updateId,
    required this.size,
    required this.partyName,
    required this.totalCartonPerCase,
    required this.cartonStatus,
    required this.cartonType,
  });
}

class DeleteCartonEntryEvent extends MaterialManagementEvent {
  final int deleteId;

  DeleteCartonEntryEvent({required this.deleteId});
}
////////////////////////////////////////////////////////////
/// MONO CARTON EVENTS
////////////////////////////////////////////////////////////

class CreateMonoCartonEntryEvent extends MaterialManagementEvent {
  final int size;
  final String partyName;
  final int totalMonoCartonPerCase;
  final String monoCartonStatus;
  final String monoCartonType;

  CreateMonoCartonEntryEvent({
    required this.size,
    required this.partyName,
    required this.totalMonoCartonPerCase,
    required this.monoCartonStatus,
    required this.monoCartonType,
  });
}

class UpdateMonoCartonEntryEvent extends MaterialManagementEvent {
  final int updateId;
  final int size;
  final String partyName;
  final int totalMonoCartonPerCase;
  final String monoCartonStatus;
  final String monoCartonType;

  UpdateMonoCartonEntryEvent({
    required this.updateId,
    required this.size,
    required this.partyName,
    required this.totalMonoCartonPerCase,
    required this.monoCartonStatus,
    required this.monoCartonType,
  });
}

class DeleteMonoCartonEntryEvent extends MaterialManagementEvent {
  final int deleteId;

  DeleteMonoCartonEntryEvent({required this.deleteId});
}
