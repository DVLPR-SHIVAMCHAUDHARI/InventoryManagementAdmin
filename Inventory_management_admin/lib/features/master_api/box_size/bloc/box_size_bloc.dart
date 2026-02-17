import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';
import 'box_size_event.dart';
import 'box_size_state.dart';

class BoxSizeBloc extends Bloc<BoxSizeEvent, BoxSizeState> {
  final MasterRepo repo;

  BoxSizeBloc(this.repo) : super(const BoxSizeInitial()) {
    on<FetchBoxSizes>(_onFetchBoxSizes);
    on<CreateBoxSize>(_onCreateBoxSize);
    on<UpdateBoxSize>(_onUpdateBoxSize);
    on<DeleteBoxSize>(_onDeleteBoxSize);
  }

  /// =======================
  /// FETCH BOX SIZES
  /// =======================
  Future<void> _onFetchBoxSizes(
    FetchBoxSizes event,
    Emitter<BoxSizeState> emit,
  ) async {
    emit(const BoxSizeLoading());
    try {
      final sizes = await repo.fetchBoxSizes();
      emit(BoxSizeLoaded(sizes));
    } catch (e) {
      emit(BoxSizeError(e.toString()));
    }
  }

  /// =======================
  /// CREATE BOX SIZE
  /// =======================
  Future<void> _onCreateBoxSize(
    CreateBoxSize event,
    Emitter<BoxSizeState> emit,
  ) async {
    emit(const CreateBoxSizeLoading());
    try {
      await repo.createBoxSize(
        length: event.length,
        height: event.height,
        width: event.width,
      );

      emit(const CreateBoxSizeSuccess("Box size created successfully"));

      /// 🔁 Refresh list after create
      final sizes = await repo.fetchBoxSizes();
      emit(BoxSizeLoaded(sizes));
    } catch (e) {
      emit(CreateBoxSizeFailure(e.toString()));
    }
  }

  /// =======================
  /// UPDATE BOX SIZE
  /// =======================
  Future<void> _onUpdateBoxSize(
    UpdateBoxSize event,
    Emitter<BoxSizeState> emit,
  ) async {
    emit(const UpdateBoxSizeLoading());
    try {
      await repo.updateBoxSize(
        id: event.id,
        length: event.length,
        height: event.height,
        width: event.width,
      );

      emit(const UpdateBoxSizeSuccess("Box size updated successfully"));

      /// 🔁 Refresh list after update
      final sizes = await repo.fetchBoxSizes();
      emit(BoxSizeLoaded(sizes));
    } catch (e) {
      emit(UpdateBoxSizeFailure(e.toString()));
    }
  }

  /// =======================
  /// DELETE BOX SIZE
  /// =======================
  Future<void> _onDeleteBoxSize(
    DeleteBoxSize event,
    Emitter<BoxSizeState> emit,
  ) async {
    emit(const DeleteBoxSizeLoading());
    try {
      await repo.deleteBoxSize(id: event.id);

      emit(const DeleteBoxSizeSuccess("Box size deleted successfully"));

      /// 🔁 Refresh list after delete
      final sizes = await repo.fetchBoxSizes();
      emit(BoxSizeLoaded(sizes));
    } catch (e) {
      emit(DeleteBoxSizeFailure(e.toString()));
    }
  }
}
