import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/user_model.dart';
import 'landing_screen.dart';
import 'package:family_scheduler_frontend/services/auth_service.dart';

class WelcomeScreen extends StatelessWidget {
  final String userName;

  const WelcomeScreen({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () => _handleLogout(context, userModel.userId),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Welcome, ${userModel.userName ?? 'User'}!',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.week,
                    firstDayOfWeek: 1,
                    dataSource: _getCalendarDataSource(),
                    timeSlotViewSettings: TimeSlotViewSettings(
                      startHour: 9,
                      endHour: 19,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleLogout(BuildContext context, String? userId) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.handleLogout(context, userId);

    // Navigate back to the LandingPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
    );
  }

  // Sample data (replace with your actual data fetching logic)
  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];
    DateTime today = DateTime.now();

    appointments.add(Appointment(
      startTime: today.add(Duration(hours: 1)),
      endTime: today.add(Duration(hours: 3)),
      subject: 'Matteo Time',
      color: Colors.green,
    ));
    appointments.add(Appointment(
      startTime: today.add(Duration(days: 1, hours: 2)),
      endTime: today.add(Duration(days: 1, hours: 4)),
      subject: 'Coding',
      color: Colors.blue,
    ));

    return _AppointmentDataSource(appointments);
  }
}

// Data source class for the calendar
class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}