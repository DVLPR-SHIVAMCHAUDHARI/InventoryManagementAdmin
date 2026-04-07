import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/features/unloading/models/label_unloading_model.dart';
import 'package:inventory_mobile_app/features/unloading/repository/unloading_repository.dart';

/// =========================
/// EVENTS
/// =========================

abstract class LabelListEvent {}

class FetchLabelListEvent extends LabelListEvent {
  final String fromDate;
  final String toDate;

  final String? palletCode;
  final String? vehicleNo;

  final int? partyNameId;
  final int? brandId;
  final int? bottleSizeId;

  FetchLabelListEvent({
    required this.fromDate,
    required this.toDate,
    this.palletCode,
    this.vehicleNo,
    this.partyNameId,
    this.brandId,
    this.bottleSizeId,
  });
}

/// =========================
/// STATES
/// =========================

abstract class LabelListState {}

class LabelListInitial extends LabelListState {}

class LabelListLoading extends LabelListState {}

class LabelListSuccess extends LabelListState {
  final List<LabelUnloadingModel> list;

  LabelListSuccess(this.list);
}

class LabelListFailure extends LabelListState {
  final String error;

  LabelListFailure(this.error);
}

/// =========================
/// BLOC
/// =========================

class LabelListBloc extends Bloc<LabelListEvent, LabelListState> {
  final UnloadingRepository repo;

  LabelListBloc({required this.repo}) : super(LabelListInitial()) {
    on<FetchLabelListEvent>((event, emit) async {
      try {
        final list = await repo.fetchLabelUnloadingList(
          fromDate: event.fromDate,
          toDate: event.toDate,
          palletCode: event.palletCode,
          vehicleNo: event.vehicleNo,
          partyName: event.partyNameId,
          brandName: event.brandId,
          bottleSize: event.bottleSizeId,
        );
        print(
          "EVENT → ${event.palletCode}, ${event.vehicleNo}, ${event.partyNameId}",
        );
        print("RESULT LENGTH → ${list.length}");

        emit(LabelListSuccess(List.from(list))); // 👈 important
      } catch (e) {
        emit(LabelListFailure(e.toString()));
      }
    });
  }
}
