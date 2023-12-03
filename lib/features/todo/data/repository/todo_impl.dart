import '../../domain/dto/create_task_dto.dart';
import '../../domain/dto/update_task_dto.dart';
import '../../domain/entity/task_entity.dart';
import '../../domain/repository/todo_repository.dart';
import '../source/local/todo_lds.dart';

class TodoRepositoryImpl extends TodoRepository {
  TodoRepositoryImpl({required TodoLDS todoLDS}) : _todoLDS = todoLDS;

  final TodoLDS _todoLDS;

  @override
  Future<TaskEntity> addTask(CreateTaskDTO createTaskDTO) async {
    final task = await _todoLDS.addTask(
      title: createTaskDTO.title,
      description: createTaskDTO.description,
    );
    return task.entity;
  }

  @override
  Future<TaskEntity> getTaskById(Id id) async {
    final task = await _todoLDS.getTaskById(id);
    return task.entity;
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    final taskList = await _todoLDS.getTasks();
    return taskList.map((task) => task.entity).toList();
  }

  @override
  Future<void> completeTask(Id id) async {
    final task = await _todoLDS.getTaskById(id);
    assert(task.active, 'Task is already completed');
    await _todoLDS.updateTask(task.copyWith(active: false));
  }

  @override
  Future<void> revertTask(Id id) async {
    final task = await _todoLDS.getTaskById(id);
    assert(!task.active, 'Task is already active');
    await _todoLDS.updateTask(task.copyWith(active: true));
  }

  @override
  Future<TaskEntity> updateTask(UpdateTaskDTO updateTaskDTO) async {
    final task = await _todoLDS.getTaskById(updateTaskDTO.id);
    final newTask = task.copyWith(
      title: updateTaskDTO.title,
      description: updateTaskDTO.description,
    );
    final updatedTask = await _todoLDS.updateTask(newTask);
    return updatedTask.entity;
  }

  @override
  Future<void> deleteTask(Id id) {
    return _todoLDS.deleteTask(id);
  }
}
