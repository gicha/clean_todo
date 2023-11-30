import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

abstract class BaseTodoState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class ILoadAvailable {}

class LoadingTodoState extends BaseTodoState {}

class ErrorTodoState extends BaseTodoState implements ILoadAvailable {
  ErrorTodoState(this.error);

  final String error;
}

class ContentTodoState extends BaseTodoState {
  ContentTodoState(this.tasks);

  final List<TaskEntity> tasks;
}
