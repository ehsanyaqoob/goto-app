// import 'package:get/get.dart';
// import 'package:goto/models/task-model.dart';
// import 'package:goto/services/hive-service.dart';
// import 'package:intl/intl.dart';
// class CalendarController extends GetxController {
//   Rx<DateTime> selectedDate = DateTime.now().obs;
//   RxList<TaskModel> allTasks = <TaskModel>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     loadTasks();
//   }

//   void loadTasks() {
//     final box = HiveService.tasksBox;
//     allTasks.value = box.values.toList();
//   }

//   List<TaskModel> get tasksForSelectedDate {
//     return allTasks.where((task) {
//       return DateFormat('yyyy-MM-dd').format(task.date) ==
//              DateFormat('yyyy-MM-dd').format(selectedDate.value);
//     }).toList();
//   }

//   void changeDate(DateTime date) {
//     selectedDate.value = date;
//   }

//   void addTask(String title) {
//     final task = TaskModel(
//       title: title,
//       date: selectedDate.value,
//       createdAt: DateTime.now(),
//     );
//     HiveService.tasksBox.add(task);
//     loadTasks(); // reload from Hive
//   }
// }
