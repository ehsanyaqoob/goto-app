// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:goto/models/task-model.dart';

// class HiveService {
//   static Future<void> init() async {
//     await Hive.initFlutter(); // Initializes Hive for Flutter
//     Hive.registerAdapter(TaskModelAdapter()); // ✅ Make sure this adapter is generated
//     await Hive.openBox<TaskModel>('tasksBox'); // ✅ Opens the box
//   }

//   static Box<TaskModel> get tasksBox => Hive.box<TaskModel>('tasksBox');
// }
