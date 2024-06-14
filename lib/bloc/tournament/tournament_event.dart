part of 'tournament_bloc.dart';

sealed class TournamentEvent extends Equatable {
  const TournamentEvent();

  @override
  List<Object> get props => [];
}

class GetTournaments extends TournamentEvent {
  const GetTournaments();
}
