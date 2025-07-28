import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Changed from abstract to a concrete reusable base widget
class BaseSheet extends StatelessWidget {
  final DateTime selectedDate;
  final String title;
  final Widget child;
  final Color? backgroundColor;

  const BaseSheet({
    Key? key,
    required this.selectedDate,
    required this.title,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title - ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            child,
          ],
        ),
      ),
    );
  }
}


class CreateTaskSheet extends StatefulWidget {
  final DateTime selectedDate;

  const CreateTaskSheet({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _CreateTaskSheetState createState() => _CreateTaskSheetState();
}

class _CreateTaskSheetState extends State<CreateTaskSheet> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return BaseSheet(
      selectedDate: widget.selectedDate,
      title: 'Add New Task',
      child: Column(
        children: [
          _buildTextField(
            controller: _taskController,
            placeholder: 'Task Title',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _descriptionController,
            placeholder: 'Description (optional)',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          _buildTimePicker(),
          const SizedBox(height: 20),
          _buildSaveButton(
            onPressed: _taskController.text.isNotEmpty
                ? () => Navigator.pop(context)
                : null,
            text: 'Save Task',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    int maxLines = 1,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      maxLines: maxLines,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildTimePicker() {
    return GestureDetector(
      onTap: _pickTime,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(CupertinoIcons.time),
            const SizedBox(width: 12),
            Text(
              _selectedTime == null
                  ? 'Add Time (optional)'
                  : 'Time: ${_selectedTime!.format(context)}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButton({VoidCallback? onPressed, required String text}) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

class PlanDaySheet extends StatefulWidget {
  final DateTime selectedDate;

  const PlanDaySheet({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _PlanDaySheetState createState() => _PlanDaySheetState();
}

class _PlanDaySheetState extends State<PlanDaySheet> {
  final List<Map<String, dynamic>> _timeBlocks = [];
  final TextEditingController _planController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseSheet(
      selectedDate: widget.selectedDate,
      title: 'Plan Your Day',
      child: Column(
        children: [
          _buildInputRow(),
          const SizedBox(height: 20),
          ..._buildTimeBlocks(),
          const SizedBox(height: 20),
          _buildSaveButton(
            onPressed: _timeBlocks.isNotEmpty
                ? () => Navigator.pop(context)
                : null,
            text: 'Save Plan',
          ),
        ],
      ),
    );
  }

  Widget _buildInputRow() {
    return Row(
      children: [
        Expanded(
          child: CupertinoTextField(
            controller: _planController,
            placeholder: 'e.g. 9:00 AM - Workout',
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: _addTimeBlock,
          child: const Icon(CupertinoIcons.add_circled, size: 32),
        ),
      ],
    );
  }

  List<Widget> _buildTimeBlocks() {
    return _timeBlocks.map((block) {
      return CupertinoListTile(
        title: Text(block['text']),
        trailing: CupertinoSwitch(
          value: block['completed'],
          onChanged: (val) => setState(() => block['completed'] = val),
        ),
      );
    }).toList();
  }

  Widget _buildSaveButton({VoidCallback? onPressed, required String text}) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton.filled(
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  void _addTimeBlock() {
    if (_planController.text.isNotEmpty) {
      setState(() {
        _timeBlocks.add({
          'text': _planController.text,
          'completed': false,
        });
        _planController.clear();
      });
    }
  }

  @override
  void dispose() {
    _planController.dispose();
    super.dispose();
  }
}

class AddNoteSheet extends StatefulWidget {
  final DateTime selectedDate;

  const AddNoteSheet({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _AddNoteSheetState createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends State<AddNoteSheet> {
  final TextEditingController _noteController = TextEditingController();
  Color _selectedColor = Colors.yellow.shade100;

  final List<Color> _colorOptions = [
    Colors.yellow.shade100,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.purple.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return BaseSheet(
      selectedDate: widget.selectedDate,
      title: 'Note',
      child: Column(
        children: [
          _buildNoteField(),
          const SizedBox(height: 16),
          _buildColorOptions(),
          const SizedBox(height: 20),
          _buildSaveButton(
            onPressed: _noteController.text.isNotEmpty
                ? () => Navigator.pop(context)
                : null,
            text: 'Save Note',
          ),
        ],
      ),
    );
  }

  Widget _buildNoteField() {
    return CupertinoTextField(
      controller: _noteController,
      placeholder: 'Write your note here...',
      maxLines: 8,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildColorOptions() {
    return Row(
      children: _colorOptions.map((color) {
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: _selectedColor == color
                  ? Border.all(color: Colors.black, width: 2)
                  : null,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveButton({VoidCallback? onPressed, required String text}) {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        color: CupertinoColors.systemGrey,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }
}