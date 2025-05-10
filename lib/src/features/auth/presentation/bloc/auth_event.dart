part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();

  List<Object> get props => [];
}

class SignUpUser extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const SignUpUser(this.email, this.password, this.context);

  @override
  List<Object> get props => [email, password];
}

class SignInUser extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;
  const SignInUser(this.email, this.password, this.context);

  @override
  List<Object> get props => [email, password];
}

class SignOut extends AuthEvent {}
