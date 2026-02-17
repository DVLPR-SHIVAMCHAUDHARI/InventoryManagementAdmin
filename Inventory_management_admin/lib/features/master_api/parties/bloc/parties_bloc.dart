import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'parties_event.dart';
import 'parties_state.dart';

class PartyBloc extends Bloc<PartyEvent, PartyState> {
  final MasterRepo repo;

  PartyBloc(this.repo) : super(const PartyInitial()) {
    on<FetchParties>(_onFetchParties);
    on<CreateParty>(_onCreateParty);
    on<UpdateParty>(_onUpdateParty);
    on<DeleteParty>(_onDeleteParty);
  }

  /// =======================
  /// FETCH PARTIES
  /// =======================
  Future<void> _onFetchParties(
    FetchParties event,
    Emitter<PartyState> emit,
  ) async {
    emit(const PartyLoading());
    try {
      final parties = await repo.fetchParties();
      emit(PartyLoaded(parties));
    } catch (e) {
      emit(PartyError(e.toString()));
    }
  }

  /// =======================
  /// CREATE PARTY
  /// =======================
  Future<void> _onCreateParty(
    CreateParty event,
    Emitter<PartyState> emit,
  ) async {
    emit(const CreatePartyLoading());
    try {
      await repo.createParty(
        partyName: event.partyName,
        companyAddress: event.companyAddress,
        departmentLocation: event.departmentLocation,
      );

      emit(const CreatePartySuccess("Party created successfully"));

      /// 🔁 Refresh list
      final parties = await repo.fetchParties();
      emit(PartyLoaded(parties));
    } catch (e) {
      emit(CreatePartyFailure(e.toString()));
    }
  }

  /// =======================
  /// UPDATE PARTY
  /// =======================
  Future<void> _onUpdateParty(
    UpdateParty event,
    Emitter<PartyState> emit,
  ) async {
    emit(const UpdatePartyLoading());
    try {
      await repo.updateParty(
        id: event.id,
        partyName: event.partyName,
        companyAddress: event.companyAddress,
        boxLocation: event.boxLocation,
      );

      emit(const UpdatePartySuccess("Party updated successfully"));

      /// 🔁 Refresh list
      final parties = await repo.fetchParties();
      emit(PartyLoaded(parties));
    } catch (e) {
      emit(UpdatePartyFailure(e.toString()));
    }
  }

  /// =======================
  /// DELETE PARTY
  /// =======================
  Future<void> _onDeleteParty(
    DeleteParty event,
    Emitter<PartyState> emit,
  ) async {
    emit(const DeletePartyLoading());
    try {
      await repo.deleteParty(id: event.id);

      emit(const DeletePartySuccess("Party deleted successfully"));

      /// 🔁 Refresh list
      final parties = await repo.fetchParties();
      emit(PartyLoaded(parties));
    } catch (e) {
      emit(DeletePartyFailure(e.toString()));
    }
  }
}
