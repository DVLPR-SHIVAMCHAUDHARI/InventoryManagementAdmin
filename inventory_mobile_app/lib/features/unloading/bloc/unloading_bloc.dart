import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';
import 'unloading_event.dart';
import 'unloading_state.dart';

class UnloadingBloc extends Bloc<UnloadingEvent, UnloadingState> {
  final UnloadingRepository repo;

  UnloadingBloc({required this.repo}) : super(const UnloadingState()) {
    /// =========================
    /// SWITCH EVENTS
    /// =========================

    on<SwitchBottleId>((event, emit) {
      emit(state.copyWith(bottleId: event.bottleId));
    });

    on<SwitchcapId>((event, emit) {
      emit(state.copyWith(capId: event.capId));
    });

    on<SwitchLabelId>((event, emit) {
      emit(state.copyWith(labelId: event.labelId));
    });

    on<SwitchCartonId>((event, emit) {
      emit(state.copyWith(cartonId: event.cartonId));
    });

    on<SwitchmonoCartonId>((event, emit) {
      emit(state.copyWith(monoCartonId: event.monoCartonId));
    });

    /// =========================
    /// SUBMIT BOTTLE
    /// =========================

    on<SubmitBottleEntry>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null));

      try {
        await repo.rawBottleEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          bottleId: event.bottleId,
          rackId: event.warehouseId,
        );

        emit(
          state.copyWith(isSubmitting: false, isSuccess: true, bottleId: null),
        );

        emit(state.copyWith(isSuccess: false));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });

    /// =========================
    /// SUBMIT CAP
    /// =========================

    on<SubmitCapEntry>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null));

      try {
        await repo.rawCapEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          capId: event.capId,
          rackId: event.warehouseId,
        );

        emit(state.copyWith(isSubmitting: false, isSuccess: true, capId: null));

        emit(state.copyWith(isSuccess: false));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });

    /// =========================
    /// SUBMIT LABEL
    /// =========================

    on<SubmitLabelEntry>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null));

      try {
        await repo.rawLabelEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          labelId: event.labelId,
          rackId: event.warehouseId,
        );

        emit(
          state.copyWith(isSubmitting: false, isSuccess: true, labelId: null),
        );

        emit(state.copyWith(isSuccess: false));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });

    /// =========================
    /// SUBMIT CARTON
    /// =========================

    on<SubmitCartonEntry>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null));

      try {
        await repo.rawCartonEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          cartonId: event.cartonId,
          rackId: event.warehouseId,
        );

        emit(
          state.copyWith(isSubmitting: false, isSuccess: true, cartonId: null),
        );

        emit(state.copyWith(isSuccess: false));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });

    /// =========================
    /// SUBMIT MONO CARTON
    /// =========================

    on<SubmitMonoCartonEntry>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null));

      try {
        await repo.rawMonoCartonEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          monoCartonId: event.monocartonId,
          rackId: event.warehouseId,
        );

        emit(
          state.copyWith(
            isSubmitting: false,
            isSuccess: true,
            monoCartonId: null,
          ),
        );

        emit(state.copyWith(isSuccess: false));
      } catch (e) {
        emit(state.copyWith(isSubmitting: false, error: e.toString()));
      }
    });
  }
}
