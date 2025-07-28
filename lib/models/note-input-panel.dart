import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goto/controllers/notes-cont.dart';
import 'package:goto/models/task-model.dart';
import 'package:sizer/sizer.dart';

class NoteInputPanel extends StatefulWidget {
  final VoidCallback onClose;

  const NoteInputPanel({super.key, required this.onClose});

  @override
  State<NoteInputPanel> createState() => _NoteInputPanelState();
}

class _NoteInputPanelState extends State<NoteInputPanel> {
  final NotesController notesController = Get.find<NotesController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isListMode = false;
  bool isPinned = false;
  List<String> listItems = [''];

  void saveNote() {
    final trimmedTitle = titleController.text.trim();
    final trimmedDescription = descriptionController.text.trim();

    if (trimmedTitle.isEmpty &&
        (isListMode
            ? listItems.every((e) => e.trim().isEmpty)
            : trimmedDescription.isEmpty)) return;

    notesController.addNote(
      NoteModel(
        title: trimmedTitle,
        description: isListMode
            ? listItems.where((e) => e.trim().isNotEmpty).join('\n• ')
            : trimmedDescription,
        createdAt: DateTime.now(),
        isPinned: isPinned,
        isList: isListMode,
        isCompleted: false,
        isChecklist: isListMode,
      ),
    );

    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      isSurfacePainted: false,
      child: Material(
        color: Colors.black.withOpacity(0.3),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            height: 85.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground.resolveFrom(context),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Top Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: widget.onClose,
                      child: const Icon(CupertinoIcons.clear_circled, color: CupertinoColors.destructiveRed),
                    ),
                    Text('New Note',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold, color: CupertinoColors.label)),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: saveNote,
                      child: const Icon(CupertinoIcons.check_mark_circled, color: CupertinoColors.activeGreen),
                    ),
                  ],
                ),

                // Title Input
                CupertinoTextField(
                  controller: titleController,
                  placeholder: 'Title',
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  decoration: BoxDecoration(
                    color: CupertinoColors.secondarySystemBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(height: 2.h),

                // Description / List Input
                Expanded(
                  child: isListMode ? _buildListInput() : _buildNoteInput(),
                ),

                // Footer Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() => isListMode = !isListMode),
                      child: Text(
                        isListMode ? 'Switch to Note' : 'Switch to List',
                        style: TextStyle(fontSize: 12.sp, color: CupertinoColors.activeBlue),
                      ),
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() => isPinned = !isPinned),
                      child: Icon(
                        isPinned ? CupertinoIcons.pin_fill : CupertinoIcons.pin,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNoteInput() {
    return CupertinoTextField(
      controller: descriptionController,
      placeholder: 'Write something...',
      maxLines: null,
      expands: true,
      padding: EdgeInsets.all(16),
      style: TextStyle(fontSize: 14.sp),
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemBackground,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildListInput() {
    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              const Icon(CupertinoIcons.circle, size: 20, color: CupertinoColors.systemGrey),
              SizedBox(width: 10),
              Expanded(
                child: CupertinoTextField(
                  placeholder: 'Item ${index + 1}',
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  controller: TextEditingController(text: listItems[index]),
                  onChanged: (val) => listItems[index] = val,
                  style: TextStyle(fontSize: 13.sp),
                  decoration: BoxDecoration(
                    color: CupertinoColors.secondarySystemBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              if (listItems.length > 1)
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.clear_circled, color: CupertinoColors.destructiveRed),
                  onPressed: () {
                    setState(() {
                      listItems.removeAt(index);
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
