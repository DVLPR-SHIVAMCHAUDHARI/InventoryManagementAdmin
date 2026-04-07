import 'package:equatable/equatable.dart';
import 'package:inventory_mobile_app/features/master/master_model/bottle_combination_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/bottle_size_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/brand_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_bottle_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/mapping_label_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/party_model.dart';

abstract class MasterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MasterStatetInitial extends MasterState {}

///////////////////////////////////////////////////////////
/// BOTTLE LIST
////////////////////////////////////////////////////////////

class GetBottleListLoading extends MasterState {}

class GetBottleListSuccess extends MasterState {
  final List<dynamic> bottles;

  GetBottleListSuccess(this.bottles);

  @override
  List<Object?> get props => [bottles];
}

class GetBottleListFailure extends MasterState {
  final String error;

  GetBottleListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// CAP LIST
////////////////////////////////////////////////////////////

class GetCapListLoading extends MasterState {}

class GetCapListSuccess extends MasterState {
  final List<dynamic> caps;

  GetCapListSuccess(this.caps);

  @override
  List<Object?> get props => [caps];
}

class GetCapListFailure extends MasterState {
  final String error;

  GetCapListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// LABEL LIST
////////////////////////////////////////////////////////////

class GetLabelListLoading extends MasterState {}

class GetLabelListSuccess extends MasterState {
  final List<dynamic> labels;

  GetLabelListSuccess(this.labels);

  @override
  List<Object?> get props => [labels];
}

class GetLabelListFailure extends MasterState {
  final String error;

  GetLabelListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// CARTON LIST
////////////////////////////////////////////////////////////

class GetCartonListLoading extends MasterState {}

class GetCartonListSuccess extends MasterState {
  final List<dynamic> cartons;

  GetCartonListSuccess(this.cartons);

  @override
  List<Object?> get props => [cartons];
}

class GetCartonListFailure extends MasterState {
  final String error;

  GetCartonListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// MONO CARTON LIST
////////////////////////////////////////////////////////////

class GetMonoCartonListLoading extends MasterState {}

class GetMonoCartonListSuccess extends MasterState {
  final List<dynamic> monoCartons;

  GetMonoCartonListSuccess(this.monoCartons);

  @override
  List<Object?> get props => [monoCartons];
}

class GetMonoCartonListFailure extends MasterState {
  final String error;

  GetMonoCartonListFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class PartyInitial extends MasterState {
  PartyInitial();
}

class PartyLoading extends MasterState {
  PartyLoading();
}

class PartyLoaded extends MasterState {
  final List<PartyModel> parties;

  PartyLoaded(this.parties);

  @override
  List<Object?> get props => [parties];
}

class PartyError extends MasterState {
  final String message;

  PartyError(this.message);

  @override
  List<Object?> get props => [message];
}

class BrandLoading extends MasterState {
  BrandLoading();
}

class BrandLoaded extends MasterState {
  final List<BrandModel> brands;

  BrandLoaded(this.brands);

  @override
  List<Object?> get props => [brands];
}

class BrandError extends MasterState {
  final String message;

  BrandError(this.message);

  @override
  List<Object?> get props => [message];
}

class BottleSizeLoading extends MasterState {}

class BottleSizeLoaded extends MasterState {
  final List<BottleSizeModel> sizes;

  BottleSizeLoaded(this.sizes);
}

class BottleSizeError extends MasterState {
  final String error;

  BottleSizeError(this.error);
}
////////////////////////////////////////////////////////////
/// MAPPING BOTTLE LIST
////////////////////////////////////////////////////////////

class GetMappingBottleListLoading extends MasterState {}

class GetMappingBottleListSuccess extends MasterState {
  final List<MappingBottleModel> mappingBottles;

  GetMappingBottleListSuccess(this.mappingBottles);

  @override
  List<Object?> get props => [mappingBottles];
}

class GetMappingBottleListFailure extends MasterState {
  final String error;

  GetMappingBottleListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// COMBINATION BOTTLE LIST
////////////////////////////////////////////////////////////

class GetCombinationBottleListLoading extends MasterState {}

class GetCombinationBottleListSuccess extends MasterState {
  final List<BottleCombinationModel> combinations;

  GetCombinationBottleListSuccess(this.combinations);

  @override
  List<Object?> get props => [combinations];
}

class GetCombinationBottleListFailure extends MasterState {
  final String error;

  GetCombinationBottleListFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class GetMappingLabelListLoading extends MasterState {}

class GetMappingLabelListSuccess extends MasterState {
  final List<MappingLabelModel> mappingLabels;

  GetMappingLabelListSuccess(this.mappingLabels);

  @override
  List<Object?> get props => [mappingLabels];
}

class GetMappingLabelListFailure extends MasterState {
  final String error;

  GetMappingLabelListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
