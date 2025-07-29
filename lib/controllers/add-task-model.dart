import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/models/task_model.dart';
import 'package:goto/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/task_controller.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TaskController taskController = Get.find();
  final TextEditingController taskTextController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  bool _showSuccess = false;

  void _pickDate() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          initialDateTime: selectedDateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (value) {
            setState(() => selectedDateTime = DateTime(
                  value.year,
                  value.month,
                  value.day,
                  selectedDateTime.hour,
                  selectedDateTime.minute,
                ));
          },
        ),
      ),
    );
  }

  void _pickTime() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          initialDateTime: selectedDateTime,
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (value) {
            setState(() => selectedDateTime = DateTime(
                  selectedDateTime.year,
                  selectedDateTime.month,
                  selectedDateTime.day,
                  value.hour,
                  value.minute,
                ));
          },
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    final text = taskTextController.text.trim();
    if (text.isNotEmpty) {
      final newTask = TaskModel(
        title: text, 
        date: selectedDateTime, 
        description: '',
        isDone: false,
      );
      
      // Show success animation
      setState(() => _showSuccess = true);
      await Future.delayed(GetNumUtils(1).seconds);
      
      taskController.addTask(newTask);
      if (mounted) {
        Navigator.of(context).pop();
        _showToast(context);
      }
    }
  }

  void _showToast(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.activeGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(CupertinoIcons.checkmark_alt, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Task added to calendar!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .slideY(begin: -1, end: 0, curve: Curves.easeOutBack)
            .fadeIn()
            .then()
            .fadeOut(duration: 500.ms),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(GetNumUtils(2).seconds, () => overlayEntry.remove());
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.65, // Reduced from 0.95 to make it shorter
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Text(
                      "📝 Create Task",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: taskTextController,
                      hint: "What do you want to do? 🧠",
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: _pickDate,
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.calendar, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.yMMMEd().format(selectedDateTime),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _pickTime,
                          child: Row(
                            children: [
                              const Icon(CupertinoIcons.time, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                DateFormat.jm().format(selectedDateTime),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CupertinoButton.filled(
                        onPressed: _saveTask,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: const Text("✅ Save"),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Success animation overlay
              if (_showSuccess)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.9),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.checkmark_alt_circle_fill,
                            color: CupertinoColors.activeGreen,
                            size: 80,
                          )
                        .animate()
.scale(begin: const Offset(0.5, 0.5), end: const Offset(1.2, 1.2), curve: Curves.elasticOut)
.then()
.scale(end: const Offset(1, 1)),
                          const SizedBox(height: 20),
                          Text(
                            'Task Added!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.label,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms),
                          Text(
                            'Saving to calendar...',
                            style: TextStyle(
                              fontSize: 16,
                              color: CupertinoColors.systemGrey,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 400.ms),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}