import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:rook_demo_flutter/ui/screens/screens.dart';

const String credentialsScreenRoute = '/credentials';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({Key? key}) : super(key: key);

  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final _formKey = GlobalKey<FormState>();

  String userID = Secrets.userID;
  String clientUUID = Secrets.clientUUID;
  String clientPassword = Secrets.clientPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credentials')),
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
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (newValue) => emptyValidator(newValue),
                      onSaved: (newValue) => clientUUID = "$newValue",
                      initialValue: clientUUID,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (newValue) => emptyValidator(newValue),
                      onSaved: (newValue) => clientPassword = "$newValue",
                      initialValue: clientPassword,
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
              child: const Text('Save credentials'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: navigateToHome,
              child: const Text('Use default credentials'),
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
      Secrets.clientUUID = clientUUID;
      Secrets.clientPassword = clientPassword;

      navigateToHome();
    }
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacementNamed(homeScreenRoute);
  }
}
