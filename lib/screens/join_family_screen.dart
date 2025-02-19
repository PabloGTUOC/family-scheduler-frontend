import 'package:flutter/material.dart';

class JoinFamilyScreen extends StatefulWidget {
  const JoinFamilyScreen({super.key});

  @override
  _JoinFamilyScreenState createState() => _JoinFamilyScreenState();
}

class _JoinFamilyScreenState extends State<JoinFamilyScreen> {
  final TextEditingController _familyCodeController = TextEditingController();

  void _joinFamily() {
    String familyCode = _familyCodeController.text.trim();
    if (familyCode.isNotEmpty) {
      // TODO: Send request to backend to join family
      print("Joining family with code: $familyCode");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Family code cannot be empty")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join an Existing Family"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _familyCodeController,
              decoration: InputDecoration(
                labelText: "Family Code",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _joinFamily,
              child: Text("Join Family"),
            ),
          ],
        ),
      ),
    );
  }
}
