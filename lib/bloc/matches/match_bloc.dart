import 'package:equatable/equatable.dart';
import 'package:sports_app/models/active_matches.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'match_service.dart';
part 'match_event.dart';
part 'match_state.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc() : super(MatchInitial()) {
    on<GetMatchList>(_fetchmatches);
  }

  Future<void> _fetchmatches(MatchEvent event, Emitter<MatchState> emit) async {
    try {
      emit(MatchLoading());
      final mList = await MatchAPI.instance.fetchMatchList();
      emit(MatchLoaded(mList));
      if (mList.error != null) {
        emit(MatchError(mList.error));
      }
    } on NetworkError {
      emit(const MatchError("Failed to fetch data. is your device online?"));
    }
  }
}
