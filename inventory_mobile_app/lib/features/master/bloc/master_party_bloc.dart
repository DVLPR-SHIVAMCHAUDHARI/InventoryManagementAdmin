// party_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/features/master/master_model/party_model.dart';
import 'package:inventory_mobile_app/features/master/master_repository/master_repo.dart';

// Events
abstract class PartyEvent {}

class FetchParties extends PartyEvent {}

// States
abstract class PartyState {}

class PartyInitial extends PartyState {}

class PartyLoading extends PartyState {}

class PartyLoaded extends PartyState {
  final List<PartyModel> parties;
  PartyLoaded(this.parties);
}

class PartyError extends PartyState {
  final String message;
  PartyError(this.message);
}

class PartyBloc extends Bloc<PartyEvent, PartyState> {
  final MasterRepo repository;

  PartyBloc({required this.repository}) : super(PartyInitial()) {
    on<FetchParties>(_onFetchParties);
  }

  Future<void> _onFetchParties(
    FetchParties event,
    Emitter<PartyState> emit,
  ) async {
    emit(PartyLoading());
    try {
      final response = await repository.fetchParties();
      final parties = (response as List)
          .map((e) => PartyModel.fromJson(e))
          .toList();
      emit(PartyLoaded(parties));
    } catch (e) {
      emit(PartyError(e.toString()));
    }
  }
}
