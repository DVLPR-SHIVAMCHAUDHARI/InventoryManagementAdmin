import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}

class CheckAuthEvent extends AuthEvent {}
