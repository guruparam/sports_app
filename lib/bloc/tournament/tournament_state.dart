part of 'tournament_bloc.dart';

sealed class TournamentState extends Equatable {
  const TournamentState();
  
  @override
  List<Object> get props => [];
}

final class TournamentInitial extends TournamentState {}

class TournamentLoading extends TournamentState {}

class TournamentLoaded extends TournamentState {
  final List<dynamic> activeTournaments;
  final List<dynamic> upcomingTournaments;

  const TournamentLoaded(this.activeTournaments, this.upcomingTournaments);

  @override
  List<Object> get props => [activeTournaments, upcomingTournaments];
}

class TournamentError extends TournamentState {
  final String? message;
  const TournamentError(this.message);
}
