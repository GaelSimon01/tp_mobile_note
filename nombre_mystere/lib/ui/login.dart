import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifier/loginnotifier.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Provider.of<LoginInfo>(context, listen: false).login("test-user");
          },
          child: const Text("Login"),
        ),
      ),
    );
  }

}