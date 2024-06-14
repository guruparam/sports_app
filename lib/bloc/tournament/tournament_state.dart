part of 'tournament_bloc.dart';

sealed class TournamentState extends Equatable {
  const TournamentState();
  
  @override
  List<Object> get props => [];
}

final class TournamentInitial extends TournamentState {}
