import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_event.dart';
import 'package:inventory_management_admin_pannel/features/master_api/department/bloc/department_state.dart';
import 'package:inventory_management_admin_pannel/features/master_api/repositories/masterrepo.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final MasterRepo repo;

  DepartmentBloc(this.repo) : super(const DepartmentInitial()) {
    on<FetchDepartments>(_onFetchDepartments);
    on<CreateDepartment>(_onCreateDepartment);
    on<UpdateDepartment>(_onUpdateDepartment);
    on<DeleteDepartment>(_onDeleteDepartment);
  }

  Future<void> _onFetchDepartments(
    FetchDepartments event,
    Emitter<DepartmentState> emit,
  ) async {
    emit(const DepartmentLoading());
    try {
      final departments = await repo.fetchDepartments();
      emit(DepartmentLoaded(departments));
    } catch (e) {
      emit(DepartmentError(e.toString()));
    }
  }

  Future<void> _onCreateDepartment(
    CreateDepartment event,
    Emitter<DepartmentState> emit,
  ) async {
    emit(const CreateDepartmentLoading());
    try {
      await repo.createDepartment(departmentName: event.departmentName);
      emit(const CreateDepartmentSuccess("Department created successfully"));
      final departments = await repo.fetchDepartments();
      emit(DepartmentLoaded(departments));
    } catch (e) {
      emit(CreateDepartmentFailure(e.toString()));
    }
  }

  Future<void> _onUpdateDepartment(
    UpdateDepartment event,
    Emitter<DepartmentState> emit,
  ) async {
    emit(const UpdateDepartmentLoading());
    try {
      await repo.updateDepartment(
        departmentId: event.departmentId,
        departmentName: event.departmentName,
      );
      emit(const UpdateDepartmentSuccess("Department updated successfully"));
      final departments = await repo.fetchDepartments();
      emit(DepartmentLoaded(departments));
    } catch (e) {
      emit(UpdateDepartmentFailure(e.toString()));
    }
  }

  Future<void> _onDeleteDepartment(
    DeleteDepartment event,
    Emitter<DepartmentState> emit,
  ) async {
    emit(const DeleteDepartmentLoading());
    try {
      await repo.deleteDepartment(departmentId: event.departmentId);
      emit(const DeleteDepartmentSuccess("Department deleted successfully"));
      final departments = await repo.fetchDepartments();
      emit(DepartmentLoaded(departments));
    } catch (e) {
      emit(DeleteDepartmentFailure(e.toString()));
    }
  }
}
