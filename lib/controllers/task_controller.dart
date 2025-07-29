import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:goto/models/task_model.dart';

class TaskController extends GetxController {
  final Box<TaskModel> _taskBox = Hive.box<TaskModel>('tasksBox');

  // ✅ Public getter to access the box from outside
  Box<TaskModel> get taskBox => _taskBox;
final RxList<TaskModel> tasks = <TaskModel>[].obs;

  var selectedDate = DateTime.now().obs;
  // var tasks = <TaskModel>[].obs;

  final List<String> emojis = [
    '📚', '💼', '🧘‍♂️', '🏃‍♂️', '🍽️', '🎨',
    '💻', '📖', '🛒', '🧹', '🎧', '📝',
  ];

  @override
  void onInit() {
    super.onInit();
    loadTasksForSelectedDate();
  }

  void loadTasksForSelectedDate() {
    final date = selectedDate.value;
    tasks.value = _taskBox.values
        .where((task) =>
            task.date.year == date.year &&
            task.date.month == date.month &&
            task.date.day == date.day)
        .toList();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    loadTasksForSelectedDate();
  }

  void addTask(TaskModel newTask) {
    _taskBox.add(newTask);
    loadTasksForSelectedDate();
  }

  void deleteTask(int index) {
    tasks[index].delete();
    loadTasksForSelectedDate();
  }

  void toggleTaskCompletion(int index) {
    final task = tasks[index];
    task.isDone = !task.isDone;
    task.save();
    loadTasksForSelectedDate();
  }

  void toggleSubTaskCompletion(int taskIndex, int subTaskIndex) {
    final task = tasks[taskIndex];
    if (task.subTasks != null) {
      task.save();
      loadTasksForSelectedDate();
    }
  }
}
