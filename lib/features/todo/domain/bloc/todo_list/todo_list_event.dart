import 'package:equatable/equatable.dart';

import '../../entity/task_entity.dart';

abstract class BaseTodoListEvent extends Equatable {
  const BaseTodoListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodoListEvent extends BaseTodoListEvent {}

class TaskCreatedListEvent extends BaseTodoListEvent {
  const TaskCreatedListEvent(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}

class TaskDeletedListEvent extends BaseTodoListEvent {
  const TaskDeletedListEvent(this.taskId);

  final Id taskId;

  @override
  List<Object?> get props => [taskId];
}

class TaskUpdatedListEvent extends BaseTodoListEvent {
  const TaskUpdatedListEvent(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}
