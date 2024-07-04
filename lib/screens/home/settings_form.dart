import 'package:firebasetest/models/user.dart';
import 'package:firebasetest/services/database.dart';
import 'package:firebasetest/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Center(child: Text('Error loading user data'));
        } else if (snapshot.hasData) {
          UserData? userData = snapshot.data;

          if (_currentName == null) _currentName = userData!.name;
          if (_currentSugars == null) _currentSugars = userData!.sugars;
          if (_currentStrength == null) _currentStrength = userData!.strength;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Update your brew settings',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: _currentName,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Enter name...'),
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) {
                    _currentName = value;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentSugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentSugars = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Slider(
                  label: 'Brew Strength',
                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  activeColor: Colors.brown[_currentStrength ?? 100],
                  value: (_currentStrength ?? 100).toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _currentStrength = value.round();
                    });
                  },
                  min: 100,
                  max: 900,
                  divisions: 8,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                    backgroundColor:
                        WidgetStateProperty.all<Color?>(Colors.pink[400]),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData!.sugars,
                        _currentName ?? userData!.name,
                        _currentStrength ?? userData!.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No user data available'));
        }
      },
    );
  }
}