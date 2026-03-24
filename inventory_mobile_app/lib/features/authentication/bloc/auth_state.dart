import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class SignInLoadingState extends AuthState {}

class SignInSuccessState extends AuthState {}

class SignInFailureState extends AuthState {
  final String message;

  SignInFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthenticatedState extends AuthState {}

class UnauthenticatedState extends AuthState {}
