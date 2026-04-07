// bottle_size_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/features/master/master_model/bottle_size_model.dart';
import 'package:inventory_mobile_app/features/master/master_repository/master_repo.dart';

// Events
abstract class BottleSizeEvent {}

class FetchBottleSizes extends BottleSizeEvent {}

// States
abstract class BottleSizeState {}

class BottleSizeInitial extends BottleSizeState {}

class BottleSizeLoading extends BottleSizeState {}

class BottleSizeLoaded extends BottleSizeState {
  final List<BottleSizeModel> sizes;
  BottleSizeLoaded(this.sizes);
}

class BottleSizeError extends BottleSizeState {
  final String message;
  BottleSizeError(this.message);
}

class BottleSizeBloc extends Bloc<BottleSizeEvent, BottleSizeState> {
  final MasterRepo repository;

  BottleSizeBloc({required this.repository}) : super(BottleSizeInitial()) {
    on<FetchBottleSizes>(_onFetchBottleSizes);
  }

  Future<void> _onFetchBottleSizes(
    FetchBottleSizes event,
    Emitter<BottleSizeState> emit,
  ) async {
    emit(BottleSizeLoading());
    try {
      final response = await repository.fetchBottleSizes();
      final sizes = (response as List)
          .map((e) => BottleSizeModel.fromJson(e))
          .toList();
      emit(BottleSizeLoaded(sizes));
    } catch (e) {
      emit(BottleSizeError(e.toString()));
    }
  }
}
