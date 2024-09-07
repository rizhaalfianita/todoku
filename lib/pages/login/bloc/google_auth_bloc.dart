import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todoku_app/repository/auth_repository.dart';

part 'google_auth_event.dart';
part 'google_auth_state.dart';

class GoogleAuthBloc extends Bloc<GoogleAuthEvent, GoogleAuthState> {
  GoogleAuthBloc(this._authRepository) : super(GoogleAuthInitial()) {
    on<SignInEvent>(_signInWithGoogle);
    on<CheckAuthStatusEvent>(_checkAuthStatus);
  }

  final AuthRepository _authRepository;

  Future<void> _signInWithGoogle(
      SignInEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoading());
    final user = await _authRepository.signinWithGoogle();
    if (user == null) {
      return emit(GoogleAuthError());
    }
    emit(GoogleAuthSuccess());
  }

  Future<void> _checkAuthStatus(
      CheckAuthStatusEvent event, Emitter<GoogleAuthState> emit) async {
    emit(GoogleAuthLoading());
    final user = await _authRepository.getCurrentUser();
    if (user == null) {
      emit(GoogleAuthError());
    } else {
      emit(GoogleAuthSuccess());
    }
  }
}
