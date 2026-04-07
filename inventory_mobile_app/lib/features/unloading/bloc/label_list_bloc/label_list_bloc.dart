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
  final String? orderBy;
  final int? limit;

  FetchLabelListEvent({
    required this.fromDate,
    required this.toDate,
    this.palletCode,
    this.vehicleNo,
    this.partyNameId,
    this.brandId,
    this.bottleSizeId,
    this.orderBy,
    this.limit,
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
  final int count;

  LabelListSuccess({required this.list, required this.count});
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
          orderBy: event.orderBy,
          limit: event.limit,
        );

        emit(LabelListSuccess(list: list["list"], count: list["count"]));
      } catch (e) {
        emit(LabelListFailure(e.toString()));
      }
    });
  }
}
