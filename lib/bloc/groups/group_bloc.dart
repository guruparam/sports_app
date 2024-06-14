import 'package:equatable/equatable.dart';
import 'package:sports_app/models/group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_service.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial()) {
    on<GetGroupList>(_fetchGroups);
  }

  Future<void> _fetchGroups(GroupEvent event, Emitter<GroupState> emit) async {
    try {
      emit(GroupLoading());
      final gList = await GroupAPI.instance.fetchGroupList();
      emit(GroupLoaded(gList));
      if (gList.error != null) {
        emit(GroupError(gList.error));
      }
    } on NetworkError {
      emit(const GroupError("Failed to fetch data. Is your device online?"));
    }
  }
}
