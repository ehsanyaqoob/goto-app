// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:goto/widgets/add_task_bottom_sheet.dart';
// import 'package:goto/controllers/task_controller.dart';
// import 'package:goto/models/task_model.dart';
// import 'package:intl/intl.dart';

// class TaskView extends StatefulWidget {
//   const TaskView({super.key});

//   @override
//   State<TaskView> createState() => _TaskViewState();
// }

// class _TaskViewState extends State<TaskView> {
//   final TaskController controller = Get.put(TaskController());

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: const CupertinoNavigationBar(
//         middle: Text("📋 My Tasks"),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             _buildDateSelector(context),
//             Expanded(child: Obx(() => _buildTaskList())),
//             _buildAddTaskButton(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDateSelector(BuildContext context) {
//     return GestureDetector(
//       onTap: () => showCupertinoModalPopup(
//         context: context,
//         builder: (_) => Container(
//           height: 250,
//           color: CupertinoColors.systemBackground.resolveFrom(context),
//           child: CupertinoDatePicker(
//             mode: CupertinoDatePickerMode.date,
//             initialDateTime: controller.selectedDate.value,
//             onDateTimeChanged: controller.updateSelectedDate,
//           ),
//         ),
//       ),
//       child: Container(
//         margin: const EdgeInsets.all(16),
//         padding: const EdgeInsets.symmetric(vertical: 10),
//         decoration: BoxDecoration(
//           color: CupertinoColors.systemGrey5,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Obx(() => Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(CupertinoIcons.calendar),
//                 const SizedBox(width: 6),
//                 Text(
//                   _formattedDate(controller.selectedDate.value),
//                   style: const TextStyle(fontSize: 16),
//                 )
//               ],
//             )),
//       ),
//     );
//   }

//   Widget _buildTaskList() {
//     final tasks = controller.getTasksForDate(controller.selectedDate.value);
//     if (tasks.isEmpty) {
//       return const Center(
//         child: Text("😴 No tasks yet!", style: TextStyle(color: CupertinoColors.systemGrey)),
//       );
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.only(bottom: 80),
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//           child: Dismissible(
//             key: Key(task.key.toString()),
//             direction: DismissDirection.endToStart,
//             onDismissed: (_) => controller.deleteTask(index),
//             background: Container(
//               color: CupertinoColors.systemRed,
//               alignment: Alignment.centerRight,
//               padding: const EdgeInsets.only(right: 20),
//               child: const Icon(CupertinoIcons.delete, color: Colors.white),
//             ),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               decoration: BoxDecoration(
//                 color: CupertinoColors.systemGrey6,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: ListTile(
//                 leading: CupertinoButton(
//                   padding: EdgeInsets.zero,
//                   onPressed: () => controller.toggleTaskCompletion(index),
//                   child: Icon(
//                     task.isDone
//                         ? CupertinoIcons.check_mark_circled_solid
//                         : CupertinoIcons.circle,
//                     color: task.isDone
//                         ? CupertinoColors.activeGreen
//                         : CupertinoColors.inactiveGray,
//                   ),
//                 ),
//                 title: Text(
//                   task.description, // Changed from task.title to task.description
//                   style: TextStyle(
//                     fontSize: 16,
//                     decoration: task.isDone ? TextDecoration.lineThrough : null,
//                     color: task.isDone
//                         ? CupertinoColors.systemGrey
//                         : CupertinoColors.label,
//                   ),
//                 ),
//                 subtitle: Text(
//                   DateFormat.jm().format(task.date),
//                   style: const TextStyle(color: CupertinoColors.systemGrey),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAddTaskButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: CupertinoButton.filled(
//         onPressed: () {
//           showCupertinoModalPopup(
//             context: context,
//             builder: (_) => const AddTaskBottomSheet(),
//           );
//         },
//         child: const Text("➕ Add New Task"),
//       ),
//     );
//   }

//   String _formattedDate(DateTime date) {
//     return DateFormat('MMMM d, yyyy').format(date);
//   }
// }