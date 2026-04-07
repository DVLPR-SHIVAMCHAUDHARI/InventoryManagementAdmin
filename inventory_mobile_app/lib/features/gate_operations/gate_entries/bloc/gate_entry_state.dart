import 'package:equatable/equatable.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/models/gate_Entry_model.dart';

abstract class GateEntryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GateEntryInitial extends GateEntryState {}

class GateEntryLoading extends GateEntryState {}

class GateEntrySuccess extends GateEntryState {
  final String message;
  GateEntrySuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class GateEntryFailure extends GateEntryState {
  final String message;
  GateEntryFailure(this.message);
}

class GateEntryListLoading extends GateEntryState {}

class GateEntryListSuccess extends GateEntryState {
  final List<GateEntryModel> entries;

  GateEntryListSuccess(this.entries);

  @override
  List<Object?> get props => [entries];
}

class GateEntryListFailure extends GateEntryState {
  final String message;

  GateEntryListFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GateEntryUpdateLoading extends GateEntryState {}

class GateEntryUpdateSuccess extends GateEntryState {
  final String message;

  GateEntryUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class GateEntryUpdateFailure extends GateEntryState {
  final String message;

  GateEntryUpdateFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GateEntryDeleteLoading extends GateEntryState {}

class GateEntryDeleteSuccess extends GateEntryState {
  final String message;

  GateEntryDeleteSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class GateEntryDeleteFailure extends GateEntryState {
  final String message;

  GateEntryDeleteFailure(this.message);

  @override
  List<Object?> get props => [message];
}
