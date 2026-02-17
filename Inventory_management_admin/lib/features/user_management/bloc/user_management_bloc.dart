import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_event.dart';
import 'package:inventory_management_admin_pannel/features/user_management/bloc/user_management_state.dart';
import 'package:inventory_management_admin_pannel/features/user_management/repository/user_management_repository.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final UserManagementRepo repo;

  UserManagementBloc(this.repo) : super(UserManagementInitial()) {
    /// ----------------------- CREATE USER -----------------------
    on<UserSignUpEvent>((event, emit) async {
      emit(CreateUserLoading());
      try {
        await repo.createUser(
          fullname: event.fullname,
          email: event.email,
          password: event.password,
          departmentId: event.departmentId,

          roleId: event.roleId,
        );

        emit(CreateUserSuccess("User Created Successfully"));
      } catch (e) {
        emit(CreateUserFailure(e.toString()));
      }
    });

    /// ----------------------- DELETE USER -----------------------
    on<DeleteUserEvent>((event, emit) async {
      emit(DeleteUserLoading());
      try {
        final result = await repo.deleteUser(id: event.userId);

        emit(DeleteUserSuccess(result));
      } catch (e) {
        emit(DeleteUserFailure(e.toString()));
      }
    });

    /// ----------------------- UPDATE USER -----------------------
    on<UpdateUserEvent>((event, emit) async {
      emit(UpdateUserLoading());
      try {
        await repo.updateUser(
          fullname: event.fullname,
          email: event.email,
          id: event.userId,
          departmentId: event.departmentId,

          roleId: event.roleId,
        );

        emit(UpdateUserSuccess("User Updated Successfully"));
      } catch (e) {
        emit(UpdateUserFailure(e.toString()));
      }
    });

    /// ----------------------- UPDATE PASSWORD -----------------------
    on<UpdatePasswordEvent>((event, emit) async {
      emit(UpdatePasswordLoading());
      try {
        final result = await repo.updatePassword(
          pass: event.newPassword,

          id: event.userId,
        );

        emit(UpdatePasswordSuccess("Password Updated Successfully"));
      } catch (e) {
        emit(UpdatePasswordFailure(e.toString()));
      }
    });

    /// ----------------------- VERIFY USER -----------------------
    on<VerifyUserEvent>((event, emit) async {
      emit(VerifyUserLoading());
      try {
        final result = await repo.verifyUser(id: event.userId);

        emit(VerifyUserSuccess("User Verified"));
      } catch (e) {
        emit(VerifyUserFailure(e.toString()));
      }
    });

    /// ----------------------- UNVERIFY USER -----------------------
    on<UnVerifyUserEvent>((event, emit) async {
      emit(UnVerifyUserLoading());
      try {
        final result = await repo.unverifyUser(id: event.userId);

        emit(UnVerifyUserSuccess("User Unverified"));
      } catch (e) {
        emit(UnVerifyUserFailure(e.toString()));
      }
    });

    // ----------------------- LOAD USER LIST -----------------------
    // ----------------------- LOAD USER LIST -----------------------
    on<FetchUserListEvent>((event, emit) async {
      emit(UserListLoading());

      try {
        final data = await repo.getUserList(
          email: event.email ?? "",
          fullname: event.fullname ?? "",
          sortBy: event.sortBy ?? "id",
          orderBy: event.orderBy ?? "asc",
          offset: event.offset,
          limit: event.limit,
        );

        if (data != null && data is Map<String, dynamic>) {
          emit(UserListLoaded(data));
        } else {
          emit(UserListFailure("Invalid API response format"));
        }
      } catch (e) {
        emit(UserListFailure(e.toString()));
      }
    });
  }
}
