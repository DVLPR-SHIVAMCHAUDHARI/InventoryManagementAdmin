import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_admin_pannel/features/Authentication/repository.dart/auth_repo.dart';

import 'auth_event.dart';
import 'auth_state.dart';

import 'package:inventory_management_admin_pannel/core/services/tokenservice.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo = AuthRepo();
  final TokenServices tokenServices = TokenServices();

  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_signIn);
    on<LogoutEvent>(_logout);
    on<CheckAuthEvent>(_checkAuth);
  }

  Future<void> _checkAuth(CheckAuthEvent event, Emitter<AuthState> emit) async {
    await tokenServices.load();
    if (tokenServices.accessToken != null) {
      emit(AuthenticatedState());
    } else {
      emit(UnauthenticatedState());
    }
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(SignInLoadingState());

    final result = await repo.signin(
      email: event.email,
      password: event.password,
    );

    if (result["success"] == true) {
      emit(SignInSuccessState());
      emit(AuthenticatedState());
    } else {
      emit(SignInFailureState(result["message"]));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    await tokenServices.clear();
    emit(UnauthenticatedState());
  }
}
