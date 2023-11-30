import '../entity/task_entity.dart';

abstract class TodoRepository {
  Future<TaskEntity> getTaskById(int id);
  Future<List<TaskEntity>> getTasks();
  Future<TaskEntity> addTask(TaskEntity task);
  Future<TaskEntity> updateTask(TaskEntity task);
  Future<void> completeTask(int id);
  Future<void> revertTask(int id);
}
