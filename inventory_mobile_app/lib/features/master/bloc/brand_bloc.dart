// brand_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_mobile_app/features/master/master_model/brand_model.dart';
import 'package:inventory_mobile_app/features/master/master_repository/master_repo.dart';

// Events
abstract class BrandEvent {}

class FetchBrands extends BrandEvent {}

// States
abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandLoaded extends BrandState {
  final List<BrandModel> brands;
  BrandLoaded(this.brands);
}

class BrandError extends BrandState {
  final String message;
  BrandError(this.message);
}

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final MasterRepo repository;

  BrandBloc({required this.repository}) : super(BrandInitial()) {
    on<FetchBrands>(_onFetchBrands);
  }

  Future<void> _onFetchBrands(
    FetchBrands event,
    Emitter<BrandState> emit,
  ) async {
    emit(BrandLoading());
    try {
      final response = await repository.fetchBrands();
      final brands = (response as List)
          .map((e) => BrandModel.fromJson(e))
          .toList();
      emit(BrandLoaded(brands));
    } catch (e) {
      emit(BrandError(e.toString()));
    }
  }
}
