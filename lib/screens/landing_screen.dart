import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';  // ✅ Import the AuthService
import 'family_selection_screen.dart';
import 'welcome_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthService _authService = AuthService(); // ✅ Use AuthService instance

  @override
  void initState() {
    super.initState();
    _signInSilently();
  }

  Future<void> _signInSilently() async {
    try {
      final user = await _authService.handleSignInSilently();  // ✅ Call AuthService method
      if (user != null) {
        await _processLogin(user);
      }
    } catch (error) {
      print("Silent sign-in error: $error");
    }
  }

  Future<void> _handleSignIn() async {
    try {
      final user = await _authService.handleSignIn();  // ✅ Use AuthService
      if (user != null) {
        await _processLogin(user);
      }
    } catch (error) {
      print("Error during sign-in: $error");
    }
  }

  Future<void> _processLogin(GoogleSignInAccount user) async {
    String? userId = await _authService.handleLoginSuccess(context, user); // ✅ Use AuthService function

    if (userId != null) {
      final userModel = Provider.of<UserModel>(context, listen: false);
      bool isNewUser = userModel.userId == null;  // ✅ Use UserModel to check new user

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => isNewUser ? FamilySelectionScreen() : WelcomeScreen(userName: user.displayName!),
          ),
        );
      });
    } else {
      print("❌ Login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text("Sign in with Google"),
        ),
      ),
    );
  }
}
