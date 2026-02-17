import 'package:equatable/equatable.dart';

abstract class UserManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserManagementInitial extends UserManagementState {}

class CreateUserLoading extends UserManagementState {}

class CreateUserSuccess extends UserManagementState {
  final String message;

  CreateUserSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateUserFailure extends UserManagementState {
  final String error;

  CreateUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

///delete user

class DeleteUserLoading extends UserManagementState {}

class DeleteUserSuccess extends UserManagementState {
  final String message;

  DeleteUserSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeleteUserFailure extends UserManagementState {
  final String error;

  DeleteUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

///Update user

class UpdateUserLoading extends UserManagementState {}

class UpdateUserSuccess extends UserManagementState {
  final String message;

  UpdateUserSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateUserFailure extends UserManagementState {
  final String error;

  UpdateUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

///Update Password

class UpdatePasswordLoading extends UserManagementState {}

class UpdatePasswordSuccess extends UserManagementState {
  final String message;

  UpdatePasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatePasswordFailure extends UserManagementState {
  final String error;

  UpdatePasswordFailure(this.error);

  @override
  List<Object?> get props => [error];
}

///Verify User

class VerifyUserLoading extends UserManagementState {}

class VerifyUserSuccess extends UserManagementState {
  final String message;

  VerifyUserSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyUserFailure extends UserManagementState {
  final String error;

  VerifyUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// unVerify User

class UnVerifyUserLoading extends UserManagementState {}

class UnVerifyUserSuccess extends UserManagementState {
  final String message;

  UnVerifyUserSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UnVerifyUserFailure extends UserManagementState {
  final String error;

  UnVerifyUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// ----------- USER LIST LOADED -----------

class UserListLoading extends UserManagementState {}

class UserListLoaded extends UserManagementState {
  final Map<String, dynamic> users;

  UserListLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UserListFailure extends UserManagementState {
  final String error;

  UserListFailure(this.error);

  @override
  List<Object?> get props => [error];
}
