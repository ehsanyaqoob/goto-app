import 'package:flutter/material.dart';

class HorizontalWeekCalendar extends StatefulWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;
  final Color? primaryColor;
  final double? daySize;
  final double? dayMargin;
  final TextStyle? dayTextStyle;
  final TextStyle? selectedDayTextStyle;
  final TextStyle? weekdayTextStyle;
  final int? weeksToShow;
  final Color? selectedDayColor;
  final double? selectedDayScale;
  final Duration? animationDuration;
  final bool? showWeekdays;
  final double? selectedItemPadding;

  const HorizontalWeekCalendar({
    Key? key,
    this.selectedDate,
    this.onDateSelected,
    this.primaryColor,
    this.daySize,
    this.dayMargin,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.weekdayTextStyle,
    this.weeksToShow,
    this.selectedDayColor,
    this.selectedDayScale,
    this.animationDuration,
    this.showWeekdays,
    this.selectedItemPadding,
  }) : super(key: key);

  @override
  State<HorizontalWeekCalendar> createState() => _HorizontalWeekCalendarState();
}

class _HorizontalWeekCalendarState extends State<HorizontalWeekCalendar> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  void didUpdateWidget(HorizontalWeekCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != null && widget.selectedDate != oldWidget.selectedDate) {
      _selectedDate = widget.selectedDate!;
    }
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Default values
    final primaryColor = widget.primaryColor ?? Theme.of(context).primaryColor;
    final daySize = widget.daySize ?? 40.0;
    final dayMargin = widget.dayMargin ?? 4.0;
    final weeksToShow = widget.weeksToShow ?? 100;
    final selectedDayColor = widget.selectedDayColor ?? primaryColor;
    final selectedDayScale = widget.selectedDayScale ?? 1.2;
    final animationDuration = widget.animationDuration ?? const Duration(milliseconds: 200);
    final showWeekdays = widget.showWeekdays ?? true;
    final selectedItemPadding = widget.selectedItemPadding ?? 8.0;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weeksToShow,
            itemBuilder: (context, weekIndex) {
              final weekStartDate = DateTime.now()
                  .subtract(Duration(days: DateTime.now().weekday - 1))
                  .add(Duration(days: weekIndex * 7));
              return Row(
                children: List.generate(7, (dayIndex) {
                  final date = weekStartDate.add(Duration(days: dayIndex));
                  final isSelected = date.year == _selectedDate.year &&
                      date.month == _selectedDate.month &&
                      date.day == _selectedDate.day;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                      widget.onDateSelected?.call(date);
                    },
                    child: AnimatedContainer(
                      duration: animationDuration,
                      margin: EdgeInsets.symmetric(horizontal: dayMargin),
                      padding: EdgeInsets.all(isSelected ? selectedItemPadding : 0),
                      decoration: BoxDecoration(
                        color: isSelected ? selectedDayColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(daySize * 0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (showWeekdays) ...[
                            Text(
                              _getWeekdayName(date.weekday),
                              style: isSelected
                                  ? widget.selectedDayTextStyle ??
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )
                                  : widget.weekdayTextStyle ??
                                      TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                            const SizedBox(height: 4),
                          ],
                          Container(
                            width: daySize,
                            height: daySize,
                            alignment: Alignment.center,
                            child: Text(
                              date.day.toString(),
                              style: isSelected
                                  ? widget.selectedDayTextStyle ??
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )
                                  : widget.dayTextStyle ??
                                      TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.normal,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}