import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_event.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/bloc/gate_exit_state.dart';
import 'package:inventory_mobile_app/features/gate_operations/gate_exits/repository/gate_exit_repo.dart';

class GateExitBloc extends Bloc<GateExitEvent, GateExitState> {
  final GateExitRepo repo = GateExitRepo();

  GateExitBloc() : super(GateExitInitial()) {
    on<SubmitGateExitEvent>(_submitGateExit);
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
