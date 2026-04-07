import 'package:equatable/equatable.dart';

abstract class MasterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBottleListEvent extends MasterEvent {}

class GetCapListEvent extends MasterEvent {}

class GetLabelListEvent extends MasterEvent {}

class GetCartonListEvent extends MasterEvent {}

class GetMonoCartonListEvent extends MasterEvent {}

/// ==========================
/// FETCH MAPPING BOTTLE
/// ==========================
class FetchMappingBottleEvent extends MasterEvent {
  final int? brandNameId;
  final int? bottleSizeId;

  FetchMappingBottleEvent({this.brandNameId, this.bottleSizeId});

  @override
  List<Object?> get props => [brandNameId, bottleSizeId];
}

/// ==========================
/// FETCH COMBINATION BOTTLE
/// ==========================
class FetchCombinationBottleEvent extends MasterEvent {
  FetchCombinationBottleEvent();
}

/// ==========================
/// FETCH MAPPING LABEL
/// ==========================
class FetchMappingLabelEvent extends MasterEvent {
  final int? brandNameId;
  final int? bottleSizeId;
  final int? labelTypeId;

  FetchMappingLabelEvent({
    this.brandNameId,
    this.bottleSizeId,
    this.labelTypeId,
  });

  @override
  List<Object?> get props => [brandNameId, bottleSizeId, labelTypeId];
}
