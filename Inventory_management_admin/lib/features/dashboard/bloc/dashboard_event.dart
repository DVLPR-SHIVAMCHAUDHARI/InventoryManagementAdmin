import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDashboard extends DashboardEvent {}

class ChangeLocationEvent extends DashboardEvent {
  final int locationId;
  ChangeLocationEvent(this.locationId);
}

class ChangePageEvent extends DashboardEvent {
  final int page;
  ChangePageEvent(this.page);
}

class ApplyFilterEvent extends DashboardEvent {
  final String barcode;
  final String boxSize;

  ApplyFilterEvent({this.barcode = '', this.boxSize = ''});
}

class LoadBarcodeHistory extends DashboardEvent {
  final int barcodeId;

  LoadBarcodeHistory(this.barcodeId);

  @override
  List<Object?> get props => [barcodeId];
}
