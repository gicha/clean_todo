import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

abstract class BaseTodoEvent extends Equatable {
  const BaseTodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodoEvent extends BaseTodoEvent {}

class CreateTaskTodoEvent extends BaseTodoEvent {
  const CreateTaskTodoEvent(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}

class UpdateTaskTodoEvent extends BaseTodoEvent {
  const UpdateTaskTodoEvent(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}

class FinishTaskTodoEvent extends BaseTodoEvent {
  const FinishTaskTodoEvent(this.taskId);

  final Id taskId;

  @override
  List<Object?> get props => [taskId];
}

class RevertTaskTodoEvent extends BaseTodoEvent {
  const RevertTaskTodoEvent(this.taskId);

  final Id taskId;

  @override
  List<Object?> get props => [taskId];
}
