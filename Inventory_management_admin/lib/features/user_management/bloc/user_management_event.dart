import 'package:equatable/equatable.dart';

abstract class UserManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// CREATE USER
class UserSignUpEvent extends UserManagementEvent {
  final String fullname;
  final String email;
  final String password;
  final String departmentId;

  final int roleId;

  UserSignUpEvent({
    required this.fullname,
    required this.email,
    required this.password,
    required this.departmentId,

    required this.roleId,
  });

  @override
  List<Object?> get props => [fullname, email, password, departmentId, roleId];
}

/// DELETE USER
class DeleteUserEvent extends UserManagementEvent {
  final int userId;

  DeleteUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// UPDATE USER (name / email)
class UpdateUserEvent extends UserManagementEvent {
  final int userId;
  final String fullname;
  final String email;
  final int departmentId;

  final int roleId;

  UpdateUserEvent({
    required this.userId,
    required this.fullname,
    required this.email,
    required this.departmentId,

    required this.roleId,
  });

  @override
  List<Object?> get props => [userId, fullname, email, departmentId, roleId];
}

/// UPDATE PASSWORD
class UpdatePasswordEvent extends UserManagementEvent {
  final int userId;
  final String newPassword;

  UpdatePasswordEvent({required this.userId, required this.newPassword});

  @override
  List<Object?> get props => [userId, newPassword];
}

/// VERIFY USER
class VerifyUserEvent extends UserManagementEvent {
  final int userId;

  VerifyUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// UN-VERIFY USER
class UnVerifyUserEvent extends UserManagementEvent {
  final int userId;

  UnVerifyUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// FETCH USER LIST EVENT
class FetchUserListEvent extends UserManagementEvent {
  final String? email;
  final String? fullname;
  final String sortBy;
  final String orderBy;
  final int offset;
  final int limit;

  FetchUserListEvent({
    this.email,
    this.fullname,
    this.sortBy = "id",
    this.orderBy = "asc",
    this.offset = 1,
    this.limit = 10,
  });

  @override
  List<Object?> get props => [email, fullname, sortBy, orderBy, offset, limit];
}
