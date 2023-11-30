import 'package:equatable/equatable.dart';

abstract class BaseTodoListEvent extends Equatable {
  const BaseTodoListEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodoListEvent extends BaseTodoListEvent {}
