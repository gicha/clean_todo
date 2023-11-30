import 'package:equatable/equatable.dart';
import 'package:todo/features/todo/domain/dto/create_task_dto.dart';

abstract class BaseTaskCreatingEvent extends Equatable {
  const BaseTaskCreatingEvent();

  @override
  List<Object?> get props => [];
}

class CreateTaskEvent extends BaseTaskCreatingEvent {
  const CreateTaskEvent(this.createTaskDTO);

  final CreateTaskDTO createTaskDTO;

  @override
  List<Object?> get props => [createTaskDTO];
}
