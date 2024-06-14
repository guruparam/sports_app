import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:dio/dio.dart';
import 'auth_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<FetchProfile>(_onProfileEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      Response response =
          await UserAPI.instance.login(event.email, event.password);
      if (response.statusCode == 200) {
        const storage = FlutterSecureStorage();
        await storage.write(key: 'token', value: response.data['access_token']);
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(response.data['detail'] ?? 'Unknown error'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegisterEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      Response response = await UserAPI.instance.register(
        event.firstname,
        event.lastname,
        event.email,
        event.password,
      );
      if (response.statusCode == 200) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure(response.data.toString()));
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 400) {
        emit(AuthFailure(e.response!.data.toString()));
      } else {
        emit(AuthFailure(e.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onProfileEvent(
      FetchProfile event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      emit(AuthLoading());
      final mList = await UserAPI.instance.fetchProfile();
      emit(ProfileLoded(mList));
      if (mList.error != null) {
        emit(AuthFailure(mList.error!));
      }
    } on NetworkError {
      emit(const AuthFailure("Failed to fetch data. is your device online?"));
    }
  }
}

class AuthLoaded {
}
