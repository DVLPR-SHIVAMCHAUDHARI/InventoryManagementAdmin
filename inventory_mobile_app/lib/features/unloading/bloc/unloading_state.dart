import 'package:equatable/equatable.dart';

abstract class UnloadingState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial
class UnloadingInitial extends UnloadingState {}

/// Submit Bottle Entry States
class BottleEntryLoading extends UnloadingState {}

class BottleEntrySuccess extends UnloadingState {
  final String message;
  BottleEntrySuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class BottleEntryFailure extends UnloadingState {
  final String error;
  BottleEntryFailure(this.error);
  @override
  List<Object?> get props => [];
}

/// ================= CAP =================
class CapEntryLoading extends UnloadingState {}

class CapEntrySuccess extends UnloadingState {}

class CapEntryFailure extends UnloadingState {
  final String error;
  CapEntryFailure(this.error);
}

/// ================= LABEL =================
class LabelEntryLoading extends UnloadingState {}

class LabelEntrySuccess extends UnloadingState {
  final String message;

  LabelEntrySuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LabelEntryFailure extends UnloadingState {
  final String error;

  LabelEntryFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// ================= CARTON =================
class CartonEntryLoading extends UnloadingState {}

class CartonEntrySuccess extends UnloadingState {}

class CartonEntryFailure extends UnloadingState {
  final String error;
  CartonEntryFailure(this.error);
}

/// ================= MONO CARTON =================
class MonoCartonEntryLoading extends UnloadingState {}

class MonoCartonEntrySuccess extends UnloadingState {}

class MonoCartonEntryFailure extends UnloadingState {
  final String error;
  MonoCartonEntryFailure(this.error);
}
