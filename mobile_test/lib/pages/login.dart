import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import '../styles.dart';

final buttonStyle = Styles.yellowButtonStyle;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      bottomNavigationBar: BottomBarBlank(),
      body: Center(
        child: Container(
          height: 50,
          child: ElevatedButton(
            style: buttonStyle,
            child: const Text('LOGIN'),
            onPressed: () {
              print("dashboard");
            },
          )
        ),
      ),
    );
  }
}