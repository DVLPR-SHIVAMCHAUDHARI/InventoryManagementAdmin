import 'package:inventory_management_admin_pannel/features/dashboard/bloc/blocsummary/summary_dashboard_event.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/blocsummary/summary_dashboard_state.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/repository/dashboard_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardSummaryBloc
    extends Bloc<DashboardSummaryEvent, DashboardSummaryState> {
  final DashboardRepo repo;

  DashboardSummaryBloc(this.repo) : super(DashboardSummaryLoading()) {
    on<LoadDashboardSummary>(_onLoad);
  }

  Future<void> _onLoad(
    LoadDashboardSummary event,
    Emitter<DashboardSummaryState> emit,
  ) async {
    emit(DashboardSummaryLoading());

    try {
      final result = await repo.fetchDashboardSummary(
        currentLocation: event.currentLocation,
        barcode: event.barcode,
        boxSize: event.boxSize,
      );

      emit(
        DashboardSummaryLoaded(
          stageSummary: result.stageSummary,
          warehouses: result.warehouses,
          parties: result.parties,
        ),
      );
    } catch (e) {
      emit(DashboardSummaryError(e.toString()));
    }
  }
}
