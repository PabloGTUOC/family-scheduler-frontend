import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:family_scheduler_frontend/models/user_model.dart';
import 'package:family_scheduler_frontend/services/auth_service.dart';
import 'package:family_scheduler_frontend/screens/landing_screen.dart';
import 'package:syncfusion_flutter_core/core.dart';

void main() {
  // Register Syncfusion license (replace with your actual key)
  SyncfusionLicense.registerLicense('YOUR_LICENSE_KEY');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserModel()),
        Provider<AuthService>(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Family Bank!',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: LandingPage(), // Start with the LandingPage
    );
  }
}