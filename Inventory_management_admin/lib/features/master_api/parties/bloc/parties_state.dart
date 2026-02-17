import 'package:equatable/equatable.dart';
import 'package:inventory_management_admin_pannel/features/master_api/models/party_model.dart';

abstract class PartyState extends Equatable {
  const PartyState();

  @override
  List<Object?> get props => [];
}

/// =======================
/// FETCH
/// =======================
class PartyInitial extends PartyState {
  const PartyInitial();
}

class PartyLoading extends PartyState {
  const PartyLoading();
}

class PartyLoaded extends PartyState {
  final List<PartyModel> parties;

  const PartyLoaded(this.parties);

  @override
  List<Object?> get props => [parties];
}

class PartyError extends PartyState {
  final String message;

  const PartyError(this.message);

  @override
  List<Object?> get props => [message];
}

/// =======================
/// CREATE
/// =======================
class CreatePartyLoading extends PartyState {
  const CreatePartyLoading();
}

class CreatePartySuccess extends PartyState {
  final String message;

  const CreatePartySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class CreatePartyFailure extends PartyState {
  final String error;

  const CreatePartyFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// =======================
/// UPDATE
/// =======================
class UpdatePartyLoading extends PartyState {
  const UpdatePartyLoading();
}

class UpdatePartySuccess extends PartyState {
  final String message;

  const UpdatePartySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdatePartyFailure extends PartyState {
  final String error;

  const UpdatePartyFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// =======================
/// DELETE
/// =======================
class DeletePartyLoading extends PartyState {
  const DeletePartyLoading();
}

class DeletePartySuccess extends PartyState {
  final String message;

  const DeletePartySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class DeletePartyFailure extends PartyState {
  final String error;

  const DeletePartyFailure(this.error);

  @override
  List<Object?> get props => [error];
}
