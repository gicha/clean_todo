import 'package:elementary/elementary.dart';

import 'task_widget_model.dart';

abstract class TaskWidget extends ElementaryWidget<TaskWidgetModel> {
  TaskWidget({super.key}) : super(getTaskWidgetModelFactory());
}
