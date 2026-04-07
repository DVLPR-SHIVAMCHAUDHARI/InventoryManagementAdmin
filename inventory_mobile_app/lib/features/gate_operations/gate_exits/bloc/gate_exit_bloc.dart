import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_state.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/repository/gate_exit_repo.dart';

class GateExitBloc extends Bloc<GateExitEvent, GateExitState> {
  final GateExitRepo repo = GateExitRepo();

  GateExitBloc() : super(GateExitInitial()) {
    on<SubmitGateExitEvent>(_submitGateExit);
    on<FetchGateExitsEvent>((event, emit) async {
      emit(GateExitListLoading());
      try {
        final list = await repo.listGateExit(
          truckType: event.truckType,
          exitDate: event.exitDate,
        );
        emit(GateExitListSuccess(list));
      } catch (e) {
        emit(GateExitListFailure(e.toString()));
      }
    });

    on<UpdateGateExitEvent>((event, emit) async {
      emit(GateExitLoading());
      try {
        final result = await repo.updateGateExit(
          id: event.id,
          truckType: event.truckType,
          outVehicleWeight: event.outVehicleWeight,
        );
        if (result["success"] != true) {
          emit(GateExitUpdateFailure(result["message"]));
          return;
        }
        emit(GateExitUpdateSuccess(result["message"]));
      } catch (e) {
        emit(GateExitUpdateFailure(e.toString()));
      }
    });

    on<DeleteGateExitEvent>((event, emit) async {
      emit(GateExitLoading());
      try {
        final result = await repo.deleteGateExit(
          id: event.id,
          truckType: event.truckType,
        );
        if (result["success"] != true) {
          emit(GateExitDeleteFailure(result["message"]));
          return;
        }
        emit(GateExitDeleteSuccess(result["message"]));
      } catch (e) {
        emit(GateExitDeleteFailure(e.toString()));
      }
    });
  }

  Future<void> _submitGateExit(
    SubmitGateExitEvent event,
    Emitter<GateExitState> emit,
  ) async {
    emit(GateExitLoading());

    try {
      final result = await repo.gateExit(
        id: event.id,
        exitDate: event.exitDate,
        exitTime: event.exitTime,
        truckType: event.truckType,

        outVehicleWeight: event.outVehicleWeight,
      );
      if (result["success"] != true) {
        emit(GateExitFailure(result["message"]));
        return;
      }

      emit(GateExitSuccess(result["message"]));
    } catch (e) {
      emit(GateExitFailure(e.toString()));
    }
  }
}
