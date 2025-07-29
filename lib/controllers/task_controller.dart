import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:goto/models/task_model.dart';

class TaskController extends GetxController {
  final Box<TaskModel> _taskBox = Hive.box<TaskModel>('tasksBox');
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  var selectedDate = DateTime.now().obs;
  RxInt completedTasksCount = 0.obs;
  RxBool showSuccessDialog = false.obs;

  final List<String> emojis = [
    '📚', '💼', '🧘‍♂️', '🏃‍♂️', '🍽️', '🎨',
    '💻', '📖', '🛒', '🧹', '🎧', '📝',
  ];

  @override
  void onInit() {
    super.onInit();
    loadTasksForSelectedDate();
  }

  Stream<int> get completedTasksStream => completedTasksCount.stream;

  void loadTasksForSelectedDate() {
    final date = selectedDate.value;
    tasks.value = _taskBox.values
        .where((task) =>
            task.date.year == date.year &&
            task.date.month == date.month &&
            task.date.day == date.day)
        .toList();
    
    _updateCompletedCount();
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
    bool wasCompleted = tasks[index].isDone;
    tasks[index].delete();
    loadTasksForSelectedDate();
    
    if (wasCompleted) {
      _updateCompletedCount();
    }
  }

  void toggleTaskCompletion(int index) {
    final task = tasks[index];
    final previousState = task.isDone;
    task.isDone = !task.isDone;
    task.save();
    loadTasksForSelectedDate();
    
    // Only trigger count update if we're completing (not uncompleting)
    if (!previousState && task.isDone) {
      _updateCompletedCount();
    }
  }

  void toggleSubTaskCompletion(int taskIndex, int subTaskIndex) {
    final task = tasks[taskIndex];
    if (task.subTasks != null) {
      task.save();
      loadTasksForSelectedDate();
    }
  }

  // Private method to handle count updates
  void _updateCompletedCount() {
    final newCount = tasks.where((task) => task.isDone).length;
    completedTasksCount.value = newCount;
    
    // Check if we've reached 5 completed tasks
    if (newCount == 5) {
      showSuccessDialog.value = true;
    }
  }

  void resetSuccessDialog() {
    showSuccessDialog.value = false;
  }

  // Public getter to access the box from outside
  Box<TaskModel> get taskBox => _taskBox;

  // Get today's completion percentage
  double get todayCompletionPercentage {
    if (tasks.isEmpty) return 0;
    return tasks.where((t) => t.isDone).length / tasks.length;
  }

  // Get most productive hour (returns hour 0-23)
  int get mostProductiveHour {
    final completedTasks = tasks.where((t) => t.isDone);
    if (completedTasks.isEmpty) return -1;
    
    final hourCounts = <int, int>{};
    for (var task in completedTasks) {
      final hour = task.date.hour;
      hourCounts[hour] = (hourCounts[hour] ?? 0) + 1;
    }
    
    return hourCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}