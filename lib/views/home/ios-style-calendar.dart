import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class IOSStyleCalendar extends StatefulWidget {
  final void Function(DateTime, DateTime) onDateSelected;
  final void Function(DateTime, DateTime)? onLongPressDate;

  const IOSStyleCalendar({
    Key? key,
    required this.onDateSelected,
    this.onLongPressDate,
  }) : super(key: key);

  @override
  _IOSStyleCalendarState createState() => _IOSStyleCalendarState();
}

class _IOSStyleCalendarState extends State<IOSStyleCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return _buildCalendarContainer(
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: CalendarFormat.month,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: _handleDaySelected,
        onDayLongPressed: widget.onLongPressDate,
        calendarStyle: _buildCalendarStyle(),
        headerStyle: _buildHeaderStyle(),
        daysOfWeekStyle: _buildDaysOfWeekStyle(),
      ),
    );
  }

  Widget _buildCalendarContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: [child]),
    );
  }

  CalendarStyle _buildCalendarStyle() {
    return CalendarStyle(
      todayDecoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      selectedDecoration: const BoxDecoration(
        color: CupertinoColors.activeBlue,
        shape: BoxShape.circle,
      ),
      weekendTextStyle: TextStyle(color: Colors.red.shade400),
      defaultTextStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  HeaderStyle _buildHeaderStyle() {
    return HeaderStyle(
      formatButtonVisible: false,
      titleCentered: true,
      titleTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: CupertinoColors.black,
      ),
      leftChevronIcon: const Icon(CupertinoIcons.chevron_back, size: 20),
      rightChevronIcon: const Icon(CupertinoIcons.chevron_forward, size: 20),
      leftChevronPadding: const EdgeInsets.only(left: 10),
      rightChevronPadding: const EdgeInsets.only(right: 10),
    );
  }

  DaysOfWeekStyle _buildDaysOfWeekStyle() {
    return DaysOfWeekStyle(
      weekdayStyle: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w500,
      ),
      weekendStyle: TextStyle(
        color: Colors.red.shade400,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void _handleDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
    widget.onDateSelected(selectedDay, focusedDay);
  }
}

class DateContextMenu extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onAddTaskPressed;
  final VoidCallback onPlanDayPressed;
  final VoidCallback onAddNotePressed;

  const DateContextMenu({
    Key? key,
    required this.selectedDate,
    required this.onAddTaskPressed,
    required this.onPlanDayPressed,
    required this.onAddNotePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: _buildTitle(),
      actions: _buildActionItems(),
      cancelButton: _buildCancelButton(context),
    );
  }

  Widget _buildTitle() {
    return Text(
      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  List<Widget> _buildActionItems() {
    return [
      _buildActionItem(
        text: "➕ Add Task",
        onPressed: onAddTaskPressed,
      ),
      _buildActionItem(
        text: "📅 Plan Your Day",
        onPressed: onPlanDayPressed,
      ),
      _buildActionItem(
        text: "📝 Write Note",
        onPressed: onAddNotePressed,
      ),
    ];
  }

  CupertinoActionSheetAction _buildActionItem({
    required String text,
    required VoidCallback onPressed,
  }) {
    return CupertinoActionSheetAction(
      onPressed: onPressed,
      child: Text(text),
    );
  }

  CupertinoActionSheetAction _buildCancelButton(BuildContext context) {
    return CupertinoActionSheetAction(
      isDestructiveAction: true,
      onPressed: () => Navigator.pop(context),
      child: const Text("Cancel"),
    );
  }
}