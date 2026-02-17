import 'package:equatable/equatable.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/stage_model.dart';

abstract class StagesState extends Equatable {
  const StagesState();

  @override
  List<Object?> get props => [];
}

/// =======================
/// FETCH
/// =======================
class StagesInitial extends StagesState {
  const StagesInitial();
}

class StagesLoading extends StagesState {
  const StagesLoading();
}

class StagesLoaded extends StagesState {
  final List<StageModel> stages;

  const StagesLoaded(this.stages);

  @override
  List<Object?> get props => [stages];
}

class StagesError extends StagesState {
  final String message;

  const StagesError(this.message);

  @override
  List<Object?> get props => [message];
}

/// =======================
/// CREATE
/// =======================
class CreateStageLoading extends StagesState {
  const CreateStageLoading();
}

class CreateStageSuccess extends StagesState {
  final String message;

  const CreateStageSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateStageFailure extends StagesState {
  final String error;

  const CreateStageFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// =======================
/// UPDATE
/// =======================
class UpdateStageLoading extends StagesState {
  const UpdateStageLoading();
}

class UpdateStageSuccess extends StagesState {
  final String message;

  const UpdateStageSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateStageFailure extends StagesState {
  final String error;

  const UpdateStageFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// =======================
/// DELETE
/// =======================
class DeleteStageLoading extends StagesState {
  const DeleteStageLoading();
}

class DeleteStageSuccess extends StagesState {
  final String message;

  const DeleteStageSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteStageFailure extends StagesState {
  final String error;

  const DeleteStageFailure(this.error);

  @override
  List<Object?> get props => [error];
}
