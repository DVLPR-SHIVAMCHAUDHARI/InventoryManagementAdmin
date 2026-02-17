import 'package:inventory_management_admin_pannel/features/dashboard/models/stage_summary_model.dart';

abstract class DashboardSummaryState {}

class DashboardSummaryLoading extends DashboardSummaryState {}

class DashboardSummaryLoaded extends DashboardSummaryState {
  final StageSummaryModel stageSummary;
  final List<MainLocationSummaryModel> warehouses;
  final List<PartySummaryModel> parties;

  DashboardSummaryLoaded({
    required this.stageSummary,
    required this.warehouses,
    required this.parties,
  });
}

class DashboardSummaryError extends DashboardSummaryState {
  final String message;
  DashboardSummaryError(this.message);
}
