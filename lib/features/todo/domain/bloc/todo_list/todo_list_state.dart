import 'package:equatable/equatable.dart';

import '../../entity/task_entity.dart';

abstract class BaseTodoState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class ILoadAvailable {}

class LoadingTodoState extends BaseTodoState {}

class ErrorTodoState extends BaseTodoState implements ILoadAvailable {
  ErrorTodoState(this.error);

  final Exception error;
}

class ContentTodoState extends BaseTodoState implements ILoadAvailable {
  ContentTodoState(this.tasks);

  final List<TaskEntity> tasks;
}
