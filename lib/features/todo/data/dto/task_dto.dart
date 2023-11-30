import 'package:dart_mappable/dart_mappable.dart';

part 'task_dto.mapper.dart';

@MappableClass()
class TaskDTO with TaskDTOMappable {
  TaskDTO({
    required this.id,
    required this.title,
    required this.description,
    required this.active,
  });

  final int id;
  final String title;
  final String description;
  final bool active;
}
