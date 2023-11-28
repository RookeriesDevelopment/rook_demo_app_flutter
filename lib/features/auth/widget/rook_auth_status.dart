import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rook_apple_health/rook_apple_health.dart';
import 'package:rook_demo_flutter/features/auth/widget/authorization_state.dart';
import 'package:rook_demo_flutter/features/auth/widget/rook_user_status.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:rook_health_connect/rook_health_connect.dart';
import 'package:rook_transmission/rook_transmission.dart';
import 'package:rook_users/rook_users.dart';

class RookAuthStatus extends StatefulWidget {
  const RookAuthStatus({Key? key}) : super(key: key);

  @override
  State<RookAuthStatus> createState() => _RookAuthStatusState();
}

class _RookAuthStatusState extends State<RookAuthStatus> {
  InitializationState transmissionInitialization = InitializationNone();
  InitializationState healthConnectInitialization = InitializationNone();
  InitializationState appleHealthInitialization = InitializationNone();
  InitializationState usersInitialization = InitializationNone();

  @override
  void initState() {
    initializeTransmission();

    if (defaultTargetPlatform == TargetPlatform.android) {
      initializeHealthConnect();
    } else {
      initializeAppleHealth();
    }

    initializeUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(child: Text('Authorization')),
            const SizedBox(height: 10),
            switch (transmissionInitialization) {
              InitializationNone _ => Container(),
              InitializationLoading _ => const Text('Loading...'),
              InitializationSuccess it => Row(
                  children: [
                    const Icon(Icons.verified_rounded),
                    const SizedBox(width: 5),
                    Text('Transmission ➞ ${it.expirationDate}'),
                  ],
                ),
              InitializationError it => Row(
                  children: [
                    const Icon(Icons.not_interested_rounded),
                    const SizedBox(width: 5),
                    Text(it.message),
                  ],
                ),
            },
            const SizedBox(height: 10),
            switch (healthConnectInitialization) {
              InitializationNone _ => Container(),
              InitializationLoading _ => const Text('Loading...'),
              InitializationSuccess it => Row(
                  children: [
                    const Icon(Icons.verified_rounded),
                    const SizedBox(width: 5),
                    Text('Health Connect ➞ ${it.expirationDate}'),
                  ],
                ),
              InitializationError it => SingleChildScrollView(
                  child: Row(
                    children: [
                      const Icon(Icons.not_interested_rounded),
                      const SizedBox(width: 5),
                      Text(it.message),
                    ],
                  ),
                ),
            },
            const SizedBox(height: 10),
            switch (appleHealthInitialization) {
              InitializationNone _ => Container(),
              InitializationLoading _ => const Text('Loading...'),
              InitializationSuccess _ => const Row(
                  children: [
                    Icon(Icons.verified_rounded),
                    SizedBox(width: 5),
                    Text('Apple Health ➞ Initialized'),
                  ],
                ),
              InitializationError it => Row(
                  children: [
                    const Icon(Icons.not_interested_rounded),
                    const SizedBox(width: 5),
                    Text(it.message),
                  ],
                ),
            },
            const SizedBox(height: 10),
            switch (usersInitialization) {
              InitializationNone _ => Container(),
              InitializationLoading _ => const Text('Loading...'),
              InitializationSuccess it => Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.verified_rounded),
                        const SizedBox(width: 5),
                        Text('Users ➞ ${it.expirationDate}'),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const RookUserStatus(),
                  ],
                ),
              InitializationError it => Row(
                  children: [
                    const Icon(Icons.not_interested_rounded),
                    const SizedBox(width: 5),
                    Text(it.message),
                  ],
                ),
            },
          ],
        ),
      ),
    );
  }

  void initializeTransmission() {
    setState(() => transmissionInitialization = InitializationLoading());

    const environment = kDebugMode
        ? RookTransmissionEnvironment.sandbox
        : RookTransmissionEnvironment.production;

    RookTransmissionConfiguration.initRookTransmission(
      Secrets.clientUUID,
      environment,
    ).then((value) {
      setState(() => transmissionInitialization = InitializationSuccess(value));
    }).catchError((exception) {
      final error = 'RookTransmissionConfiguration: $exception';

      setState(() => transmissionInitialization = InitializationError(error));
    });
  }

  void initializeHealthConnect() async {
    setState(() => healthConnectInitialization = InitializationLoading());

    const environment = kDebugMode
        ? RookHealthConnectEnvironment.sandbox
        : RookHealthConnectEnvironment.production;

    const enableNativeLogs = kDebugMode;

    try {
      final value = await RookHealthConnectConfiguration.initRookHealthConnect(
        Secrets.clientUUID,
        Secrets.secretKey,
        environment,
        enableNativeLogs,
      );

      // Needed to enable data source updates and to configure the owner of HC summaries and events
      await RookHealthConnectConfiguration.setUserID(Secrets.userID);

      setState(
          () => healthConnectInitialization = InitializationSuccess(value));
    } catch (exception) {
      final error = 'RookHealthConnectConfiguration: $exception';

      setState(() => healthConnectInitialization = InitializationError(error));
    }
  }

  void initializeAppleHealth() {
    setState(() => appleHealthInitialization = InitializationLoading());

    const environment = kDebugMode
        ? RookAppleHealthEnvironment.sandbox
        : RookAppleHealthEnvironment.production;

    RookAppleHealthConfiguration.initRookAppleHealth(
      Secrets.clientUUID,
      environment,
    ).then((value) {
      setState(() => appleHealthInitialization = InitializationSuccess(null));
    }).catchError((exception) {
      final error = 'RookAppleHealthConfiguration: $exception';

      setState(() => appleHealthInitialization = InitializationError(error));
    });
  }

  void initializeUsers() {
    setState(() => usersInitialization = InitializationLoading());

    const environment = kDebugMode
        ? RookUsersEnvironment.sandbox
        : RookUsersEnvironment.production;

    RookUsersConfiguration.initRookUsers(
      Secrets.clientUUID,
      environment,
    ).then((value) {
      setState(() => usersInitialization = InitializationSuccess(value));
    }).catchError((exception) {
      final error = 'RookUsersConfiguration: $exception';

      setState(() => usersInitialization = InitializationError(error));
    });
  }
}
