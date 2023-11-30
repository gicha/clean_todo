import '../entity/task_entity.dart';

abstract class TodoRepository {
  Future<TaskEntity> getTaskById(Id id);
  Future<List<TaskEntity>> getTasks();
  Future<TaskEntity> addTask(TaskEntity task);
  Future<TaskEntity> updateTask(TaskEntity task);
  Future<void> completeTask(Id id);
  Future<void> revertTask(Id id);
}
