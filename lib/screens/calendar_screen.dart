import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar View")),
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 1,
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 9,
          endHour: 19,
        ),
      ),
    );
  }
}
