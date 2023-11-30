import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import '../../repository/todo_repository.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<BaseTaskEvent, BaseTaskState> {
  TaskBloc({
    required TodoRepository todoRepository,
    required TaskEntity task,
  })  : _todoRepository = todoRepository,
        super(ContentTaskState(task)) {
    on<UpdateTaskTaskEvent>(_updateTask);
    on<CompleteTaskTaskEvent>(_completeTask);
    on<RevertTaskTaskEvent>(_revertTask);
  }

  final TodoRepository _todoRepository;

  FutureOr<void> _updateTask(
    UpdateTaskTaskEvent event,
    Emitter<BaseTaskState> emit,
  ) async {
    assert(state is IEditingTaskAvailable, 'State must be IEditingTaskAvailable');
    final savedTask = state.task;
    try {
      emit(EditingLoadingTaskState(savedTask));
      final updatedTask = await _todoRepository.updateTask(event.updateTaskDTO);
      emit(ContentTaskState(updatedTask));
    } catch (e) {
      emit(ErrorTaskState(savedTask, e.toString()));
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
      emit(ContentTaskState(completedTask));
    } catch (e) {
      emit(ErrorTaskState(savedTask, e.toString()));
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
      emit(ContentTaskState(revertedTask));
    } catch (e) {
      emit(ErrorTaskState(savedTask, e.toString()));
    }
  }
}
