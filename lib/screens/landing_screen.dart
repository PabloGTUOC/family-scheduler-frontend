import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart'; // Assuming you have a UserModel
import 'welcome_screen.dart'; // Import WelcomeScreen

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final AuthService _authService = AuthService(); // Create an instance
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _authService.onAuthStateChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleLoginSuccess(_currentUser!);
      }
    });
    _authService.handleSignInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _authService.handleSignIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleLoginSuccess(GoogleSignInAccount user) async {
    String? userId = await _authService.handleLoginSuccess(context, user);
    if (userId != null) {
      _navigateToWelcomeScreen(context, user.displayName ?? 'User');
    }
  }

  void _navigateToWelcomeScreen(BuildContext context, String name) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(
          userName: name,
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    // Sign out from Google
    await _authService.handleSignOut();

    // Clear the current user
    setState(() {
      _currentUser = null;
    });

    // Clear user data from UserModel
    Provider.of<UserModel>(context, listen: false).clearUserData();

    print("User signed out");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Family Schedule'),
      ),
      body: Center(
        child: _currentUser == null
            ? ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Sign in with Google'),
        )
            : ElevatedButton(
          onPressed: () => _handleLogout(context), // Call logout from here
          child: Text('Sign out'),
        ),
      ),
    );
  }
}