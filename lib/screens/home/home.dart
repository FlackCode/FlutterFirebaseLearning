import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasetest/models/brew.dart';
import 'package:firebasetest/screens/home/brew_list.dart';
import 'package:firebasetest/screens/home/settings_form.dart';
import 'package:firebasetest/services/auth.dart';
import 'package:firebasetest/services/database.dart';
import 'package:firebasetest/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          constraints: const BoxConstraints(minWidth: 700),
          builder: (context) {
            return Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 60.0),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: const Text(
              'Brew Crew',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.brown[400],
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                icon: const Icon(Icons.person, color: Colors.white),
              ),
              TextButton.icon(
                onPressed: showSettingsPanel,
                label: const Text('Settings',
                    style: TextStyle(color: Colors.white)),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: const BrewList()),
    );
  }
}
