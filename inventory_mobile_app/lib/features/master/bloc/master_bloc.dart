import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/core/consts/globals.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
import 'package:inventory_mobile_app/features/master/master_model/bottle_size_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/brand_model.dart';
import 'package:inventory_mobile_app/features/master/master_model/party_model.dart';
import 'package:inventory_mobile_app/features/master/master_repository/master_repo.dart';

class MasterBloc extends Bloc<MasterEvent, MasterState> {
  MasterRepo repository = MasterRepo();
  MasterBloc() : super(MasterStatetInitial()) {
    on<GetBottleListEvent>(getBottleList);
    on<GetCapListEvent>(getCapList);
    on<GetLabelListEvent>(getLabelList);
    on<GetCartonListEvent>(getCartonList);
    on<GetMonoCartonListEvent>(getMonoCartonList);

    on<FetchMappingBottleEvent>(getMappingBottleList);
    on<FetchMappingLabelEvent>(getMappingLabelList);
    on<FetchCombinationBottleEvent>(getCombinationBottleList);
  }

  Future<void> getBottleList(
    GetBottleListEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetBottleListLoading());

    try {
      final result = await repository.getBottleList();
      emit(GetBottleListSuccess(result));
    } catch (e) {
      emit(GetBottleListFailure(e.toString()));
    }
  }

  Future<void> getCapList(
    GetCapListEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetCapListLoading());

    try {
      final result = await repository.getCapList();
      emit(GetCapListSuccess(result));
    } catch (e) {
      emit(GetCapListFailure(e.toString()));
    }
  }

  Future<void> getLabelList(
    GetLabelListEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetLabelListLoading());

    try {
      final result = await repository.getlabellist();
      emit(GetLabelListSuccess(result));
    } catch (e) {
      emit(GetLabelListFailure(e.toString()));
    }
  }

  Future<void> getCartonList(
    GetCartonListEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetCartonListLoading());

    try {
      final result = await repository.getcartonlist();
      emit(GetCartonListSuccess(result));
    } catch (e) {
      emit(GetCartonListFailure(e.toString()));
    }
  }

  Future<void> getMonoCartonList(
    GetMonoCartonListEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetMonoCartonListLoading());

    try {
      final result = await repository.getmonocartonlist();
      emit(GetMonoCartonListSuccess(result));
    } catch (e) {
      emit(GetMonoCartonListFailure(e.toString()));
    }
  }

  Future<void> getMappingBottleList(
    FetchMappingBottleEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetMappingBottleListLoading());

    try {
      final result = await repository.fetchMappingBottle(
        brandNameId: event.brandNameId,
        bottleSizeId: event.bottleSizeId,
      );

      emit(GetMappingBottleListSuccess(result));
    } catch (e) {
      emit(GetMappingBottleListFailure(e.toString()));
    }
  }

  Future<void> getCombinationBottleList(
    FetchCombinationBottleEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetCombinationBottleListLoading());

    try {
      final result = await repository.fetchCombinationBottle();

      emit(GetCombinationBottleListSuccess(result));
    } catch (e) {
      emit(GetCombinationBottleListFailure(e.toString()));
    }
  }

  Future<void> getMappingLabelList(
    FetchMappingLabelEvent event,
    Emitter<MasterState> emit,
  ) async {
    emit(GetMappingLabelListLoading());

    try {
      final result = await repository.fetchMappingLabel(
        brandNameId: event.brandNameId,
        bottleSizeId: event.bottleSizeId,
        labelTypeId: event.labelTypeId,
      );

      emit(GetMappingLabelListSuccess(result));
    } catch (e) {
      emit(GetMappingLabelListFailure(e.toString()));
    }
  }
}
