import 'package:equatable/equatable.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/department_model.dart';

abstract class DepartmentState extends Equatable {
  const DepartmentState();

  @override
  List<Object?> get props => [];
}

/// FETCH
class DepartmentInitial extends DepartmentState {
  const DepartmentInitial();
}

class DepartmentLoading extends DepartmentState {
  const DepartmentLoading();
}

class DepartmentLoaded extends DepartmentState {
  final List<DepartmentModel> departments;

  const DepartmentLoaded(this.departments);

  @override
  List<Object?> get props => [departments];
}

class DepartmentError extends DepartmentState {
  final String message;

  const DepartmentError(this.message);

  @override
  List<Object?> get props => [message];
}

/// CREATE
class CreateDepartmentLoading extends DepartmentState {
  const CreateDepartmentLoading();
}

class CreateDepartmentSuccess extends DepartmentState {
  final String message;

  const CreateDepartmentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateDepartmentFailure extends DepartmentState {
  final String error;

  const CreateDepartmentFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// UPDATE
class UpdateDepartmentLoading extends DepartmentState {
  const UpdateDepartmentLoading();
}

class UpdateDepartmentSuccess extends DepartmentState {
  final String message;

  const UpdateDepartmentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateDepartmentFailure extends DepartmentState {
  final String error;

  const UpdateDepartmentFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// DELETE
class DeleteDepartmentLoading extends DepartmentState {
  const DeleteDepartmentLoading();
}

class DeleteDepartmentSuccess extends DepartmentState {
  final String message;

  const DeleteDepartmentSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteDepartmentFailure extends DepartmentState {
  final String error;

  const DeleteDepartmentFailure(this.error);

  @override
  List<Object?> get props => [error];
}
