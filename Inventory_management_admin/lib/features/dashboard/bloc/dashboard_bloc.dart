import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_event.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/bloc/dashboard_state.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/models/barcode_model.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/models/history_model.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/repository/dashboard_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepo repo;

  int? _selectedLocation;
  int _currentPage = 1;
  String _barcode = '';
  String _boxSize = '';

  DashboardBloc(this.repo) : super(DashboardLoading()) {
    on<LoadDashboard>(_onLoad);
    on<ChangeLocationEvent>(_onChangeLocation);
    on<ChangePageEvent>(_onChangePage);
    on<ApplyFilterEvent>(_onApplyFilter);
    on<LoadBarcodeHistory>(_onLoadBarcodeHistory);
  }

  Future<void> _onLoad(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final locations = await repo.fetchCurrentLocations();

      final data = await repo.fetchBarcodes(
        currentLocation: _selectedLocation,
        offset: _currentPage,
      );

      emit(
        DashboardLoaded(
          locations: locations,
          barcodes: data['list'],
          totalCount: data['count'],
          selectedLocation: _selectedLocation,
          currentPage: _currentPage,
          stageCounts: _calculateStageCounts(data['list']),
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onChangeLocation(
    ChangeLocationEvent event,
    Emitter<DashboardState> emit,
  ) async {
    _selectedLocation = event.locationId;
    _currentPage = 1;
    add(LoadDashboard());
  }

  Future<void> _onChangePage(
    ChangePageEvent event,
    Emitter<DashboardState> emit,
  ) async {
    _currentPage = event.page;
    add(LoadDashboard());
  }

  Future<void> _onApplyFilter(
    ApplyFilterEvent event,
    Emitter<DashboardState> emit,
  ) async {
    _barcode = event.barcode;
    _boxSize = event.boxSize;
    _currentPage = 1;
    add(LoadDashboard());
  }

  Map<int, int> _calculateStageCounts(List<BarcodeModel> list) {
    final Map<int, int> counts = {};
    for (final b in list) {
      counts[b.currentLocation] = (counts[b.currentLocation] ?? 0) + 1;
    }
    return counts;
  }

  Future<void> _onLoadBarcodeHistory(
    LoadBarcodeHistory event,
    Emitter<DashboardState> emit,
  ) async {
    final current = state;
    if (current is! DashboardLoaded) return;

    emit(current.copyWith(historyLoading: true));

    try {
      final history = await repo.fetchBarcodeHistory(event.barcodeId);

      final updatedMap = Map<int, List<HistoryModel>>.from(current.historyMap);
      updatedMap[event.barcodeId] = history;

      emit(current.copyWith(historyLoading: false, historyMap: updatedMap));
    } catch (e) {
      emit(current.copyWith(historyLoading: false, historyError: e.toString()));
    }
  }
}
