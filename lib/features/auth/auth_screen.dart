import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/common/widget/scrollable_scaffold.dart';
import 'package:rook_demo_flutter/features/auth/widget/rook_auth_status.dart';

const String authScreenRoute = '/auth';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScrollableScaffold(
      alignment: Alignment.topCenter,
      name: 'Authorization',
      child: RookAuthStatus(),
    );
  }
}
