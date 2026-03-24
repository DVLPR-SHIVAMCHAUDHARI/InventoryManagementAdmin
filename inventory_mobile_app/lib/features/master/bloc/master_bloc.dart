import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/core/consts/globals.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_event.dart';
import 'package:inventory_mobile_app/features/master/bloc/master_state.dart';
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
    on<FetchParties>(_onFetchParties);
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

  Future<void> _onFetchParties(
    FetchParties event,
    Emitter<MasterState> emit,
  ) async {
    emit(PartyLoading());

    try {
      final response = await repository.fetchParties();

      final List<PartyModel> parties = (response as List)
          .map((e) => PartyModel.fromJson(e))
          .toList();

      emit(PartyLoaded(parties));
    } catch (e) {
      emit(PartyError(e.toString()));
    }
  }
}
