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
      appBar: AppBar(
        title: const Text('Credentials'),
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Set your credentials'),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (newValue) => emptyValidator(newValue),
                    onSaved: (newValue) => userID = "$newValue",
                    initialValue: userID,
                  ),
                  TextFormField(
                    validator: (newValue) => emptyValidator(newValue),
                    onSaved: (newValue) => clientUUID = "$newValue",
                    initialValue: clientUUID,
                  ),
                  TextFormField(
                    validator: (newValue) => emptyValidator(newValue),
                    onSaved: (newValue) => clientPassword = "$newValue",
                    initialValue: clientPassword,
                  ),
                ],
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
    }
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacementNamed(homeScreenRoute);
  }
}
