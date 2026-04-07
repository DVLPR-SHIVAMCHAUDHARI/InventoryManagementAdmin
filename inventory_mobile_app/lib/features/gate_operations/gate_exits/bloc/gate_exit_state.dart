import 'package:equatable/equatable.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/model/gate_exit_model.dart';

abstract class GateExitState extends Equatable {
  const GateExitState();

  @override
  List<Object?> get props => [];
}

/// 🔹 Initial
class GateExitInitial extends GateExitState {}

/// 🔹 Loading (API call in progress)
class GateExitLoading extends GateExitState {}

/// 🔹 Success
class GateExitSuccess extends GateExitState {
  final String message;

  const GateExitSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// 🔹 Failure
class GateExitFailure extends GateExitState {
  final String message;

  const GateExitFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GateExitListLoading extends GateExitState {}

class GateExitListSuccess extends GateExitState {
  final List<GateExitModel> exits;
  const GateExitListSuccess(this.exits);
}

class GateExitListFailure extends GateExitState {
  final String message;
  const GateExitListFailure(this.message);
}

class GateExitUpdateSuccess extends GateExitState {
  final String message;
  const GateExitUpdateSuccess(this.message);
}

class GateExitUpdateFailure extends GateExitState {
  final String message;
  const GateExitUpdateFailure(this.message);
}

class GateExitDeleteSuccess extends GateExitState {
  final String message;
  const GateExitDeleteSuccess(this.message);
}

class GateExitDeleteFailure extends GateExitState {
  final String message;
  const GateExitDeleteFailure(this.message);
}
