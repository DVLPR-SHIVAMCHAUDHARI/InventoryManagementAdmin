import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';
import 'unloading_event.dart';
import 'unloading_state.dart';

class UnloadingBloc extends Bloc<UnloadingEvent, UnloadingState> {
  final UnloadingRepository repo;

  UnloadingBloc({required this.repo}) : super(UnloadingInitial()) {
    /// =========================
    /// SUBMIT BOTTLE
    /// =========================
    on<SubmitBottleEntry>((event, emit) async {
      emit(BottleEntryLoading());

      try {
        final result = await repo.rawBottleEntry(
          gateId: 1,
          palletUniqueCode: event.palletCode,
          casesQuantity: event.casesQuantity,
          mappingBottle: event.mappingBottle,
          combinationBottleBoxes: event.combinationBottleBoxes,
        );

        emit(BottleEntrySuccess(result));
      } catch (e) {
        emit(BottleEntryFailure(e.toString()));
      }
    });

    on<UpdateBottleEntry>((event, emit) async {
      emit(BottleEntryLoading());

      try {
        final result = await repo.updateBottleEntry(
          id: event.id,
          gateId: 1,
          palletUniqueCode: event.palletCode,
          casesQuantity: event.casesQuantity,
          mappingBottle: event.mappingBottle,
          combinationBottleBoxes: event.combinationBottleBoxes,
        );

        emit(BottleEntrySuccess(result));
      } catch (e) {
        emit(BottleEntryFailure(e.toString()));
      }
    });
    on<DeleteBottleEntry>((event, emit) async {
      emit(BottleEntryLoading());

      try {
        final result = await repo.deleteBottleEntry(id: event.id);

        emit(BottleEntrySuccess(result));
      } catch (e) {
        emit(BottleEntryFailure(e.toString()));
      }
    });

    /// =========================
    /// SUBMIT CAP
    /// =========================
    on<SubmitCapEntry>((event, emit) async {
      emit(CapEntryLoading());

      try {
        await repo.rawCapEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          capId: event.capId,
          rackId: event.warehouseId,
        );

        emit(CapEntrySuccess());
      } catch (e) {
        emit(CapEntryFailure(e.toString()));
      }
    });

    /// =========================
    /// SUBMIT LABEL
    /// =========================
    on<SubmitLabelEntry>((event, emit) async {
      emit(LabelEntryLoading());

      try {
        final result = await repo.rawLabelEntry(
          gateId: 1,
          palletUniqueCode: event.palletCode,
          casesQuantity: event.casesQuantity,
          mappingLabel: event.mappingLabel,
          rollPerCase: event.rollPerCase,
          labelPerRoll: event.labelPerRoll,
        );

        emit(LabelEntrySuccess(result));
      } catch (e) {
        emit(LabelEntryFailure(e.toString()));
      }
    });

    on<UpdateLabelEntry>((event, emit) async {
      emit(LabelEntryLoading());

      try {
        final result = await repo.updateLabelEntry(
          id: event.id,
          gateId: 1,
          palletUniqueCode: event.palletCode,
          casesQuantity: event.casesQuantity,
          mappingLabel: event.mappingLabel,
          rollPerCase: event.rollPerCase,
          labelPerRoll: event.labelPerRoll,
        );

        emit(LabelEntrySuccess(result));
      } catch (e) {
        emit(LabelEntryFailure(e.toString()));
      }
    });

    on<DeleteLabelEntry>((event, emit) async {
      emit(LabelEntryLoading());

      try {
        final result = await repo.deleteLabelEntry(id: event.id);

        emit(LabelEntrySuccess(result));
      } catch (e) {
        emit(LabelEntryFailure(e.toString()));
      }
    });

    /// =========================
    /// SUBMIT CARTON
    /// =========================
    on<SubmitCartonEntry>((event, emit) async {
      emit(CartonEntryLoading());

      try {
        await repo.rawCartonEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          cartonId: event.cartonId,
          rackId: event.warehouseId,
        );

        emit(CartonEntrySuccess());
      } catch (e) {
        emit(CartonEntryFailure(e.toString()));
      }
    });

    /// =========================
    /// SUBMIT MONO CARTON
    /// =========================
    on<SubmitMonoCartonEntry>((event, emit) async {
      emit(MonoCartonEntryLoading());

      try {
        await repo.rawMonoCartonEntry(
          gateId: event.gateId,
          palletUniqueCode: event.palletCode,
          palletQuanitity: event.palletQty,
          monoCartonId: event.monocartonId,
          rackId: event.warehouseId,
        );

        emit(MonoCartonEntrySuccess());
      } catch (e) {
        emit(MonoCartonEntryFailure(e.toString()));
      }
    });
  }
}
