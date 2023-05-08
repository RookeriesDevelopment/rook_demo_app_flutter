import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:rook_users/rook_users.dart';

class RookUserStatus extends StatefulWidget {
  const RookUserStatus({Key? key}) : super(key: key);

  @override
  State<RookUserStatus> createState() => _RookUserStatusState();
}

class _RookUserStatusState extends State<RookUserStatus> {
  final RookUsersManager manager = RookUsersManager(
    Secrets.rookUrl,
    Secrets.clientUUID,
    Secrets.clientPassword,
  );

  bool loading = false;
  RookUser? hcUser;
  String? error;

  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (loading) const LinearProgressIndicator(),
        if (!loading && hcUser != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('Users')),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.verified_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Health Connect: ${hcUser?.id} is registered!',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 10),
        if (!loading && error != null) Text('Error: $error'),
        if (!loading && error != null)
          TextButton(
            onPressed: initialize,
            child: const Text('Try again'),
          ),
      ],
    );
  }

  void initialize() async {
    setState(() => loading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = await manager.registerRookUser(
        Secrets.userID,
        UserType.healthConnect,
      );

      setState(() {
        loading = false;
        hcUser = user;
        error = null;
      });
    } catch (e) {
      setState(() {
        loading = false;
        error = 'Error: $e';
      });
    }
  }
}
