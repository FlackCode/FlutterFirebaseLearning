import 'package:firebase_core/firebase_core.dart';
import 'package:firebasetest/models/user.dart';
import 'package:firebasetest/screens/wrapper.dart';
import 'package:firebasetest/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBzDqAxWTDthv-WhKSGaMl2KlB9Rrd3SZI",
            appId: "1:209272503864:android:8084ef4af7ef5201a8b0cd",
            messagingSenderId: "209272503864",
            projectId: "fir-flutter-6ddd8"));
  } catch (e) {
    print('Error: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
