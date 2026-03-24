import 'package:equatable/equatable.dart';

class UnloadingState extends Equatable {
  final int? bottleId;
  final int? capId;
  final int? labelId;
  final int? cartonId;
  final int? monoCartonId;

  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const UnloadingState({
    this.bottleId,
    this.capId,
    this.labelId,
    this.cartonId,
    this.monoCartonId,
    this.isSubmitting = false,
    this.isSuccess = false,
    this.error,
  });

  UnloadingState copyWith({
    int? bottleId,
    int? capId,
    int? labelId,
    int? cartonId,
    int? monoCartonId,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return UnloadingState(
      bottleId: bottleId ?? this.bottleId,
      capId: capId ?? this.capId,
      labelId: labelId ?? this.labelId,
      cartonId: cartonId ?? this.cartonId,
      monoCartonId: monoCartonId ?? this.monoCartonId,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    bottleId,
    capId,
    labelId,
    cartonId,
    monoCartonId,
    isSubmitting,
    isSuccess,
    error,
  ];
}
