import 'package:flutter/material.dart';
import 'styles.dart';

void main() {
  runApp(const MyApp());
}

final scheme = Styles.schemeMain;
final loginButtonStyle = Styles.yellowButtonStyle;
final signupButtonStyle = Styles.grayButtonStyle;
const landingPagePadding = 50.0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: scheme,
        
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
            // SIGN UP BUTTON
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(landingPagePadding, 0, landingPagePadding, 0),
              child: ElevatedButton(
                style: loginButtonStyle,
                child: const Text('LOGIN'),
                onPressed: () {
                  print("sign up screen shows now");
                },
              )
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, landingPagePadding/2, 0, 0),
              padding: const EdgeInsets.fromLTRB(landingPagePadding, 0, landingPagePadding, 0),
              child: ElevatedButton(
                style: signupButtonStyle,
                child: const Text('SIGN UP'),
                onPressed: () {
                  print("log in screen shows now");
                },
              )
            )
          ],
        ),
      ),
    );
  }
}
