import 'package:flutter/material.dart';
import 'package:meer_flutter/client.dart';
import 'package:meer_flutter/core/constant/app_route.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Home")),
      floatingActionButton: IconButton(
        icon: Icon(Icons.exit_to_app),
        onPressed: () async {
          await client.auth.signOutDevice();
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoute.loginScreen,
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
