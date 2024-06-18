import 'package:equatable/equatable.dart';
import 'package:sports_app/models/group.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'group_service.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(GroupInitial()) {
    on<GetGroupList>(_fetchGroups);
    on<AddGroup>(_addGroup);
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

  Future<void> _addGroup(AddGroup event, Emitter<GroupState> emit) async {
    try {
      emit(GroupLoading());
      final result = await GroupAPI.instance.addGroup(event.groupName);
      if (result.error != null) {
        emit(GroupError(result.error));
      } else {
        final gList = await GroupAPI.instance.fetchGroupList();
        emit(GroupLoaded(gList));
      }
    } on NetworkError {
      emit(const GroupError("Failed to add group. Is your device online?"));
    }
  }
}

