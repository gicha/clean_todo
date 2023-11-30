import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/dto/update_task_dto.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

abstract class BaseTaskEvent extends Equatable {
  const BaseTaskEvent();

  @override
  List<Object?> get props => [];
}

class UpdateTaskTaskEvent extends BaseTaskEvent {
  const UpdateTaskTaskEvent(this.updateTaskDTO);

  final UpdateTaskDTO updateTaskDTO;

  @override
  List<Object?> get props => [updateTaskDTO];
}

class DeleteTaskTaskEvent extends BaseTaskEvent {
  const DeleteTaskTaskEvent(this.taskId);

  final Id taskId;

  @override
  List<Object?> get props => [taskId];
}

class CompleteTaskTaskEvent extends BaseTaskEvent {
  const CompleteTaskTaskEvent(this.taskId);

  final Id taskId;

  @override
  List<Object?> get props => [taskId];
}

class RevertTaskTaskEvent extends BaseTaskEvent {
  const RevertTaskTaskEvent(this.taskId);

  final Id taskId;

  @override
  List<Object?> get props => [taskId];
}
