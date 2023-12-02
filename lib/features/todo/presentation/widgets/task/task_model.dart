import 'package:elementary/elementary.dart';

import '../../../domain/bloc/task/task_bloc.dart';
import '../../../domain/bloc/task/task_event.dart';
import '../../../domain/bloc/task/task_state.dart';
import '../../../domain/dto/update_task_dto.dart';
import '../../../domain/entity/task_entity.dart';

abstract class ITaskModel {
  void updateTask({
    required Id id,
    required String title,
    required String description,
  });
  void completeTask(Id id);
  void revertTask(Id id);
  void deleteTask(Id id);

  Stream<BaseTaskState> get taskStateStream;
  BaseTaskState get initTaskState;
}

class TaskModel extends ElementaryModel implements ITaskModel {
  TaskModel({required TaskBloc taskBloc}) : _taskBloc = taskBloc;

  final TaskBloc _taskBloc;

  @override
  late final BaseTaskState initTaskState = _taskBloc.state;

  @override
  Stream<BaseTaskState> get taskStateStream => _taskBloc.stream.asBroadcastStream();

  @override
  void completeTask(Id id) {
    _taskBloc.add(CompleteTaskTaskEvent(id));
  }

  @override
  void deleteTask(Id id) {
    _taskBloc.add(DeleteTaskTaskEvent(id));
  }

  @override
  void revertTask(Id id) {
    _taskBloc.add(RevertTaskTaskEvent(id));
  }

  @override
  void updateTask({
    required Id id,
    required String title,
    required String description,
  }) {
    _taskBloc.add(
      UpdateTaskTaskEvent(
        UpdateTaskDTO(
          id: id,
          title: title,
          description: description,
        ),
      ),
    );
  }
}
