import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  const RegisterEvent(this.firstname, this.lastname, this.email, this.password);

  @override
  List<Object> get props => [firstname, lastname, email, password];
}

class FetchProfile extends AuthEvent {
  const FetchProfile();
}
