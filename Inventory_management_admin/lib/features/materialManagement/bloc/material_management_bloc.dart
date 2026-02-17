import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_event.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/bloc/material_management_state.dart';
import 'package:inventory_management_admin_pannel/features/materialManagement/repository/material_management_repository.dart';

class MaterialManagementBloc
    extends Bloc<MaterialManagementEvent, MaterialManagementState> {
  final MaterialManagementRepository repository =
      MaterialManagementRepository();
  MaterialManagementBloc() : super(MaterialManagementInitial()) {
    on<CreateBottleEntryEvent>(createBottleEntry);
    on<UpdateBottleEntryEvent>(updateBottleEntry);
    on<DeleteBottleEntryEvent>(deleteBottleEntry);
    /////////cap
    on<CreateCapEntryEvent>(createCapEntry);
    on<UpdateCapEntryEvent>(updateCapEntry);
    on<DeleteCapEntryEvent>(deleteCapEntry);
    ///////// lable
    on<CreateLableEntryEvent>(createLableEntry);
    on<UpdateLableEntryEvent>(updateLableEntry);
    on<DeleteLableEntryEvent>(deleteLableEntry);
    // CARTON
    on<CreateCartonEntryEvent>(createCartonEntry);
    on<UpdateCartonEntryEvent>(updateCartonEntry);
    on<DeleteCartonEntryEvent>(deleteCartonEntry);

    // MONO CARTON
    on<CreateMonoCartonEntryEvent>(createMonoCartonEntry);
    on<UpdateMonoCartonEntryEvent>(updateMonoCartonEntry);
    on<DeleteMonoCartonEntryEvent>(deleteMonoCartonEntry);
  }

  createBottleEntry(CreateBottleEntryEvent event, Emitter emit) async {
    emit(CreateBottleEntryLoading());

    try {
      final result = await repository.createBottleEntry(
        size: event.size,
        partyName: event.partyName,
        totalBottlesPerCase: event.totalBottlesPerCase,
        bottleStatus: event.bottleStatus,
        bottleType: event.bottleType,
      );
      emit(
        CreateBottleEntrySuccess("Bottle entry created successfully!$result"),
      );
    } catch (e) {
      emit(CreateBottleEntryFailure("Failed to create bottle entry: $e"));
    }
  }

  updateBottleEntry(UpdateBottleEntryEvent event, Emitter emit) async {
    emit(UpdateBottleEntryLoading());

    try {
      final result = await repository.updateBottleEntry(
        size: event.size,
        partyName: event.partyName,
        totalBottlePerCase: event.totalBottlePerCase,
        bottleStatus: event.bottleStatus,
        bottleType: event.bottleType,
        updateId: event.updateId,
      );
      emit(
        UpdateBottleEntrySuccess("Bottle entry Updated successfully!$result"),
      );
    } catch (e) {
      emit(UpdateBottleEntryFailure(e.toString()));
    }
  }

  deleteBottleEntry(DeleteBottleEntryEvent event, Emitter emit) async {
    emit(DeleteBottleLoadingState());

    try {
      final result = await repository.deleteBottleEntry(
        bottleId: event.deleteId,
      );
      emit(DeleteBottleEntrySuccessState(message: result));
    } catch (e) {
      emit(DeleteBottleFailureState(error: e.toString()));
    }
  }

  ///////////////
  ///cap

  createCapEntry(CreateCapEntryEvent event, Emitter emit) async {
    emit(CreateCapEntryLoading());

    try {
      final result = await repository.createCapEntry(
        size: event.size,
        partyName: event.partyName,
        totalCapsPerCase: event.totalCapPerCase,
        capStatus: event.capStatus,
        capType: event.capType,
      );

      emit(CreateCapEntrySuccess("Cap entry created successfully! $result"));
    } catch (e) {
      emit(CreateCapEntryFailure("Failed to create cap entry: $e"));
    }
  }

  updateCapEntry(UpdateCapEntryEvent event, Emitter emit) async {
    emit(UpdateCapEntryLoading());

    try {
      final result = await repository.updateCapEntry(
        size: event.size,
        partyName: event.partyName,
        totalCapsPerCase: event.totalCapPerCase,
        capStatus: event.capStatus,
        capType: event.capType,
        updateId: event.updateId,
      );

      emit(UpdateCapEntrySuccess("Cap entry updated successfully! $result"));
    } catch (e) {
      emit(UpdateCapEntryFailure(e.toString()));
    }
  }

  deleteCapEntry(DeleteCapEntryEvent event, Emitter emit) async {
    emit(DeleteCapLoadingState());

    try {
      final result = await repository.deleteCapEntry(capId: event.deleteId);

      emit(DeleteCapEntrySuccessState(message: result));
    } catch (e) {
      emit(DeleteCapFailureState(error: e.toString()));
    }
  }
  ////////////////////////////////////////////////////////////
  /// LABLE
  ////////////////////////////////////////////////////////////

  createLableEntry(CreateLableEntryEvent event, Emitter emit) async {
    emit(CreateLableEntryLoading());

    try {
      final result = await repository.createlableEntry(
        size: event.size,
        partyName: event.partyName,
        totalLablePerCase: event.totalLablePerCase,
        lableStatus: event.lableStatus,
        lableType: event.lableType,
      );

      emit(
        CreateLableEntrySuccess("Lable entry created successfully! $result"),
      );
    } catch (e) {
      emit(CreateLableEntryFailure("Failed to create lable entry: $e"));
    }
  }

  ////////////////////////////////////////////////////////////

  updateLableEntry(UpdateLableEntryEvent event, Emitter emit) async {
    emit(UpdateLableEntryLoading());

    try {
      final result = await repository.updatelableEntry(
        updateId: event.updateId,
        size: event.size,
        partyName: event.partyName,
        totalLablePerCase: event.totalLablePerCase,
        lableStatus: event.lableStatus,
        lableType: event.lableType,
      );

      emit(
        UpdateLableEntrySuccess("Lable entry updated successfully! $result"),
      );
    } catch (e) {
      emit(UpdateLableEntryFailure(e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////

  deleteLableEntry(DeleteLableEntryEvent event, Emitter emit) async {
    emit(DeleteLableLoadingState());

    try {
      final result = await repository.deletelableEntry(lableId: event.deleteId);

      emit(DeleteLableEntrySuccessState(message: result));
    } catch (e) {
      emit(DeleteLableFailureState(error: e.toString()));
    }
  }

  ////////////////////////////////////////
  ///carton

  createCartonEntry(CreateCartonEntryEvent event, Emitter emit) async {
    emit(CreateCartonEntryLoading());

    try {
      final result = await repository.createCartonEntry(
        size: event.size,
        partyName: event.partyName,
        totalCartonPerCase: event.totalCartonPerCase,
        cartonStatus: event.cartonStatus,
        cartonType: event.cartonType,
      );

      emit(
        CreateCartonEntrySuccess("Carton entry created successfully! $result"),
      );
    } catch (e) {
      emit(CreateCartonEntryFailure("Failed to create carton entry: $e"));
    }
  }

  ///////////////////////////

  updateCartonEntry(UpdateCartonEntryEvent event, Emitter emit) async {
    emit(UpdateCartonEntryLoading());

    try {
      final result = await repository.updateCartonEntry(
        updateId: event.updateId,
        size: event.size,
        partyName: event.partyName,
        totalCartonPerCase: event.totalCartonPerCase,
        cartonStatus: event.cartonStatus,
        cartonType: event.cartonType,
      );

      emit(
        UpdateCartonEntrySuccess("Carton entry updated successfully! $result"),
      );
    } catch (e) {
      emit(UpdateCartonEntryFailure(e.toString()));
    }
  }

  ///////////////////////////
  deleteCartonEntry(DeleteCartonEntryEvent event, Emitter emit) async {
    emit(DeleteCartonLoadingState());

    try {
      final result = await repository.deleteCartonEntry(
        cartonId: event.deleteId,
      );

      emit(DeleteCartonEntrySuccessState(message: result));
    } catch (e) {
      emit(DeleteCartonFailureState(error: e.toString()));
    }
  }

  ////////////////////////////////////////////////////////////
  /// MONO CARTON BLOC
  ////////////////////////////////////////////////////////////

  createMonoCartonEntry(CreateMonoCartonEntryEvent event, Emitter emit) async {
    emit(CreateMonoCartonEntryLoading());

    try {
      final result = await repository.createMonoCartonEntry(
        size: event.size,
        partyName: event.partyName,
        totalMonoCartonPerCase: event.totalMonoCartonPerCase,
        monoCartonStatus: event.monoCartonStatus,
        monoCartonType: event.monoCartonType,
      );

      emit(
        CreateMonoCartonEntrySuccess(
          "Mono Carton created successfully! $result",
        ),
      );
    } catch (e) {
      emit(CreateMonoCartonEntryFailure(e.toString()));
    }
  }

  updateMonoCartonEntry(UpdateMonoCartonEntryEvent event, Emitter emit) async {
    emit(UpdateMonoCartonEntryLoading());

    try {
      final result = await repository.updateMonoCartonEntry(
        updateId: event.updateId,
        size: event.size,
        partyName: event.partyName,
        totalMonoCartonPerCase: event.totalMonoCartonPerCase,
        monoCartonStatus: event.monoCartonStatus,
        monoCartonType: event.monoCartonType,
      );

      emit(
        UpdateMonoCartonEntrySuccess(
          "Mono Carton updated successfully! $result",
        ),
      );
    } catch (e) {
      emit(UpdateMonoCartonEntryFailure(e.toString()));
    }
  }

  deleteMonoCartonEntry(DeleteMonoCartonEntryEvent event, Emitter emit) async {
    emit(DeleteMonoCartonLoadingState());

    try {
      final result = await repository.deleteMonoCartonEntry(
        monoCartonId: event.deleteId,
      );

      emit(DeleteMonoCartonEntrySuccessState(message: result));
    } catch (e) {
      emit(DeleteMonoCartonFailureState(error: e.toString()));
    }
  }
}
