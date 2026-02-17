import 'package:equatable/equatable.dart';

abstract class PartyEvent extends Equatable {
  const PartyEvent();

  @override
  List<Object?> get props => [];
}

/// =======================
/// FETCH
/// =======================
class FetchParties extends PartyEvent {
  const FetchParties();
}

/// =======================
/// CREATE
/// =======================
class CreateParty extends PartyEvent {
  final String partyName;
  final String companyAddress;
  final int departmentLocation;

  const CreateParty({
    required this.partyName,
    required this.companyAddress,
    required this.departmentLocation,
  });

  @override
  List<Object?> get props => [partyName, companyAddress, departmentLocation];
}

/// =======================
/// UPDATE
/// =======================
class UpdateParty extends PartyEvent {
  final int id;
  final String partyName;
  final String companyAddress;
  final int boxLocation;

  const UpdateParty({
    required this.id,
    required this.partyName,
    required this.companyAddress,
    required this.boxLocation,
  });

  @override
  List<Object?> get props => [id, partyName, companyAddress, boxLocation];
}

/// =======================
/// DELETE
/// =======================
class DeleteParty extends PartyEvent {
  final int id;

  const DeleteParty({required this.id});

  @override
  List<Object?> get props => [id];
}
