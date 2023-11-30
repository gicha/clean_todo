import 'package:todo/features/todo/data/dto/task_dto.dart';

abstract class TodoLDS {
  Future<List<TaskDTO>> getTasks();
  Future<TaskDTO> getTaskById(int id);
  Future<TaskDTO> addTask({
    required String title,
    required String description,
  });
  Future<TaskDTO> updateTask(TaskDTO taskDTO);
  Future<void> deleteTask(int id);
}
