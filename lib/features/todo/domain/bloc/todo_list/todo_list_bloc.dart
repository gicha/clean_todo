import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../entity/task_entity.dart';
import '../../repository/todo_repository.dart';
import 'todo_list_event.dart';
import 'todo_list_state.dart';

typedef TaskActionCallback = void Function(TaskEntity task);
typedef TaskDeleteCallback = void Function(Id taskId);

class TodoListBloc extends Bloc<BaseTodoListEvent, BaseTodoState> {
  TodoListBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(LoadingTodoState()) {
    on<LoadTodoListEvent>(_loadTodoList);
    on<TaskCreatedListEvent>(_taskCreated);
    on<TaskDeletedListEvent>(_taskDeleted);
    on<TaskUpdatedListEvent>(_taskUpdated);
  }

  final TodoRepository _todoRepository;

  FutureOr<void> _loadTodoList(
    LoadTodoListEvent event,
    Emitter<BaseTodoState> emit,
  ) async {
    assert(state is ILoadAvailable, 'State must be ILoadAvailable');
    emit(LoadingTodoState());
    try {
      final tasks = await _todoRepository.getTasks();
      emit(ContentTodoState(tasks));
    } on Exception catch (e) {
      emit(ErrorTodoState(e));
    }
  }

  FutureOr<void> _taskCreated(
    TaskCreatedListEvent event,
    Emitter<BaseTodoState> emit,
  ) async {
    if (state is! ContentTodoState) return;
    final tasks = (state as ContentTodoState).tasks;
    final updatedTasks = [...tasks, event.task];
    emit(ContentTodoState(updatedTasks));
  }

  FutureOr<void> _taskDeleted(
    TaskDeletedListEvent event,
    Emitter<BaseTodoState> emit,
  ) async {
    if (state is! ContentTodoState) return;
    final tasks = (state as ContentTodoState).tasks;
    final updatedTasks = tasks.where((task) => task.id != event.taskId).toList();
    emit(ContentTodoState(updatedTasks));
  }

  Future<void> _taskUpdated(
    TaskUpdatedListEvent event,
    Emitter<BaseTodoState> emit,
  ) async {
    if (state is! ContentTodoState) return;
    final tasks = (state as ContentTodoState).tasks;
    final updatedTasks = tasks.map((task) {
      if (task.id == event.task.id) {
        return event.task;
      } else {
        return task;
      }
    }).toList();
    emit(ContentTodoState(updatedTasks));
  }
}
