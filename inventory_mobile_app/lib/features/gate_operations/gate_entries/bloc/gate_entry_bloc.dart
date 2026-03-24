import 'package:bloc/bloc.dart';
import 'package:inventory_mobile_app/core/consts/globals.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/bloc/gate_entry_state.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_entries/repository/gate_entry_repo.dart';

class GateEntryBloc extends Bloc<GateEntryEvent, GateEntryState> {
  final GateEntryRepo repo = GateEntryRepo();

  GateEntryBloc() : super(GateEntryInitial()) {
    on<SubmitGateEntryEvent>(_submitGateEntry);
    on<UpdateGateEntryEvent>(_updateGateEntry);
    on<FetchGateEntries>(_fetchGateEntries);
    on<DeleteGateEntryEvent>(_deleteGateEntry);
  }

  Future<void> _submitGateEntry(
    SubmitGateEntryEvent event,
    Emitter<GateEntryState> emit,
  ) async {
    emit(GateEntryLoading());

    try {
      final result = await repo.gateEntry(
        date: event.date,
        time: event.time,
        truckType: event.truckType,
        vehicleNo: event.vehicleNo,
        driverName: event.driverName,
        driverMobileNo: event.driverMobileNo,
        vehicleWeight: event.vehicleWeight,

        // ✅ send only if filled
        invoiceId: event.truckType == 1 ? event.invoiceNo : null,
        partyId: event.truckType == 1 ? event.partyId : null,
      );

      if (result["success"] != true) {
        emit(
          GateEntryFailure(result["message"] ?? "Failed to submit gate entry."),
        );
        return;
      }

      emit(
        GateEntrySuccess(
          result["message"] ?? "Gate entry submitted successfully.",
        ),
      );
    } catch (e) {
      emit(GateEntryFailure("Failed to submit gate entry."));
    }
  }

  Future<void> _fetchGateEntries(
    FetchGateEntries event,
    Emitter<GateEntryState> emit,
  ) async {
    emit(GateEntryListLoading());

    try {
      final entries = await repo.getGateEntries(
        truckType: event.truckType,
        date: event.date,
      );

      emit(GateEntryListSuccess(entries));
    } catch (e) {
      emit(GateEntryListFailure(e.toString()));
    }
  }

  Future<void> _updateGateEntry(
    UpdateGateEntryEvent event,
    Emitter<GateEntryState> emit,
  ) async {
    emit(GateEntryUpdateLoading());

    try {
      final result = await repo.updateGateEntry(
        id: event.id,
        date: event.date,
        time: event.time,
        truckType: event.truckType,
        driverName: event.driverName,
        vehicleNo: event.vehicleNo,
        vehicleWeight: event.vehicleWeight,
        driverMobileNo: event.driverMobileNo,
        invoiceId: event.truckType == 1 ? event.invoiceId : null,
        partyId: event.truckType == 1 ? event.partyId : null,
      );

      if (result["success"] != true) {
        emit(GateEntryUpdateFailure(result["message"]));
        return;
      }

      emit(GateEntryUpdateSuccess(result["message"]));
    } catch (e) {
      emit(GateEntryUpdateFailure(e.toString()));
    }
  }

  Future<void> _deleteGateEntry(
    DeleteGateEntryEvent event,
    Emitter<GateEntryState> emit,
  ) async {
    emit(GateEntryDeleteLoading());

    try {
      final result = await repo.deleteGateEntry(
        id: event.id,
        truckType: event.truckType,
      );

      if (result["success"] != true) {
        emit(GateEntryDeleteFailure(result["message"]));
        return;
      }

      emit(GateEntryDeleteSuccess(result["message"]));
    } catch (e) {
      emit(GateEntryDeleteFailure(e.toString()));
    }
  }
}
