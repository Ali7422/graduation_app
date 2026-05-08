import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SupabaseClient _supabase = Supabase.instance.client;

  AuthCubit() : super(AuthInitial());

  Future<void> signUp({
    required String email,
    required String password,
    String? fullName,
  }) async {
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: fullName != null ? {'full_name': fullName} : null,
      );
      
      if (response.user != null) {
        emit(AuthSuccess(response.user));
      } else {
        emit(const AuthError('Sign up failed. Please try again.'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      if (response.user != null) {
        emit(AuthSuccess(response.user));
      } else {
        emit(const AuthError('Login failed. Please check your credentials.'));
      }
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {emit(AuthError('An unexpected error occurred: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _supabase.auth.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError('Sign out failed: ${e.toString()}'));
    }
  }

  void checkSession() {
    final session = _supabase.auth.currentSession;
    if (session != null) {
      emit(AuthSuccess(session.user));
    } else {
      emit(Unauthenticated());
    }
  }
}
