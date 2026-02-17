import 'package:equatable/equatable.dart';

abstract class DepartmentEvent extends Equatable {
  const DepartmentEvent();

  @override
  List<Object?> get props => [];
}

class FetchDepartments extends DepartmentEvent {
  const FetchDepartments();
}

class CreateDepartment extends DepartmentEvent {
  final String departmentName;

  const CreateDepartment({required this.departmentName});

  @override
  List<Object?> get props => [departmentName];
}

class UpdateDepartment extends DepartmentEvent {
  final String departmentId;
  final String departmentName;

  const UpdateDepartment({
    required this.departmentId,
    required this.departmentName,
  });

  @override
  List<Object?> get props => [departmentId, departmentName];
}

class DeleteDepartment extends DepartmentEvent {
  final String departmentId;

  const DeleteDepartment({required this.departmentId});

  @override
  List<Object?> get props => [departmentId];
}
