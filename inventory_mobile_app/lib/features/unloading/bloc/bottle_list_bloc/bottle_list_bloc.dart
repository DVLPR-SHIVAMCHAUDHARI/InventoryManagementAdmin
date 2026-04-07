import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/models/bottleunloading_model.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';

/// =========================
/// EVENTS
/// =========================

abstract class BottleListEvent {}

class FetchBottleListEvent extends BottleListEvent {
  final String fromDate;
  final String toDate;

  FetchBottleListEvent({required this.fromDate, required this.toDate});
}

/// =========================
/// STATES
/// =========================

abstract class BottleListState {}

class BottleListInitial extends BottleListState {}

class BottleListLoading extends BottleListState {}

class BottleListSuccess extends BottleListState {
  final List<BottleUnloadingModel> list;

  BottleListSuccess(this.list);
}

class BottleListFailure extends BottleListState {
  final String error;

  BottleListFailure(this.error);
}

/// =========================
/// BLOC
/// =========================

class BottleListBloc extends Bloc<BottleListEvent, BottleListState> {
  final UnloadingRepository repo;

  BottleListBloc({required this.repo}) : super(BottleListInitial()) {
    on<FetchBottleListEvent>((event, emit) async {
      emit(BottleListLoading());

      try {
        final list = await repo.fetchBottleUnloadingList(
          fromDate: event.fromDate,
          toDate: event.toDate,
        );

        emit(BottleListSuccess(list));
      } catch (e) {
        emit(BottleListFailure(e.toString()));
      }
    });
  }
}
