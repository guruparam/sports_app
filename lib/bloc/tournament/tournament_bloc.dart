import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/tournament.dart';
import 'tournament_service.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  TournamentBloc() : super(TournamentInitial()) {
    on<GetTournaments>(_fetchTournaments);
  }

  Future<void> _fetchTournaments(
      GetTournaments event, Emitter<TournamentState> emit) async {
    try {
      emit(TournamentLoading());
      final tournaments = await TournamentAPI.instance.fetchTournaments();
      if (tournaments.error != null) {
        emit(TournamentError(tournaments.error!));
      } else {
        emit(TournamentLoaded(
          tournaments.activeTournaments ?? [],
          tournaments.upcomingTournaments ?? [],
        ));
      }
    } on NetworkError {
      emit(const TournamentError(
          "Failed to fetch data. Is your device online?"));
    } catch (error) {
      emit(TournamentError("An unexpected error occurred: $error"));
    }
  }
}
