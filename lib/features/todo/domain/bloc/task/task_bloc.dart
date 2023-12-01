import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import '../../repository/todo_repository.dart';
import '../todo_list/todo_list_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<BaseTaskEvent, BaseTaskState> {
  TaskBloc({
    required TaskEntity task,
    required TodoRepository todoRepository,
    required TaskDeleteCallback onTaskDelete,
    required TaskActionCallback onTaskUpdate,
  })  : _todoRepository = todoRepository,
        _onTaskDelete = onTaskDelete,
        _onTaskUpdate = onTaskUpdate,
        super(ContentTaskState(task)) {
    on<UpdateTaskTaskEvent>(_updateTask);
    on<CompleteTaskTaskEvent>(_completeTask);
    on<RevertTaskTaskEvent>(_revertTask);
    on<DeleteTaskTaskEvent>(_deleteTask);
  }

  final TodoRepository _todoRepository;
  final TaskDeleteCallback _onTaskDelete;
  final TaskActionCallback _onTaskUpdate;

  FutureOr<void> _updateTask(
    UpdateTaskTaskEvent event,
    Emitter<BaseTaskState> emit,
  ) async {
    assert(state is IEditingTaskAvailable, 'State must be IEditingTaskAvailable');
    final savedTask = state.task;
    try {
      emit(EditingLoadingTaskState(savedTask));
      final updatedTask = await _todoRepository.updateTask(event.updateTaskDTO);
      _onTaskUpdate(updatedTask);
      emit(ContentTaskState(updatedTask));
    } on Exception catch (e) {
      emit(ErrorTaskState(savedTask, e));
    }
  }

  FutureOr<void> _deleteTask(
    DeleteTaskTaskEvent event,
    Emitter<BaseTaskState> emit,
  ) async {
    assert(state is IDeletingTaskAvailable, 'State must be IDeletingTaskAvailable');
    final savedTask = state.task;
    try {
      await _todoRepository.deleteTask(event.taskId);
      _onTaskDelete(event.taskId);
    } on Exception catch (e) {
      emit(ErrorTaskState(savedTask, e));
    }
  }

  FutureOr<void> _completeTask(
    CompleteTaskTaskEvent event,
    Emitter<BaseTaskState> emit,
  ) async {
    assert(state is IStatusChangingTaskAvailable, 'State must be IStatusChangingTaskAvailable');
    final savedTask = state.task;
    emit(NewStatusLoadingTaskState(state.task));
    try {
      await _todoRepository.completeTask(event.taskId);
      final completedTask = savedTask.copyWith(status: TaskStatus.completed);
      _onTaskUpdate(completedTask);
      emit(ContentTaskState(completedTask));
    } on Exception catch (e) {
      emit(ErrorTaskState(savedTask, e));
    }
  }

  FutureOr<void> _revertTask(
    RevertTaskTaskEvent event,
    Emitter<BaseTaskState> emit,
  ) async {
    assert(state is IStatusChangingTaskAvailable, 'State must be IStatusChangingTaskAvailable');
    final savedTask = state.task;
    emit(NewStatusLoadingTaskState(state.task));
    try {
      await _todoRepository.revertTask(event.taskId);
      final revertedTask = savedTask.copyWith(status: TaskStatus.active);
      _onTaskUpdate(revertedTask);
      emit(ContentTaskState(revertedTask));
    } on Exception catch (e) {
      emit(ErrorTaskState(savedTask, e));
    }
  }
}
