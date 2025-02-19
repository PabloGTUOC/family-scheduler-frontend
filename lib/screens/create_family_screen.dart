import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateFamilyScreen extends StatefulWidget {
  const CreateFamilyScreen({super.key});

  @override
  _CreateFamilyScreenState createState() => _CreateFamilyScreenState();
}

class _CreateFamilyScreenState extends State<CreateFamilyScreen> {
  final TextEditingController _familyNameController = TextEditingController();
  final TextEditingController _protagonistNameController = TextEditingController();

  String? _selectedRole;
  String? _selectedProtagonistType;

  final List<String> _roles = ['Parent', 'Guardian', 'Partner'];
  final List<String> _protagonistTypes = ['Child', 'Pet', 'Elderly'];

  Future<void> _createFamily() async {
    String familyName = _familyNameController.text.trim();
    String protagonistName = _protagonistNameController.text.trim();

    if (familyName.isEmpty || _selectedRole == null || protagonistName.isEmpty || _selectedProtagonistType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required!")),
      );
      return;
    }

    final userModel = Provider.of<UserModel>(context, listen: false);

    final response = await http.post(
      Uri.parse('http://localhost:3000/family/create'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'userId': userModel.userId,
        'familyName': familyName,
        'role': _selectedRole,
        'protagonistName': protagonistName,
        'protagonistType': _selectedProtagonistType,
      },
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Family created successfully!")),
      );
      Navigator.pop(context); // Return to Family Selection
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create family.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a New Family")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Family Name Input
            TextField(
              controller: _familyNameController,
              decoration: InputDecoration(labelText: "Family Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            // Select User Role Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Your Role"),
              value: _selectedRole,
              items: _roles.map((role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Protagonist Section
            Text("Protagonist (Who are you taking care of?)", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),

            // Protagonist Name Input
            TextField(
              controller: _protagonistNameController,
              decoration: InputDecoration(labelText: "Protagonist Name", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            // Protagonist Type Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Protagonist Type"),
              value: _selectedProtagonistType,
              items: _protagonistTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProtagonistType = value;
                });
              },
            ),
            SizedBox(height: 30),

            // Submit Button
            ElevatedButton(
              onPressed: _createFamily,
              child: Text("Create Family"),
            ),
          ],
        ),
      ),
    );
  }
}
