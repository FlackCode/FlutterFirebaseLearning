import 'package:firebasetest/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in to Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            label: Text(
              'Register',
              style: TextStyle(color: Colors.black),
            ),
            icon: Icon(Icons.person, color: Colors.black),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        //child: ElevatedButton(
        //    onPressed: () async {
        //      dynamic result = await _auth.signInAnon();
        //      if (result == null) {
        //        print('Error signing in');
        //      } else {
        //        print('Signed in successfully');
        //        print(result.uid);
        //      }
        //    },
        //    child: Text('Sign in anonymously')),
        // code for anonymous signin
        child: Form(
            child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: true,
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print("$email\n$password");
                },
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  backgroundColor:
                      WidgetStateProperty.all<Color?>(Colors.pink[400]),
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )),
      ),
    );
  }
}
