import 'package:equatable/equatable.dart';

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
