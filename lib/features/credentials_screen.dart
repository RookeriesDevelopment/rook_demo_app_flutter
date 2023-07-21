import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/features/home_screen.dart';
import 'package:rook_demo_flutter/secrets.dart';

const String credentialsScreenRoute = '/credentials';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({Key? key}) : super(key: key);

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final _formKey = GlobalKey<FormState>();

  String userID = Secrets.userID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Set up user ID')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (newValue) => emptyValidator(newValue),
                      onSaved: (newValue) => userID = "$newValue",
                      initialValue: userID,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: setCredentials,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  void setCredentials() {
    if (_formKey.currentState?.validate() == true) {
      Secrets.userID = userID;

      Navigator.of(context).pushReplacementNamed(homeScreenRoute);
    }
  }
}
