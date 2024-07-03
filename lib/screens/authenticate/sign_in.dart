import 'package:firebasetest/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ElevatedButton(
            onPressed: () async {
              dynamic result = await _auth.signInAnon();
              if (result == null) {
                print('Error signing in');
              } else {
                print('Signed in successfully');
                print(result.uid);
              }
            },
            child: Text('Sign in anonymously')),
      ),
    );
  }
}
