import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/common/extension/map_extensions.dart';
import 'package:rook_demo_flutter/features/auth/widget/rook_user_status.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:rook_auth/rook_auth.dart';

class RookAuthStatus extends StatefulWidget {
  const RookAuthStatus({Key? key}) : super(key: key);

  @override
  State<RookAuthStatus> createState() => _RookAuthStatusState();
}

class _RookAuthStatusState extends State<RookAuthStatus> {
  final AuthorizationProvider provider = AuthorizationProvider(
    Secrets.rookAuthUrl,
  );

  bool loading = false;
  AuthorizationResult? result;
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
        if (!loading && result != null)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(child: Text('Authorization & Features')),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.verified_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '${result?.origin.name.toUpperCase()} > Authorized until: ${result?.authorization.authorizedUntil}[UTC]',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ...?result?.authorization.features
                      .mapToList<Text, Feature, bool>(
                    (entry) => Text('${entry.key.name} ➞ ${entry.value}'),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 10),
        if (!loading && result != null) const RookUserStatus(),
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
      final authorizationResult = await provider.getAuthorization(
        Secrets.clientUUID,
      );

      setState(() {
        loading = false;
        result = authorizationResult;
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
