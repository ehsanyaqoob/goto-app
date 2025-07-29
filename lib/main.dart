import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/app.dart';
import 'package:goto/controllers/notes-cont.dart';
import 'package:goto/models/task_model.dart';
import 'package:goto/services/hive-service.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasksBox'); // ✅ This must be awaited
  runApp(GoToApp());
}



// lib/
// │
// ├── controllers/
// │   └── ongoing_plan_controller.dart
// │
// ├── models/
// │   └── ongoing_plan_model.dart
// │
// ├── views/
// │   ├── onboarding/
// │   │   └── onboarding_view.dart
// │   ├── home/
// │   │   ├── home_view.dart
// │   │   ├── ongoing_plans_screen.dart
// │   │   └── widgets/
// │   │       └── ongoing_plan_card.dart
// │   └── auth/
// │       └── login_view.dart
// │
// ├── widgets/
// │   └── reusable_widgets.dart
// │
// ├── constants/
// │   ├── app_colors.dart
// │   └── exports.dart
// │
// └── main.dart
