import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tournament_event.dart';
part 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  TournamentBloc() : super(TournamentInitial()) {
    on<TournamentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
