import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repository/todo_repository.dart';
import 'todo_list_event.dart';
import 'todo_list_state.dart';

class TodoListBloc extends Bloc<BaseTodoListEvent, BaseTodoState> {
  TodoListBloc(TodoRepository todoRepository)
      : _todoRepository = todoRepository,
        super(LoadingTodoState()) {
    on<LoadTodoListEvent>(_loadTodoList);
  }

  final TodoRepository _todoRepository;

  FutureOr<void> _loadTodoList(
    LoadTodoListEvent event,
    Emitter<BaseTodoState> emit,
  ) async {
    assert(state is ILoadAvailable, "State must be ILoadAvailable");
    emit(LoadingTodoState());
    try {
      final tasks = await _todoRepository.getTasks();
      emit(ContentTodoState(tasks));
    } catch (e) {
      emit(ErrorTodoState(e.toString()));
    }
  }
}
