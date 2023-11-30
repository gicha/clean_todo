import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/dto/create_task_dto.dart';

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
}

class ErrorTaskCreatingState extends CreatingTaskState implements ITaskCreatingAvailable {
  const ErrorTaskCreatingState(super.createTaskDTO, this.error);

  final String error;
}
