import 'package:flutter/material.dart';
import 'package:mobile_test/pages/login.dart';
import 'package:mobile_test/pages/register.dart';
import '../styles.dart';

const landingPagePadding = 50.0;
final scheme = Styles.schemeMain;
final loginButtonStyle = Styles.yellowButtonStyle;
final signupButtonStyle = Styles.grayButtonStyle;

class LandingPage extends StatelessWidget {

  const LandingPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            // LOGO
            Container(
              margin: const EdgeInsets.all(landingPagePadding),
              child: Image.asset(
              'assets/homelogo.png'),
            ),
            // Login BUTTON
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(landingPagePadding, 0, landingPagePadding, 0),
              child: ElevatedButton(
                style: loginButtonStyle,
                child: const Text('LOGIN'),
                // opens login page
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage(title: 'Login Page',)),
                  );
                },
              )
            ),
            // signup button
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, landingPagePadding/2, 0, 0),
              padding: const EdgeInsets.fromLTRB(landingPagePadding, 0, landingPagePadding, 0),
              child: ElevatedButton(
                style: signupButtonStyle,
                child: const Text('SIGN UP'),
                // opens register page
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage(title: 'Register Page',)),
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}