import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'create_family_screen.dart';
import 'join_family_screen.dart';

class FamilySelectionScreen extends StatelessWidget {
  const FamilySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${userModel.userName ?? "User"}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "How would you like to proceed?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateFamilyScreen()),
                );
              },
              child: Text("Create a New Family"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinFamilyScreen()),
                );
              },
              child: Text("Join an Existing Family"),
            ),
          ],
        ),
      ),
    );
  }
}
