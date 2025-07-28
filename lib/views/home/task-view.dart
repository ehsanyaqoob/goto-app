import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/controllers/notes-cont.dart';
import 'package:goto/models/note-input-panel.dart';
import 'package:goto/models/task-model.dart';
import 'package:sizer/sizer.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final NotesController controller = Get.find<NotesController>();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Notes',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        trailing: GestureDetector(
          onTap: _showNoteInputPanel,
          child: const Icon(CupertinoIcons.pencil),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Inline Cupertino Date Picker
            Container(
              height: 150,
              color: CupertinoColors.systemGroupedBackground,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: selectedDate,
                onDateTimeChanged: (DateTime newDate) {
                  setState(() => selectedDate = newDate);
                  // You can add logic here to filter notes by selected date
                },
              ),
            ),

            // Notes List
            Expanded(
              child: Obx(() {
                final allNotes = controller.allNotes;

                if (allNotes.isEmpty) {
                  return Center(
                    child: Text(
                      'No notes yet. Tap the pencil to add.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  );
                }

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: ListView.builder(
                    key: ValueKey(allNotes.length),
                    padding: EdgeInsets.only(bottom: 5.h),
                    itemCount: allNotes.length,
                    itemBuilder: (context, index) {
                      final note = allNotes[index];
                      return NoteListItem(note: note, index: index);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoteInputPanel() {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => NoteInputPanel(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class NoteListItem extends StatelessWidget {
  final NoteModel note;
  final int index;

  const NoteListItem({
    super.key,
    required this.note,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotesController>();

    return Dismissible(
      key: Key(note.key.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        color: CupertinoColors.destructiveRed,
        child: const Icon(CupertinoIcons.delete_solid, color: Colors.white),
      ),
      onDismissed: (_) => controller.deleteNote(index),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: CupertinoColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => controller.toggleComplete(index),
              child: Icon(
                note.isCompleted
                    ? CupertinoIcons.checkmark_circle_fill
                    : CupertinoIcons.circle,
                color: note.isCompleted
                    ? CupertinoColors.activeGreen
                    : CupertinoColors.systemGrey,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      decoration: note.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      color: note.isCompleted
                          ? CupertinoColors.systemGrey
                          : CupertinoColors.label,
                    ),
                  ),
                  if (note.description.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        note.description,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: CupertinoColors.inactiveGray,
                          decoration: note.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.right_chevron, size: 18),
          ],
        ),
      ),
    );
  }
}
