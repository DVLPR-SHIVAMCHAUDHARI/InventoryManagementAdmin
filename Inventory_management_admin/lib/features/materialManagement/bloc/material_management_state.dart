import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

abstract class MaterialManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MaterialManagementInitial extends MaterialManagementState {}

class CreateBottleEntryLoading extends MaterialManagementState {}

class CreateBottleEntrySuccess extends MaterialManagementState {
  final String message;

  CreateBottleEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateBottleEntryFailure extends MaterialManagementState {
  final String error;

  CreateBottleEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateBottleEntryLoading extends MaterialManagementState {}

class UpdateBottleEntrySuccess extends MaterialManagementState {
  final String message;

  UpdateBottleEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateBottleEntryFailure extends MaterialManagementState {
  final String error;

  UpdateBottleEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class DeleteBottleLoadingState extends MaterialManagementState {}

class DeleteBottleEntrySuccessState extends MaterialManagementState {
  final String message;

  DeleteBottleEntrySuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteBottleFailureState extends MaterialManagementState {
  final String error;

  DeleteBottleFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}

class CreateCapEntryLoading extends MaterialManagementState {}

class CreateCapEntrySuccess extends MaterialManagementState {
  final String message;

  CreateCapEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateCapEntryFailure extends MaterialManagementState {
  final String error;

  CreateCapEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

////////////////////////////////////////////////////////////

class UpdateCapEntryLoading extends MaterialManagementState {}

class UpdateCapEntrySuccess extends MaterialManagementState {
  final String message;

  UpdateCapEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateCapEntryFailure extends MaterialManagementState {
  final String error;

  UpdateCapEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

////////////////////////////////////////////////////////////

class DeleteCapLoadingState extends MaterialManagementState {}

class DeleteCapEntrySuccessState extends MaterialManagementState {
  final String message;

  DeleteCapEntrySuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteCapFailureState extends MaterialManagementState {
  final String error;

  DeleteCapFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// CREATE LABLE
////////////////////////////////////////////////////////////

class CreateLableEntryLoading extends MaterialManagementState {}

class CreateLableEntrySuccess extends MaterialManagementState {
  final String message;

  CreateLableEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateLableEntryFailure extends MaterialManagementState {
  final String error;

  CreateLableEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

////////////////////////////////////////////////////////////
/// UPDATE LABLE
////////////////////////////////////////////////////////////

class UpdateLableEntryLoading extends MaterialManagementState {}

class UpdateLableEntrySuccess extends MaterialManagementState {
  final String message;

  UpdateLableEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateLableEntryFailure extends MaterialManagementState {
  final String error;

  UpdateLableEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

////////////////////////////////////////////////////////////
/// DELETE LABLE
////////////////////////////////////////////////////////////

class DeleteLableLoadingState extends MaterialManagementState {}

class DeleteLableEntrySuccessState extends MaterialManagementState {
  final String message;

  DeleteLableEntrySuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteLableFailureState extends MaterialManagementState {
  final String error;

  DeleteLableFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////
/// CREATE CARTON
////////////////////////////////////////////////////////////

class CreateCartonEntryLoading extends MaterialManagementState {}

class CreateCartonEntrySuccess extends MaterialManagementState {
  final String message;

  CreateCartonEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateCartonEntryFailure extends MaterialManagementState {
  final String error;

  CreateCartonEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

////////////////////////////////////////////////////////////
/// UPDATE CARTON
////////////////////////////////////////////////////////////

class UpdateCartonEntryLoading extends MaterialManagementState {}

class UpdateCartonEntrySuccess extends MaterialManagementState {
  final String message;

  UpdateCartonEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateCartonEntryFailure extends MaterialManagementState {
  final String error;

  UpdateCartonEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

////////////////////////////////////////////////////////////
/// DELETE CARTON
////////////////////////////////////////////////////////////

class DeleteCartonLoadingState extends MaterialManagementState {}

class DeleteCartonEntrySuccessState extends MaterialManagementState {
  final String message;

  DeleteCartonEntrySuccessState({required this.message});

  @override
  List<Object?> get props => [message];
}

class DeleteCartonFailureState extends MaterialManagementState {
  final String error;

  DeleteCartonFailureState({required this.error});

  @override
  List<Object?> get props => [error];
}
////////////////////////////////////////////////////////////