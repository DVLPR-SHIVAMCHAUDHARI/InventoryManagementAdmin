import 'package:equatable/equatable.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/box_size_model.dart';

abstract class BoxSizeState extends Equatable {
  const BoxSizeState();

  @override
  List<Object?> get props => [];
}

/// =======================
/// FETCH
/// =======================
class BoxSizeInitial extends BoxSizeState {
  const BoxSizeInitial();
}

class BoxSizeLoading extends BoxSizeState {
  const BoxSizeLoading();
}

class BoxSizeLoaded extends BoxSizeState {
  final List<BoxSizeModel> sizes;

  const BoxSizeLoaded(this.sizes);

  @override
  List<Object?> get props => [sizes];
}

class BoxSizeError extends BoxSizeState {
  final String message;

  const BoxSizeError(this.message);

  @override
  List<Object?> get props => [message];
}

/// =======================
/// CREATE
/// =======================
class CreateBoxSizeLoading extends BoxSizeState {
  const CreateBoxSizeLoading();
}

class CreateBoxSizeSuccess extends BoxSizeState {
  final String message;

  const CreateBoxSizeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateBoxSizeFailure extends BoxSizeState {
  final String error;

  const CreateBoxSizeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// =======================
/// UPDATE
/// =======================
class UpdateBoxSizeLoading extends BoxSizeState {
  const UpdateBoxSizeLoading();
}

class UpdateBoxSizeSuccess extends BoxSizeState {
  final String message;

  const UpdateBoxSizeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateBoxSizeFailure extends BoxSizeState {
  final String error;

  const UpdateBoxSizeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// =======================
/// DELETE
/// =======================
class DeleteBoxSizeLoading extends BoxSizeState {
  const DeleteBoxSizeLoading();
}

class DeleteBoxSizeSuccess extends BoxSizeState {
  final String message;

  const DeleteBoxSizeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteBoxSizeFailure extends BoxSizeState {
  final String error;

  const DeleteBoxSizeFailure(this.error);

  @override
  List<Object?> get props => [error];
}
