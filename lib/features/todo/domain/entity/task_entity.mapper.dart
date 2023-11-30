// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'task_entity.dart';

class TaskStatusMapper extends EnumMapper<TaskStatus> {
  TaskStatusMapper._();

  static TaskStatusMapper? _instance;
  static TaskStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TaskStatusMapper._());
    }
    return _instance!;
  }

  static TaskStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TaskStatus decode(dynamic value) {
    switch (value) {
      case 'active':
        return TaskStatus.active;
      case 'completed':
        return TaskStatus.completed;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TaskStatus self) {
    switch (self) {
      case TaskStatus.active:
        return 'active';
      case TaskStatus.completed:
        return 'completed';
    }
  }
}

extension TaskStatusMapperExtension on TaskStatus {
  String toValue() {
    TaskStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TaskStatus>(this) as String;
  }
}

class TaskEntityMapper extends ClassMapperBase<TaskEntity> {
  TaskEntityMapper._();

  static TaskEntityMapper? _instance;
  static TaskEntityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TaskEntityMapper._());
      TaskStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TaskEntity';

  static int _$id(TaskEntity v) => v.id;
  static const Field<TaskEntity, int> _f$id = Field('id', _$id);
  static String _$title(TaskEntity v) => v.title;
  static const Field<TaskEntity, String> _f$title = Field('title', _$title);
  static String _$description(TaskEntity v) => v.description;
  static const Field<TaskEntity, String> _f$description =
      Field('description', _$description);
  static TaskStatus _$status(TaskEntity v) => v.status;
  static const Field<TaskEntity, TaskStatus> _f$status =
      Field('status', _$status);

  @override
  final Map<Symbol, Field<TaskEntity, dynamic>> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #status: _f$status,
  };

  static TaskEntity _instantiate(DecodingData data) {
    return TaskEntity(
        id: data.dec(_f$id),
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        status: data.dec(_f$status));
  }

  @override
  final Function instantiate = _instantiate;

  static TaskEntity fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TaskEntity>(map);
  }

  static TaskEntity fromJson(String json) {
    return ensureInitialized().decodeJson<TaskEntity>(json);
  }
}

mixin TaskEntityMappable {
  String toJson() {
    return TaskEntityMapper.ensureInitialized()
        .encodeJson<TaskEntity>(this as TaskEntity);
  }

  Map<String, dynamic> toMap() {
    return TaskEntityMapper.ensureInitialized()
        .encodeMap<TaskEntity>(this as TaskEntity);
  }

  TaskEntityCopyWith<TaskEntity, TaskEntity, TaskEntity> get copyWith =>
      _TaskEntityCopyWithImpl(this as TaskEntity, $identity, $identity);
  @override
  String toString() {
    return TaskEntityMapper.ensureInitialized()
        .stringifyValue(this as TaskEntity);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            TaskEntityMapper.ensureInitialized()
                .isValueEqual(this as TaskEntity, other));
  }

  @override
  int get hashCode {
    return TaskEntityMapper.ensureInitialized().hashValue(this as TaskEntity);
  }
}

extension TaskEntityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TaskEntity, $Out> {
  TaskEntityCopyWith<$R, TaskEntity, $Out> get $asTaskEntity =>
      $base.as((v, t, t2) => _TaskEntityCopyWithImpl(v, t, t2));
}

abstract class TaskEntityCopyWith<$R, $In extends TaskEntity, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? title, String? description, TaskStatus? status});
  TaskEntityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TaskEntityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TaskEntity, $Out>
    implements TaskEntityCopyWith<$R, TaskEntity, $Out> {
  _TaskEntityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TaskEntity> $mapper =
      TaskEntityMapper.ensureInitialized();
  @override
  $R call({int? id, String? title, String? description, TaskStatus? status}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (title != null) #title: title,
        if (description != null) #description: description,
        if (status != null) #status: status
      }));
  @override
  TaskEntity $make(CopyWithData data) => TaskEntity(
      id: data.get(#id, or: $value.id),
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      status: data.get(#status, or: $value.status));

  @override
  TaskEntityCopyWith<$R2, TaskEntity, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TaskEntityCopyWithImpl($value, $cast, t);
}
