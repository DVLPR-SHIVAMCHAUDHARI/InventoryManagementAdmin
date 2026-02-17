import 'package:equatable/equatable.dart';

abstract class StagesEvent extends Equatable {
  const StagesEvent();

  @override
  List<Object?> get props => [];
}

/// =======================
/// FETCH
/// =======================
class FetchStages extends StagesEvent {
  const FetchStages();
}

/// =======================
/// CREATE
/// =======================
class CreateStage extends StagesEvent {
  final String stage;

  const CreateStage({required this.stage});

  @override
  List<Object?> get props => [stage];
}

/// =======================
/// UPDATE
/// =======================
class UpdateStage extends StagesEvent {
  final int id;
  final String stage;

  const UpdateStage({required this.id, required this.stage});

  @override
  List<Object?> get props => [id, stage];
}

/// =======================
/// DELETE
/// =======================
class DeleteStage extends StagesEvent {
  final int id;

  const DeleteStage({required this.id});

  @override
  List<Object?> get props => [id];
}
