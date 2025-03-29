import 'package:flutter/material.dart';
import 'package:mobile_test/overlays.dart';
import 'package:mobile_test/pages/home/homepage.dart';
import '../styles.dart';
import 'package:mobile_test/calls.dart';

final buttonStyle = Styles.yellowButtonStyle;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  // void initState(){
  //   super.initState();
  //
  //   usernameController.addListener(() => setState(() {}));
  //   passwordController.addListener(() => setState(() {}));
  // }
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBarBlank(),
      bottomNavigationBar: BottomBarBlank(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 45.0,
          children: <Widget>[

          //LOGIN stripe
            Material(
              elevation: 4,
              child: Container(
                color: Styles.schemeMain.secondary,
                width: 412,
                height: 89,
                child: Center(
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Styles.schemeMain.primary,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Mulish',
                    ),
                  ),
                ),
              ),
            ),

            //textboxes and button
            Form(
              child: Column(
                spacing: 40,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //username textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: usernameController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 4.0,
                              bottom: 4.0,
                              top: 4.0
                          ),
                        hintText: 'Username',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //password textbox
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                    width: 336,
                    height: 65,
                    child: TextField(
                      controller: passwordController,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Styles.schemeMain.primary,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 4.0,
                            bottom: 4.0,
                            top: 4.0
                        ),
                        hintText: 'Password',
                        hintStyle: Styles.fieldTextStyle,
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          color: Styles.schemeMain.primary,
                          onPressed: () =>
                              setState(() =>
                              isPasswordVisible = !isPasswordVisible),
                        ),
                      ),
                      obscureText: isPasswordVisible,
                    ),
                  ),

                  //Sign in button
                  MaterialButton(
                    // onPressed: () {
                    //   //temp solution; ideally would be passed as json for login endpoint or something like that
                    //   print('username: ${usernameController.text}');
                    //   print('password: ${passwordController.text}');
                    //
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => const HomePage()),
                    //   );
                    // },
                    onPressed: ()  {
                      final username = usernameController.text.trim();
                      final password = passwordController.text;

                      if (username.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please enter both username and password'),
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                    },
                    elevation: 4,
                    color: Styles.schemeMain.secondary,
                    shape: Styles.buttonShape,
                    height: 70,
                    minWidth: 350,
                    child: Text(
                      'Sign In',
                      style: Styles.buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
