part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class GetGroupList extends GroupEvent {
  const GetGroupList();
}

class AddGroup extends GroupEvent {
  final String groupName;
  const AddGroup(this.groupName);

  @override
  List<Object> get props => [groupName];
}