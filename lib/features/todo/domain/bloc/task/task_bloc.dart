import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../entity/task_entity.dart';
import '../../repository/todo_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<BaseTaskEvent, BaseTaskState> {
  TaskBloc({
    required TaskEntity task,
    required TodoRepository todoRepository,
  })  : _todoRepository = todoRepository,
        super(ContentTaskState(task)) {
    on<UpdateTaskTaskEvent>(_updateTask);
    on<CompleteTaskTaskEvent>(_completeTask);
    on<RevertTaskTaskEvent>(_revertTask);
    on<DeleteTaskTaskEvent>(_deleteTask);
  }

  final TodoRepository _todoRepository;

  FutureOr<void> _updateTask(
    UpdateTaskTaskEvent event,
    Emitter<BaseTaskState> emit,
  ) async {
    assert(state is IEditingTaskAvailable, 'State must be IEditingTaskAvailable');
    final savedTask = state.task;
    emit(UpdateLoadingTaskState(savedTask));
    try {
      final updatedTask = await _todoRepository.updateTask(event.updateTaskDTO);
      emit(UpdatedTaskState(updatedTask));
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
    emit(DeletingLoadingTaskState(savedTask));
    try {
      await _todoRepository.deleteTask(event.taskId);
      emit(DeletedTaskState(savedTask));
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
    emit(NewStatusLoadingTaskState(savedTask));
    try {
      await _todoRepository.completeTask(event.taskId);
      final completedTask = savedTask.copyWith(status: TaskStatus.completed);
      emit(UpdatedTaskState(completedTask));
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
      emit(UpdatedTaskState(revertedTask));
    } on Exception catch (e) {
      emit(ErrorTaskState(savedTask, e));
    }
  }
}
