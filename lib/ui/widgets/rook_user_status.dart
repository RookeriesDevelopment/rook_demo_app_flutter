import 'package:flutter/material.dart';
import 'package:rook_extraction_demo/users_secrets.dart';
import 'package:rook_users/rook_users.dart';

class RookUserStatus extends StatefulWidget {
  const RookUserStatus({Key? key}) : super(key: key);

  @override
  State<RookUserStatus> createState() => _RookUserStatusState();
}

class _RookUserStatusState extends State<RookUserStatus> {
  final RookUsersManager manager = RookUsersManager(
    UsersSecrets.url,
  );

  bool loading = false;
  bool registered = false;
  RookUser? rookUser;
  String? error;

  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: loading
          ? const CircularProgressIndicator()
          : Column(
              children: [
                if (registered)
                  Row(
                    children: [
                      const Icon(Icons.verified_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${rookUser?.type.name.toUpperCase()} USER: ${rookUser?.id} is registered!',
                        ),
                      ),
                    ],
                  ),
                if (!registered) Text('Error: $error'),
                if (!registered) const SizedBox(height: 20),
                if (!registered)
                  ElevatedButton(
                    onPressed: initialize,
                    child: const Text('Try again'),
                  ),
              ],
            ),
    );
  }

  void initialize() async {
    setState(() => loading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final user = await manager.registerRookUser(
        UsersSecrets.clientUUID,
        UsersSecrets.userID,
        UserType.healthConnect,
      );

      setState(() {
        loading = false;
        registered = true;
        rookUser = user;
        error = null;
      });
    } catch (e) {
      setState(() {
        loading = false;
        registered = false;
        error = 'Error: $e';
      });
    }
  }
}
