import 'package:equatable/equatable.dart';

abstract class DashboardSummaryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDashboardSummary extends DashboardSummaryEvent {
  final int currentLocation;
  final String barcode;
  final String boxSize;

  LoadDashboardSummary({
    this.currentLocation = 0,
    this.barcode = '',
    this.boxSize = '',
  });
}
