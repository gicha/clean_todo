import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import '../../dto/create_task_dto.dart';

abstract class BaseTaskCreatingState extends Equatable {
  const BaseTaskCreatingState();

  @override
  List<Object> get props => [];
}

abstract class ITaskCreatingAvailable {}

class ReadyToCreateTaskState extends BaseTaskCreatingState implements ITaskCreatingAvailable {
  const ReadyToCreateTaskState();
}

class CreatingTaskState extends BaseTaskCreatingState {
  const CreatingTaskState(this.createTaskDTO);

  final CreateTaskDTO createTaskDTO;

  @override
  List<Object> get props => [createTaskDTO];
}

class CreatedTaskState extends ReadyToCreateTaskState {
  const CreatedTaskState(this.task);

  final TaskEntity task;

  @override
  List<Object> get props => [task];
}

class ErrorTaskCreatingState extends CreatingTaskState implements ITaskCreatingAvailable {
  const ErrorTaskCreatingState(super.createTaskDTO, this.error);

  final Exception error;

  @override
  List<Object> get props => [createTaskDTO, error];
}
