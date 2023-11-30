import 'package:dart_mappable/dart_mappable.dart';

part 'task_entity.mapper.dart';

typedef Id = int;

@MappableEnum()
enum TaskStatus {
  active,
  completed;
}

@MappableClass()
class TaskEntity with TaskEntityMappable {
  TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
  });

  final Id id;
  final String title;
  final String description;
  final TaskStatus status;
}
