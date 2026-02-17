import 'package:equatable/equatable.dart';

abstract class BoxSizeEvent extends Equatable {
  const BoxSizeEvent();

  @override
  List<Object?> get props => [];
}

/// =======================
/// FETCH
/// =======================
class FetchBoxSizes extends BoxSizeEvent {
  const FetchBoxSizes();
}

/// =======================
/// CREATE
/// =======================
class CreateBoxSize extends BoxSizeEvent {
  final int length;
  final int height;
  final int width;

  const CreateBoxSize({
    required this.length,
    required this.height,
    required this.width,
  });

  @override
  List<Object?> get props => [length, height, width];
}

/// =======================
/// UPDATE
/// =======================
class UpdateBoxSize extends BoxSizeEvent {
  final int id;
  final int length;
  final int height;
  final int width;

  const UpdateBoxSize({
    required this.id,
    required this.length,
    required this.height,
    required this.width,
  });

  @override
  List<Object?> get props => [id, length, height, width];
}

/// =======================
/// DELETE
/// =======================
class DeleteBoxSize extends BoxSizeEvent {
  final int id;

  const DeleteBoxSize({required this.id});

  @override
  List<Object?> get props => [id];
}
