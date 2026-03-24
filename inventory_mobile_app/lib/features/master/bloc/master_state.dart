import 'package:equatable/equatable.dart';
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
