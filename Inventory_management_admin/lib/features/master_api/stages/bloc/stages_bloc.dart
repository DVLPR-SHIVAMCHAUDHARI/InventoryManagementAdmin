import 'package:inventory_management_admin_pannel/core/Utils/globals.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'stages_event.dart';
import 'stages_state.dart';

class StagesBloc extends Bloc<StagesEvent, StagesState> {
  final MasterRepo repo;

  StagesBloc(this.repo) : super(const StagesInitial()) {
    on<FetchStages>(_onFetchStages);
    on<CreateStage>(_onCreateStage);
    on<UpdateStage>(_onUpdateStage);
    on<DeleteStage>(_onDeleteStage);
  }

  /// =======================
  /// FETCH STAGES
  /// =======================
  Future<void> _onFetchStages(
    FetchStages event,
    Emitter<StagesState> emit,
  ) async {
    emit(const StagesLoading());
    try {
      final stages = await repo.fetchStages();
      emit(StagesLoaded(stages));
    } catch (e) {
      emit(StagesError(e.toString()));
    }
  }

  /// =======================
  /// CREATE STAGE
  /// =======================
  Future<void> _onCreateStage(
    CreateStage event,
    Emitter<StagesState> emit,
  ) async {
    emit(const CreateStageLoading());
    try {
      await repo.createStage(stage: event.stage);

      emit(const CreateStageSuccess("Stage created successfully"));

      /// 🔁 Refresh list
      final stages = await repo.fetchStages();
      emit(StagesLoaded(stages));
    } catch (e) {
      emit(CreateStageFailure(e.toString()));
    }
  }

  /// =======================
  /// UPDATE STAGE
  /// =======================
  Future<void> _onUpdateStage(
    UpdateStage event,
    Emitter<StagesState> emit,
  ) async {
    emit(const UpdateStageLoading());
    try {
      await repo.updateStage(id: event.id, stage: event.stage);

      emit(const UpdateStageSuccess("Stage updated successfully"));

      /// 🔁 Refresh list
      final stages = await repo.fetchStages();
      emit(StagesLoaded(stages));
    } catch (e) {
      emit(UpdateStageFailure(e.toString()));
    }
  }

  /// =======================
  /// DELETE STAGE
  /// =======================
  Future<void> _onDeleteStage(
    DeleteStage event,
    Emitter<StagesState> emit,
  ) async {
    emit(const DeleteStageLoading());
    try {
      await repo.deleteStage(id: event.id);

      emit(const DeleteStageSuccess("Stage deleted successfully"));

      /// 🔁 Refresh list
      final stages = await repo.fetchStages();
      emit(StagesLoaded(stages));
    } catch (e) {
      emit(DeleteStageFailure(e.toString()));
    }
  }
}
