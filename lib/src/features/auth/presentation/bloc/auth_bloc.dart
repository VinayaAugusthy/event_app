import 'package:event_app/src/features/auth/data/model/user_model.dart';
import 'package:event_app/src/features/auth/domain/auth_services/auth_services.dart';
import 'package:event_app/src/features/auth/domain/local_services/local_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
  final LocalService localService = LocalService();

  AuthBloc() : super(AuthInitialState()) {
    on<SignUpUser>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signUpUser(
          event.email,
          event.password,
          event.context,
        );
        if (user != null) {
          await localService.saveUserLoggedIn();
          emit(AuthSuccessState(user));
        } else {
          emit(const AuthFailureState('create user failed'));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      emit(AuthLoadingState(isLoading: false));
    });

    on<SignInUser>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        final UserModel? user = await authService.signinuser(
          email: event.email,
          password: event.password,
          context: event.context,
        );
        if (user != null) {
          await localService.saveUserLoggedIn();

          emit(AuthSuccessState(user));
        } else {
          emit(const AuthFailureState('create user failed'));
        }
      } catch (e) {
        debugPrint(e.toString());
      }
      emit(AuthLoadingState(isLoading: false));
    });

    on<SignOut>((event, emit) async {
      emit(AuthLoadingState(isLoading: true));
      try {
        await authService.signOutUser(event.context);
        await localService.clearUserSession();
      } catch (e) {
        debugPrint('error');
        debugPrint(e.toString());
      }
      emit(AuthLoadingState(isLoading: false));
    });
  }
}
