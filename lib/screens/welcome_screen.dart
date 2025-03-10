import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'landing_screen.dart';
import 'package:family_scheduler_frontend/services/auth_service.dart';

class WelcomeScreen extends StatelessWidget {
  final String userName;
  const WelcomeScreen({
    super.key,
    required this.userName,
  });

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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildUserInfo(userModel), // ✅ User & Family Dashboard
              Expanded(child: _buildNavigationMenu(context)), // ✅ Navigation for Calendar
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserInfo(UserModel userModel) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("👤 ${userModel.userName ?? 'User'}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text("🏡 Family: ${userModel.familyName ?? 'No Family'}", style: TextStyle(fontSize: 16)),
            Text("🔢 Your Units Due: ${userModel.userUnitBalance ?? 0}", style: TextStyle(fontSize: 16)),
            Text("📊 Family Units Due: ${userModel.currentUnitsDue ?? 0}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationMenu(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text("Calendar View"),
          onTap: () => Navigator.pushNamed(context, '/calendar'), // ✅ Navigate to Calendar
        ),
      ],
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
}
