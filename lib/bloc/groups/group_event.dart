part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GetGroupList extends GroupEvent {
  const GetGroupList();
}
