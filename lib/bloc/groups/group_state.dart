part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object?> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupLoaded extends GroupState {
  final GroupModel groupModel;
  const GroupLoaded(this.groupModel);
}

class GroupError extends GroupState {
  final String? message;
  const GroupError(this.message);
}
