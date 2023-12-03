import '../../../dto/task_dto.dart';
import '../todo_lds.dart';

const _delayDuration = Duration(milliseconds: 400);

class MockTodoLDS extends TodoLDS {
  List<TaskDTO> _todo = <TaskDTO>[
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
    await Future.delayed(_delayDuration);
    _todo.add(newTask);
    return newTask;
  }

  @override
  Future<void> deleteTask(int id) async {
    await Future.delayed(_delayDuration);
    _todo.removeWhere((task) => task.id == id);
  }

  @override
  Future<TaskDTO> getTaskById(int id) async {
    await Future.delayed(_delayDuration);
    return _todo.firstWhere((task) => task.id == id);
  }

  @override
  Future<List<TaskDTO>> getTasks() async {
    await Future.delayed(_delayDuration);
    return _todo;
  }

  @override
  Future<TaskDTO> updateTask(TaskDTO taskDTO) async {
    await Future.delayed(_delayDuration);
    TaskDTO? updatedTask;
    _todo = _todo.map((t) {
      if (t.id == taskDTO.id) {
        return updatedTask = t.copyWith(
          title: taskDTO.title,
          description: taskDTO.description,
          active: taskDTO.active,
        );
      }
      return t;
    }).toList();
    if (updatedTask == null) {
      throw Exception('Task not found');
    }
    return updatedTask!;
  }
}
