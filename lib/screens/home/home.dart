import 'package:firebasetest/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Welcome to the app!'),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
              print('Signed Out Successfully');
            },
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(Icons.person, color: Colors.black),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: const Text(
          'Hi',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
