import 'package:firebasetest/shared/constants.dart';
import 'package:flutter/material.dart';

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
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const Text(
              'Update your brew settings',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration:
                  textInputDecoration.copyWith(hintText: 'Enter name...'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a name' : null,
              onChanged: (value) => setState(() {
                _currentName = value;
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
                decoration: textInputDecoration,
                value: _currentSugars ?? '0',
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                      value: sugar, child: Text('$sugar sugars'));
                }).toList(),
                onChanged: (value) => setState(() {
                      _currentSugars = value;
                    })),
            const SizedBox(
              height: 20,
            ),
            Slider(
              inactiveColor: Colors.brown[_currentStrength ?? 100],
              activeColor: Colors.brown[_currentStrength ?? 100],
              value: (_currentStrength ?? 100).toDouble(),
              onChanged: (value) => setState(() {
                _currentStrength = value.round();
              }),
              min: 100,
              max: 900,
              divisions: 8,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  backgroundColor:
                      WidgetStateProperty.all<Color?>(Colors.pink[400]),
                ),
                onPressed: () async {
                  print('$_currentName\n$_currentSugars\n$_currentStrength');
                },
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ));
  }
}
