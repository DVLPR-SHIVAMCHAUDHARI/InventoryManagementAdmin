import 'package:equatable/equatable.dart';

abstract class MasterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBottleListEvent extends MasterEvent {}

class GetCapListEvent extends MasterEvent {}

class GetLabelListEvent extends MasterEvent {}

class GetCartonListEvent extends MasterEvent {}

class GetMonoCartonListEvent extends MasterEvent {}

class FetchParties extends MasterEvent {
  FetchParties();
}
