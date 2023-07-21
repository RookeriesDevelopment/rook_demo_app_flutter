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
  RookUser? ahUser;
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
        if (!loading && hcUser != null && ahUser != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('Users')),
                  ...userData(hcUser!),
                  ...userData(ahUser!),
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

  List<Widget> userData(RookUser rookUser) {
    return [
      const SizedBox(height: 10),
      Row(
        children: [
          const Icon(Icons.verified_rounded),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '${rookUser.type.sourceOfData}: ${rookUser.id} is registered!',
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
    ];
  }

  void initialize() async {
    setState(() => loading = true);
    try {
      await Future.delayed(const Duration(seconds: 1));

      final hc = await manager.registerRookUser(
        Secrets.userID,
        UserType.healthConnect,
      );

      final ah = await manager.registerRookUser(
        Secrets.userID,
        UserType.appleHealth,
      );

      setState(() {
        loading = false;
        hcUser = hc;
        ahUser = ah;
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
