import 'package:inventory_management_admin_pannel/features/dashboard/models/barcode_model.dart';
import 'package:inventory_management_admin_pannel/features/dashboard/models/history_model.dart';

import 'package:inventory_management_admin_pannel/features/dashboard/models/table_location_model.dart';

abstract class DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<CurrentLocationModel> locations;
  final List<BarcodeModel> barcodes;
  final int? selectedLocation;
  final int totalCount;
  final int currentPage;
  final Map<int, int> stageCounts;

  final bool historyLoading;
  final Map<int, List<HistoryModel>> historyMap;
  final String? historyError;

  DashboardLoaded({
    required this.locations,
    required this.barcodes,
    this.selectedLocation,
    required this.totalCount,
    required this.currentPage,
    required this.stageCounts,
    this.historyLoading = false,
    this.historyMap = const {},
    this.historyError,
  });

  DashboardLoaded copyWith({
    bool? historyLoading,
    Map<int, List<HistoryModel>>? historyMap,
    String? historyError,
  }) {
    return DashboardLoaded(
      locations: locations,
      barcodes: barcodes,
      selectedLocation: selectedLocation,
      totalCount: totalCount,
      currentPage: currentPage,
      stageCounts: stageCounts,
      historyLoading: historyLoading ?? this.historyLoading,
      historyMap: historyMap ?? this.historyMap,
      historyError: historyError,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

/// ===============================
/// BARCODE HISTORY STATES
/// ===============================
class BarcodeHistoryLoading extends DashboardState {}

class BarcodeHistoryLoaded extends DashboardState {
  final List<HistoryModel> history;

  BarcodeHistoryLoaded({required this.history});
}

class BarcodeHistoryError extends DashboardState {
  final String message;

  BarcodeHistoryError(this.message);
}
