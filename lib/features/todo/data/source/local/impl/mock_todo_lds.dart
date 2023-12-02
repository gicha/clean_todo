import '../../../dto/task_dto.dart';
import '../todo_lds.dart';

class MockTodoLDS extends TodoLDS {
  final _todo = <TaskDTO>[
    TaskDTO(
      id: 1,
      title: 'Mock Task 1',
      description: 'This is a mock task 1',
      active: true,
    ),
    TaskDTO(
      id: 2,
      title: 'Mock Task 2',
      description: 'This is a mock task 2',
      active: false,
    ),
    TaskDTO(
      id: 3,
      title: 'Mock Task 3',
      description: 'This is a mock task 3',
      active: true,
    ),
  ];

  @override
  Future<TaskDTO> addTask({
    required String title,
    required String description,
  }) async {
    final newTask = TaskDTO(
      id: _todo.length + 1,
      title: title,
      description: description,
      active: true,
    );
    await Future.delayed(const Duration(seconds: 1));
    _todo.add(newTask);
    return newTask;
  }

  @override
  Future<void> deleteTask(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    _todo.removeWhere((task) => task.id == id);
  }

  @override
  Future<TaskDTO> getTaskById(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    return _todo.firstWhere((task) => task.id == id);
  }

  @override
  Future<List<TaskDTO>> getTasks() async {
    await Future.delayed(const Duration(seconds: 1));
    return _todo;
  }

  @override
  Future<TaskDTO> updateTask(TaskDTO taskDTO) async {
    await Future.delayed(const Duration(seconds: 1));
    final task = _todo.firstWhere((task) => task.id == taskDTO.id);
    return task.copyWith(
      title: taskDTO.title,
      description: taskDTO.description,
      active: taskDTO.active,
    );
  }
}
