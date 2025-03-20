import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const scheme = ColorScheme(
  brightness: Brightness.light, 
  primary: Color.fromRGBO(0, 0, 0, 1), 
  onPrimary: Color.fromRGBO(0, 0, 0, 1), 
  secondary: Color.fromRGBO(255, 201, 4, 1), 
  onSecondary: Color(0xFFB1B1B1), 
  error: Color.fromARGB(255, 255, 0, 0),
  onError: Color.fromARGB(255, 255, 98, 98),
  surface: Color.fromRGBO(236, 236, 236, 1),
  onSurface: Color.fromRGBO(255, 201, 4, 1)
);

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
              margin: const EdgeInsets.all(50),
              child: Image.asset(
              'assets/homelogo.png'),
            ),
            // SIGN UP BUTTON
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.secondary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
                child: const Text('LOGIN'),
                onPressed: () {
                  print("sign up screen shows now");
                },
              )
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.onSecondary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
                  ),
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
