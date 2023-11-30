import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todo/features/todo/domain/entity/task_entity.dart';

import '../../repository/todo_repository.dart';
import 'todo_list_event.dart';
import 'todo_list_state.dart';

class _TaskCreatedListEvent extends BaseTodoListEvent {
  const _TaskCreatedListEvent(this.task);

  final TaskEntity task;

  @override
  List<Object?> get props => [task];
}

class TodoListBloc extends Bloc<BaseTodoListEvent, BaseTodoState> {
  TodoListBloc({required TodoRepository todoRepository})
      : _todoRepository = todoRepository,
        super(LoadingTodoState()) {
    on<LoadTodoListEvent>(_loadTodoList);
    on<_TaskCreatedListEvent>(_taskCreated);
  }

  final TodoRepository _todoRepository;

  void taskCreated(TaskEntity task) {
    add(_TaskCreatedListEvent(task));
  }

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
    _TaskCreatedListEvent event,
    Emitter<BaseTodoState> emit,
  ) async {
    if (state is! ContentTodoState) return;
    final tasks = (state as ContentTodoState).tasks;
    final updatedTasks = [...tasks, event.task];
    emit(ContentTodoState(updatedTasks));
  }
}
