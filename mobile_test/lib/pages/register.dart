import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import '../styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      body: null,
      bottomNavigationBar: null,
    );
  }
}