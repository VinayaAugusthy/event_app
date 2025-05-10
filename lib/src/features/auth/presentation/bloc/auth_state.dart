part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();

  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {
  final bool isLoading;

  AuthLoadingState({required this.isLoading});
}

class AuthSuccessState extends AuthState {
  final UserModel user;

  const AuthSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class AuthFailureState extends AuthState {
  final String errorMessage;

  const AuthFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
