import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import '../../repository/todo_repository.dart';
import 'task_creating_event.dart';
import 'task_creating_state.dart';

typedef TaskCreatedCallback = void Function(TaskEntity newTask);

class TaskCreatingBloc extends Bloc<BaseTaskCreatingEvent, BaseTaskCreatingState> {
  TaskCreatingBloc({
    required TodoRepository todoRepository,
    required TaskCreatedCallback onTaskCreated,
  })  : _todoRepository = todoRepository,
        _onTaskCreated = onTaskCreated,
        super(const ReadyToCreateTaskState()) {
    on<CreateTaskEvent>(_createTask);
  }

  final TodoRepository _todoRepository;
  final TaskCreatedCallback _onTaskCreated;

  FutureOr<void> _createTask(
    CreateTaskEvent event,
    Emitter<BaseTaskCreatingState> emit,
  ) async {
    assert(state is ITaskCreatingAvailable, 'State must be ITaskCreatingAvailable');
    emit(CreatingTaskState(event.createTaskDTO));
    try {
      final newTask = await _todoRepository.addTask(event.createTaskDTO);
      _onTaskCreated(newTask);
      emit(const ReadyToCreateTaskState());
    } catch (e) {
      emit(ErrorTaskCreatingState(event.createTaskDTO, e.toString()));
    }
  }
}