import 'package:equatable/equatable.dart';

import '../../entity/task_entity.dart';

abstract class BaseTaskState extends Equatable {
  const BaseTaskState(this.task);
  final TaskEntity task;
  @override
  List<Object> get props => [task];
}

abstract class IEditingTaskAvailable {}

abstract class IDeletingTaskAvailable {}

abstract class IStatusChangingTaskAvailable {}

class UpdateLoadingTaskState extends BaseTaskState {
  const UpdateLoadingTaskState(super.task);
}

class NewStatusLoadingTaskState extends BaseTaskState {
  const NewStatusLoadingTaskState(super.task);
}

class ContentTaskState extends BaseTaskState implements IEditingTaskAvailable, IDeletingTaskAvailable, IStatusChangingTaskAvailable {
  const ContentTaskState(super.task);
}

class ErrorTaskState extends ContentTaskState {
  const ErrorTaskState(super.task, this.error);

  final Exception error;

  @override
  List<Object> get props => [task, error];
}
