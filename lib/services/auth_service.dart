import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  // Handle Google Sign-In
  Future<GoogleSignInAccount?> handleSignIn() async {
    try {
      return await _googleSignIn.signIn();
    } catch (error) {
      print("Error during sign-in: $error");
      return null;
    }
  }

  // Handle Google Sign-Out
  Future<void> handleSignOut() => _googleSignIn.disconnect();

  // Handle Silent Sign-In
  Future<GoogleSignInAccount?> handleSignInSilently() async {
    try {
      return await _googleSignIn.signInSilently();
    } catch (error) {
      print('Error during silent sign-in: $error');
      return null;
    }
  }

  // Send user data to backend after successful sign-in
  Future<String?> handleLoginSuccess(BuildContext context, GoogleSignInAccount user) async {
    print('Google Sign-In User Data:');
    print('ID: ${user.id}');
    print('Email: ${user.email}');
    print('Display Name: ${user.displayName}');

    final response = await http.post(
      Uri.parse('http://localhost:3000/auth/register_user'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'googleId': user.id,
        'email': user.email,
        'name': user.displayName ?? "User",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User data sent to backend successfully');
      final responseData = jsonDecode(response.body);
      final userId = responseData['userId'].toString();

      // Update UserModel with Provider
      Provider.of<UserModel>(context, listen: false).setUserData(
        userId: userId,
        userName: user.displayName,
      );

      return userId;  // ✅ Return userId
    } else {
      print('Failed to send user data to backend: ${response.statusCode}');
      return null;
    }
  }

  // Handle Logout
  Future<void> handleLogout(BuildContext context, String? userId) async {
    try {
      if (userId != null) {
        final response = await http.get(
          Uri.parse('http://localhost:3000/user/logout?userId=$userId'), // ✅ Corrected Route
        );

        if (response.statusCode == 200) {
          print('✅ Logout information updated successfully on the backend');
        } else {
          print('❌ Failed to update logout information on the backend: ${response.statusCode}');
        }
      } else {
        print('⚠️ User ID is not available for logout.');
      }
    } catch (error) {
      print('❌ Error during logout: $error');
    }

    // Sign out from Google
    await _googleSignIn.signOut();

    // Clear user data from UserModel
    Provider.of<UserModel>(context, listen: false).clearUserData();
  }

  // Listen to authentication changes
  Stream<GoogleSignInAccount?> get onAuthStateChanged =>
      _googleSignIn.onCurrentUserChanged;
}
