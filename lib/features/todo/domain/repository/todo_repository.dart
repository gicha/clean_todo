import '../dto/create_task_dto.dart';
import '../dto/update_task_dto.dart';
import '../entity/task_entity.dart';

abstract class TodoRepository {
  Future<TaskEntity> getTaskById(Id id);
  Future<List<TaskEntity>> getTasks();
  Future<TaskEntity> addTask(CreateTaskDTO createTaskDTO);
  Future<TaskEntity> updateTask(UpdateTaskDTO updateTaskDTO);
  Future<void> deleteTask(Id id);
  Future<void> completeTask(Id id);
  Future<void> revertTask(Id id);
}
